# The Tech Stack

This is a [Phoenix](https://www.phoenixframework.org/) project bootstrapped with [SQLite3](https://hexdocs.pm/ecto_sqlite3/Ecto.Adapters.SQLite3.html).

## Running TechSchool locally

- Install [Elixir and Erlang](https://elixir-lang.org/install.html)
  - I recommend using [asdf](https://asdf-vm.com/) to manage your Elixir and Erlang versions
  - Simply run `asdf install` in the project root to install the correct versions
- Run `mix setup` to install dependencies and seed the database
- Start the Phoenix server with `mix phx.server` or inside IEx with `iex -S mix phx.server`
- Now you can visit [`localhost:4000`](http://localhost:4000) from your browser

If you just want to seed the database with courses, run `mix seed` or `mix ecto.reset` to drop the database, re-run the migrations and seed the database.

This is all it takes to get a replica of TechSchool running on your local machine, including courses and channels! We are using a bunch of json files from `priv/repo/data` to seed the database, which is SQLite3, so you don't need to install any extra software like docker or postgres. Pretty neat, huh?

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Go back

[README](../README.md)
