defmodule TimezoneConverter.Cities.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :country, :string
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :timezone, :string
    field :utcoffset, :float

    timestamps(type: :utc_datetime)
  end

  def changeset(city, attrs) do
    city
    |> cast(attrs, [:country, :city, :latitude, :longitude, :timezone, :utcoffset])
    |> validate_required([:country, :city, :timezone])
  end
end
