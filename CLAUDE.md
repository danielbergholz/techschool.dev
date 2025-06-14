# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TechSchool.dev is a Phoenix LiveView application that curates free programming courses from YouTube and other platforms. The mission is to make tech education accessible by highlighting quality free resources.

## Development Commands

After making ANY code changes, you MUST run these commands:

```bash
mix format
mix check
```

- `mix format` ensures consistent code formatting
- `mix check` verifies compilation and suggests improvements

### Available MCPs for Development

**Tidewave MCP** (for Elixir/Phoenix development):

- Execute SQL queries against the database
- Run Elixir code in project context
- Introspect application logs and runtime
- Fetch documentation from Hex docs
- View all Ecto schemas
- Debug LiveView processes

**Context7 MCP** (for external documentation):

- Fetch up-to-date docs not available in Hex (Tailwind, Heroicons, DaisyUI, etc.)
- Get current API references for frontend libraries

## Architecture

### Tech Stack

- **Backend**: Elixir/Phoenix 1.7.12 with LiveView 1.0.1
- **Database**: SQLite3 (via ecto_sqlite3)
- **Frontend**: Phoenix LiveView + Tailwind CSS
- **Build**: esbuild for JavaScript bundling
- **HTTP Client**: Req for external API calls
- **Caching**: Cachex
- **i18n**: Gettext (English and Portuguese)

### Key Directories

- `lib/techschool/` - Business logic contexts (courses, languages, frameworks, etc.)
- `lib/techschool_web/` - Web layer (LiveViews, components, controllers)
- `priv/repo/data/` - JSON seed data files for content management
- `assets/` - Frontend assets (CSS, JS, Tailwind config)

### Data Management

Content is managed via JSON files in `priv/repo/data/`:

- `courses.json` - Course definitions with YouTube IDs
- `languages.json`, `frameworks.json`, `tools.json` - Taxonomy data
- `platforms.json` - External learning platforms
- `bootcamps.json` - Learning paths

### Adding New Courses

1. Add entry to `priv/repo/data/courses.json` with structure:
   ```json
   {
     "name": "Course Name",
     "youtube_course_id": "youtube_id_or_playlist_id",
     "locale": "en",
     "language_names": ["Language"],
     "framework_names": ["Framework"],
     "tool_names": ["Tool"],
     "fundamentals_names": ["Fundamentals"]
   }
   ```
2. Run `mix seed` to update database

### Testing

- Tests cover both business logic and JSON data validation
- Use `mix test` to run full test suite
- JSON schema validation ensures data integrity

### Internationalization

- Routes use locale prefix: `/:locale/courses`
- Locale persistence via plugs and LiveView hooks
- Gettext for translations in `priv/gettext/`

### Deployment

- Containerized with Docker (multi-stage build)
- Deployed to Fly.io with SQLite volume mounting
- Uses `fly.toml` for configuration
