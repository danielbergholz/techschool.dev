# Contributing

We love our contributors! Here's how you can contribute:

- [Open an issue](https://github.com/danielbergholz/techschool.dev/issues) if you believe you've encountered a bug.
- Make a [pull request](https://github.com/danielbergholz/techschool.dev/pull) to add new features/make quality-of-life improvements/fix bugs.

## Adding a new course

- Add a new entry on the JSON file `priv/repo/data/courses.json`. The file should have the following structure:

```jsonc
{
  "name": "Course Name",
  "youtube_course_id": "id_from_youtube",
  "locale": "en", // "en" or "pt"
  "language_names": ["Programming Language Name"], // must be present inside languages.json (case sensitive)
  "framework_names": ["Framework Name"], // must be present inside frameworks.json (case sensitive)
  "tool_names": ["Tool Name"], // must be present inside tools.json (case sensitive)
  "fundamentals_names": ["Fundamentals Name"] // must be present inside fundamentals.json (case sensitive)
}
```

- To get the `youtube_course_id`, go to the course's page on YouTube and copy the last part of the URL. For example, for a video, if the URL is `https://www.youtube.com/watch?v=kUMe1FH4CHE`, the `youtube_course_id` is `kUMe1FH4CHE`. For a playlist, if the URL is `https://www.youtube.com/watch?v=3LPWQtvxHOk&list=PLbV6TI03ZWYWwU5p9ZBH8oJTCjgneX53u`, the `youtube_course_id` is `PLbV6TI03ZWYWwU5p9ZBH8oJTCjgneX53u`.

### Important notes

The programming language, framework and tool for the course must be exactly what is being taught in the course. If the course is only about Rails, `framework_names` should be `["Rails"]` but `language_names` and `tool_names` should be empty. If the course is about Ruby, `language_names` should be `["Ruby"]` and `framework_names` and `tool_names` should be empty.

You should only add multiple languages/frameworks if the course teaches multiple languages/frameworks. For example: If there is a "complete web development" course that teaches HTML, CSS, JavaScript, SQL, Ruby, Rails and React, then `language_names` should be `["HTML", "CSS", "JavaScript", "Ruby"]`, `framework_names` should be `["Rails", "React.js"]` and `tool_names` should be `["SQL"]`.

## Adding a new website

- If you want to add an external platform/website like FreeCodeCamp or The Odin Project, add a new entry on the JSON file `priv/repo/data/platforms.json`. The file should have the following structure:

```jsonc
{
  "name": "Website Name", // case sensitive
  "description_en": "English description",
  "description_pt": "Brazilian Portuguese description",
  "url": "https://example.com/",
  "image_url": "path_to_the_website_svg", // should be inside priv/static/images/platforms
  "language_names": ["Programming Language Name"], // must be present inside languages.json (case sensitive)
  "framework_names": ["Framework Name"], // must be present inside frameworks.json (case sensitive)
  "tool_names": ["Tool Name"], // must be present inside tools.json (case sensitive)
  "fundamentals_names": ["Fundamentals Name"] // must be present inside fundamentals.json (case sensitive)
}
```

### Important note

Currently, only websites that offer completely free content should be added. If a website includes a paid version or subscription, it will not be added. The goal is to only promote free resources for learning.

## FAQ

### This is too much work, I just want to add a course!

I know. I'm working to make this whole process easier. In the meantime, if you want to add a course, just open an issue with the course details and I'll add it for you.

### What type of content can I add?

The primary focus of this plataform is web development courses. But feel free to also add content for: Data Science, Machine Learning, DevOps, Mobile Development, etc.

### What type of content can I not add?

- Content that is not related to programming. This includes: music, movies, TV shows, etc.
- Content from creators with any type of bad behavior, like: racism, sexism, homophobia, etc. This is completely unacceptable.

## Go back

[README](../README.md)
