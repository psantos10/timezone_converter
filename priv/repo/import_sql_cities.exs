alias TimezoneConverter.Repo
alias Ecto.Adapters.SQL

file = Application.app_dir(:timezone_converter, "priv/repo/cities_with_timezone.sql")
sql_content = File.read!(file)

sql_statements = String.split(sql_content, ";\n", trim: true)

Enum.each(sql_statements, fn sql_statement ->
  unless sql_statement == "" || sql_statement == "\n" do
    IO.inspect(sql_statement, label: "Executing SQL statement")
    SQL.query!(Repo, sql_statement)
  end
end)
