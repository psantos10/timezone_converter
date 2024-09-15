defmodule TimezoneConverter.TimezoneTest do
  use ExUnit.Case

  alias TimezoneConverter.Timezone

  test "converts a string time from one timezone to another" do
    converted_time = Timezone.convert_time("12:34", "Europe/Lisbon", "America/Los_Angeles")

    assert converted_time == ~T[04:34:00]
  end

  test "converts a time from one timezone to another" do
    {:ok, time} = Time.new(12, 35, 32)
    converted_time = Timezone.convert_time(time, "Europe/Lisbon", "America/Los_Angeles")

    assert converted_time == ~T[04:35:32]
  end
end
