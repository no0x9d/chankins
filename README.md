# Chankins

## Getting started
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## What is Chankins?
Chankins manages your code changes and builds release notes for you.
It holds a your changes based on a release with additional metadata and can generate release notes from a supplied template.

## When not to use Chankins?
If you have all changes in a issue tracker like github or a jira project and you just want release notes, there are better integrated solutions.

## Model
It's possible to add key-value based parameters to each element in the hierarchy.
As types for this are booleans or text.

![Model](model.png)
