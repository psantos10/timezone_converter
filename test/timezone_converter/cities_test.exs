defmodule TimezoneConverter.CitiesTest do
  use TimezoneConverter.DataCase, async: true

  alias TimezoneConverter.Cities
  alias TimezoneConverter.Cities.City

  @valid_city_attrs %City{
    country: "United States",
    city: "New York",
    timezone: "America/New_York"
  }
  @valid_city_2_attrs %City{country: "England", city: "London", timezone: "Europe/London"}

  setup do
    {:ok, city} = Repo.insert(@valid_city_attrs)
    {:ok, city2} = Repo.insert(@valid_city_2_attrs)

    %{city: city, city2: city2}
  end

  describe "get_city!/1" do
    test "retrieves a city by id", %{city: city} do
      result = Cities.get_city!(city.id)

      assert result.id == city.id
      assert result.city == "New York"
      assert result.country == "United States"
      assert result.timezone == "America/New_York"
    end

    test "raises an error if city is not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Cities.get_city!(-1)
      end
    end
  end

  describe "get_all_cities/0" do
    test "retrieves all cities", %{city: city, city2: city2} do
      result = Cities.get_all_cities()

      assert Enum.count(result) == 2
      assert city in result
      assert city2 in result
    end
  end

  describe "get_city_by_name/1" do
    test "retrieves a city by name", %{city: city} do
      result = Cities.get_city_by_name("New York")

      assert result.id == city.id
      assert result.city == "New York"
    end

    test "returns nil if city name does not exist" do
      assert Cities.get_city_by_name("Nonexistent City") == nil
    end
  end
end
