package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"

	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/client"
)

func getScanLogs(ctx context.Context, w http.ResponseWriter, r *http.Request) {
	outputString := ctx.Value("outputString").(string)
	io.WriteString(w, outputString)
}

func main() {
	// Create a Docker client
	ctx := context.Background()
	cli, err := client.NewClientWithOpts(client.WithVersion("1.45"), client.FromEnv)
	if err != nil {
		panic(err)
	}

	// Check if the Docker socket is mounted
	if _, err := os.Stat("/var/run/docker.sock"); err != nil {
		fmt.Println("Docker socket is not mounted. Please ensure it's accessible.")
		return
	}

	// Define a buffer to store output
	var buffer bytes.Buffer

	cmdOut := io.MultiWriter(&buffer)

	// Get a list of running containers
	containers, err := cli.ContainerList(context.Background(), container.ListOptions{})
	if err != nil {
		fmt.Printf("Error getting container list: %v\n", err)
		return
	}

	// Iterate through each container
	for _, container := range containers {
		fmt.Fprintf(cmdOut, "Inspecting container: %s\n", container.ID)

		// Inspect the container to get the image ID
		inspect, err := cli.ContainerInspect(ctx, container.ID)
		if err != nil {
			fmt.Fprintf(cmdOut, "Error inspecting container: %v\n", err)
			continue
		}

		// Scan the image using grype, redirect grype Std.OUT || Std.ERR 
		cmd := exec.Command("grype", inspect.Image)
		cmd.Stdout = cmdOut
		cmd.Stderr = cmdOut

		err = cmd.Run()
		if err != nil {
			fmt.Fprintf(cmdOut, "Error scanning image: %v\n", err)
			continue
		}
	}

	outputString := buffer.String()
	ctx = context.WithValue(context.Background(), "outputString", outputString)

	// Handle requests and pass the context to getScanLogs
	http.HandleFunc("/api/v1/logs", func(w http.ResponseWriter, r *http.Request) {
		getScanLogs(ctx, w, r)
	})

	fmt.Println("Listening on :3000")
	err = http.ListenAndServe(":3000", nil)
	if err != nil {
		return
	}
}
