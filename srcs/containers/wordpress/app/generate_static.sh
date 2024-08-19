#!/bin/bash

# Define variables
name="Remy"
title="Software Developer"
skills=("Python" "Java" "Bash" "Docker")
experience=(
    '{"company": "Company Sdesdo", "start_date": "3000", "end_date": "3023", "job_title": "Software Developer", "description": "Developed and maintained web applications using various technologies."}'
    '{"company": "Company anotherSdesdo", "start_date": "3023", "end_date": "Present", "job_title": "Software Developer", "description": "Working on exciting new projects involving a lot of crazy stuff."}'
)

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

# Create skills list
skill_list=""
for skill in "${skills[@]}"; do
    skill_list+="<li>${skill}</li>"
done

# Define HTML template
html_template=$(cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Resume</title>
  <style>
    /* Add your CSS styles here */
  </style>
</head>
<body>
  <header class="header">
    <h1>${name}</h1>
    <p class="title">${title}</p>
  </header>

  <main class="main">
    <section class="about-me">
      <h2>About Me</h2>
      <p>A passionate and enthusiastic software engineer with X years of experience in developing and maintaining web applications. Skilled in various technologies including ${skills[*]}.</p>
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
      <p>Sdesdo's Github account: <a href="https://github.com/dieremy">dieRemy</a></p>
    </section>
  </main>

</body>
</html>
EOF
)

# Write the HTML content to index.html
echo "$html_template" > /var/www/html/index.html

echo "Resume website HTML generated successfully!"
