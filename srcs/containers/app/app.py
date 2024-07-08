name = "Remy"
title = "Software Developer"
skills = ["Python", "Java", "Bash", "Docker"]
experience = [
	{
		"company": "Company Sdesdo",
		"start_date": "3000",
		"end_date": "3023",
		"job_title": "Software Developer",
		"description": "Developed and maintained web applications using various technologies."
	},
	{
		"company": "Company anotherSdesdo",
		"start_date": "3023",
		"end_date": "Present",
		"job_title": "Software Developer",
		"description": "Working on exciting new projects involving a lot of crazy stuff."
	}
]


def create_resume_html(name, title, skills, experience):
	"""
	Generates HTML content for a simple resume website.

	Args:
		name: Your name.
		title: Your job title.
		skills: List of your skills.
		experience: A list of dictionaries containing company, dates, and job title/description.

  	Returns:
		A string containing the HTML content.
  	"""

	html_template = """
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
	<h1>{name}</h1>
	<p class="title">{title}</p>
  </header>

  <main class="main">
	<section class="about-me">
	  <h2>About Me</h2>
	  <p>A passionate and enthusiastic software engineer with X years of experience in developing and maintaining web applications. Skilled in various technologies including {skills}.</p>
	</section>

	<section class="experience">
	  <h2>Experience</h2>
	  <ul>
		{experience_list}
	  </ul>
	</section>

	<section class="skills">
	  <h2>Skills</h2>
	  <ul class="skills-list">
		{skill_list}
	  </ul>
	</section>

	<section class="contact">
	  <h2>Contact</h2>
	  <p>Sdesdo's Github account: <a href="https://github.com/dieremy">dieRemy</a></p>
	</section>
  </main>

</body>
</html>
"""

  	# Generate experience list
	experience_list = ""
	for exp in experience:
		experience_list += f"""<li>
			<h3>{exp['company']} ({exp['start_date']} - {exp['end_date']})</h3>
			<p>{exp['job_title']} - {exp['description']}</p>
			</li>
		"""

  	# Generate skill list
	skill_list = ""
	for skill in skills:
		skill_list += f"<li>{skill}</li>"

  	# Format the HTML with information
	html_content = html_template.format(
		name=name,
		title=title,
		skills=", ".join(skills),
		experience_list=experience_list,
		skill_list=skill_list
	)

	return html_content


if __name__ == '__main__':
	html_content = create_resume_html(name, title, skills, experience)

	with open("index.html", "w") as f:
		f.write(html_content)

	print("Resume website HTML generated successfully!")
