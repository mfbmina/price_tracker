# PriceTracker

Elixir app for tracking prices.

## System dependencies

- Elixir 1.5.2
- Erlang 20.1
- Postgres
- Libs listed on `mix.exs`

## Decisions & Comments

- I'm still studying Elixir, so I tried doing the best practices that I know.
- I used Environment variables to manage the API KEY, because it was the easiest way.
- The external product id is a string on database, because some there is no definition if the API will always return an integer as ID (some old projects use strings).
- You can use this repo as a task or script.
- I've choose dependencies based on their popularity.
- Used `ex_doc` for documentation. It generates HTML files for the docs.
- Used `ecto` to interact with the database. It helped my with all queries.
- `postgrex` is a PostgreSQL driver for Elixir.
- Used `httpoison` as HTTP client. It helped me building my API Client.
- Used `poison` to parse JSON requests.
- Followed `credo` (https://github.com/rrrene/credo) style guide. It helped my code consistency.

## Setup

### Clone the project

`$ git clone https://github.com/mfbmina/price_tracker`

### Move to the directory

`$ cd price_tracker`

### Export your API key

`$ export API_KEY="YOUR_API_KEY"`

### Installing dependencies

`$ mix deps.get`

### Database setup

```
$ mix ecto.create
$ mix ecto.migrate
```

### Run local

```
$ iex -S mix
iex> Date.range(~D[2018-01-01], Date.utc_today) |> PriceTracker.call
```

### Run the test suite

`$ mix test`

### Generating docs

`$ mix docs`
