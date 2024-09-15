defmodule TimezoneConverter.TimeParser do
  def parse(time_str) when is_binary(time_str) do
    time_str
    |> String.split(":")
    |> Enum.map(&String.to_integer/1)
    |> parse()
  end

  def parse([hour, minute]) do
    Time.new(hour, minute, 0)
  end

  def parse([hour, minute, second]) do
    Time.new(hour, minute, second)
  end
end
