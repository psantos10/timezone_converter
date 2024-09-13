defmodule TimezoneConverterWeb.TimezoneConverterLive do
  use TimezoneConverterWeb, :live_view

  def mount(_params, _session, socket) do
    timezones = [%{city_name: "Hamburg", time: "16:52", timezone: "CEST"}]
    selected_time = current_local_time()

    socket =
      assign(socket,
        selected_time: selected_time,
        timezones: timezones
      )

    {:ok, socket}
  end

  defp current_local_time do
    {_, erl_time} = :calendar.local_time()
    {:ok, time} = Time.from_erl(erl_time)

    Calendar.strftime(time, "%H:%M")
  end
end
