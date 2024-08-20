#!/bin/bash

# Define variables
name="Remy"
title="Software Developer"
skills=("Python" "Bash" "Docker")
urls=("https://www.python.org/" "https://www.gnu.org/software/bash/" "https://www.docker.com/")

experience=(
    '{"company": "Company Sdesdo", "start_date": "3000", "end_date": "3023", "job_title": "Software Developer", "description": "Developed and maintained web applications using various technologies."}'
    '{"company": "Company anotherSdesdo", "start_date": "3023", "end_date": "Present", "job_title": "Software Developer", "description": "Working on exciting new projects involving a lot of crazy stuff."}'
)

cat_file="/var/www/html/cat-meme-png.png"

# CSS
CSS_Style+="
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }

    header {
      text-align: center;
    }

    h1, h2 {
      color: #333;
    }

    .about-me, .experience, .skills, .contact {
      margin-bottom: 20px;
    }

    .skills-list {
      display: flex;
      flex-wrap: wrap;
      list-style: none;
      padding: 0;
    }

    .skills-list li {
      margin: 5px;
      background-color: #f0f0f0;
      padding: 10px;
      border-radius: 5px;
    }

    #toggle-image {
      display: none;
      max-width: 200px;
      margin-top: 10px;
    }

    #toggle-button {
      position: absolute;
      top: 20px;
      left: 20px;
      padding: 10px 15px;
      background-color: #007BFF;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      z-index: 1; /* Ensure the button is above the image */
    }

    #toggle-button:hover {
      background-color: #0056b3;
    }

    .image-toggle {
      position: absolute;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
    }
"

# Create experience list
experience_list=""
for exp in "${experience[@]}"; do
    company=$(echo "$exp" | jq -r '.company')
    start_date=$(echo "$exp" | jq -r '.start_date')
    end_date=$(echo "$exp" | jq -r '.end_date')
    job_title=$(echo "$exp" | jq -r '.job_title')
    description=$(echo "$exp" | jq -r '.description')
    experience_list+="<li>
        <h3>${company} (${start_date} - ${end_date})</h3>
        <p>${job_title} - ${description}</p>
        </li>"
done

# Create skill list
skill_list=""
for i in "${!skills[@]}"; do
  skill="${skills[$i]}"
  url="${urls[$i]}"
  skill_list+="<li><a href='${url}'>${skill}</a></li>"
done

# Define HTML template
html_template=$(cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Resume</title>
  <style>${CSS_Style}</style>
</head>
<body>
  <button id="toggle-button" onclick="toggleImage()">Toggle Image</button>

  <section class="image-toggle">
    <img id="toggle-image" src="file:'${cat_file}'" alt="Placeholder Image">
  </section>

  <header class="header">
    <h1>${name}</h1>
    <p class="title">${title}</p>
  </header>

  <main class="main">
    <section class="about-me">
      <h2>About Me</h2>
      <p>A passionate and enthusiastic developer with 5 minutes experience in developing and maintaining web applications. Skilled in various technologies including ${skills[*]}.</p>
    </section>

    <section class="experience">
      <h2>Experience</h2>
      <ul>
        ${experience_list}
      </ul>
    </section>

    <section class="skills">
      <h2>Skills</h2>
      <ul class="skills-list">
        ${skill_list}
      </ul>
    </section>

    <section class="contact">
      <h2>Contact</h2>
      <p>Sdesdo's Github account: <a href="https://github.com/dieremy">dieremy</a></p>
    </section>
  </main>

  <script>
    function toggleImage() {
      var image = document.getElementById('toggle-image');
      if (image.style.display === 'none') {
        image.style.display = 'block';
      } else {
        image.style.display = 'none';
      }
    }
  </script>

</body>
</html>
EOF
)

# Write the HTML content to index.html
echo "$html_template" > /var/www/html/index.html

echo "Resume website HTML generated successfully!"
