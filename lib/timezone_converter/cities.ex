defmodule TimezoneConverter.Cities do
  alias TimezoneConverter.Repo
  alias TimezoneConverter.Cities.City

  def get_city!(id), do: Repo.get!(City, id)

  def get_all_cities() do
    Repo.all(City)
  end

  def get_city_by_name(city_name) do
    City
    |> Repo.get_by(city: city_name)
  end
end
