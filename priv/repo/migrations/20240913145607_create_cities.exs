defmodule TimezoneConverter.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :country, :string, null: false
      add :city, :string, null: false
      add :latitude, :float
      add :longitude, :float
      add :timezone, :string, null: false
      add :utcoffset, :float

      timestamps(type: :utc_datetime)
    end

    create index(:cities, [:city])
  end
end
