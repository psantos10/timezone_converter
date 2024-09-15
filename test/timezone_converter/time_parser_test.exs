defmodule TimezoneConverter.TimeParserTest do
  use ExUnit.Case

  alias TimezoneConverter.TimeParser

  test "parses a time string with hours and minutes" do
    {:ok, parsed_time} = TimeParser.parse("12:34")

    assert parsed_time == ~T[12:34:00]
  end

  test "parses a time string with hours, minutes, and seconds" do
    {:ok, parsed_time} = TimeParser.parse("12:34:56")

    assert parsed_time == ~T[12:34:56]
  end
end
