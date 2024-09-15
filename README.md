# TimezoneConverter

## Getting Started

Follow these steps to set up and run the Phoenix application:

### 1. Database Setup

- Ensure that PostgreSQL is installed and running locally.
- Update the database credentials in `config/dev.exs` to match your local setup.

### 2. Installation

- Install dependencies and set up the database by running:

```bash
mix setup
```
- Import the cities data from the SQL file by running:

```bash
mix run priv/repo/import_sql_cities.exs
```

### 3. Running the Server

Start the Phoenix server with:
```bash
mix phx.server
```

Or, if you want to run it inside IEx (Interactive Elixir):

```bash
iex -S mix phx.server
```
### 4. Access the Application

Open your browser and navigate to http://localhost:4000 to access the app.
