defmodule TimezoneConverter.Timezone do
  alias TimezoneConverter.TimeParser

  def convert_time(time_str, from_tz, to_tz) when is_binary(time_str) do
    {:ok, time} = TimeParser.parse(time_str)
    convert_time(time, from_tz, to_tz)
  end

  def convert_time(time, from_tz, to_tz) do
    with {:ok, naive_datetime} <- NaiveDateTime.new(Timex.today(), time),
         {:ok, datetime} <- DateTime.from_naive(naive_datetime, from_tz),
         {:ok, converted_time} <- DateTime.shift_zone(datetime, to_tz) do
      DateTime.to_time(converted_time)
    else
      error -> error
    end
  end
end
