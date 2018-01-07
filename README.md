# PriceTracker

Elixir app for tracking prices.

## System dependencies

- Elixir 1.5.2
- Erlang 20.1
- Postgres
- Libs listed on `mix.exs`

## Decisions

- I used Environment variables to manage the API KEY, because it was the easiest way.
- The external product id is a string on database, because some there is no definition if the API will always return an integer.
- You can expose `PriceTracker.call()` as a task or script.
- I'm still learning Elixir, so I tried doing the best practices that I know.

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

- `$ mix ecto.create`
- `$ mix ecto.migrate`

### Run local

- `$ iex -S mix`
- `iex> PriceTracker.call()`

### Run the test suite

`$ mix test`
