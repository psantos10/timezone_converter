defmodule TimezoneConverterWeb.TimezoneConverterLive do
  use TimezoneConverterWeb, :live_view

  alias TimezoneConverter.Cities
  alias TimezoneConverter.Timezone

  def mount(_params, _session, socket) do
    timezones = []
    selected_time = current_local_time()
    cities = Cities.get_all_cities()

    if connected?(socket) do
      :timer.send_interval(1000, self(), :set_current_time)
    end

    socket =
      assign(socket,
        time_live_update?: true,
        selected_time: selected_time,
        timezones: timezones,
        cities: cities,
        client_timezone: get_connect_params(socket)["client_timezone"]
      )

    {:ok, socket}
  end

  def handle_info(:set_current_time, socket) do
    time_live_update? = socket.assigns.time_live_update?

    if time_live_update? do
      timezones =
        Enum.map(socket.assigns.timezones, fn tz ->
          %{
            id: tz.id,
            city_name: tz.city_name,
            time:
              Timezone.convert_time(
                socket.assigns.selected_time,
                socket.assigns.client_timezone,
                tz.timezone
              ),
            timezone: tz.timezone
          }
        end)

      socket =
        socket
        |> assign(:timezones, timezones)
        |> assign(:selected_time, current_local_time())

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("manual_time_update", %{"current_time" => selected_time}, socket) do
    timezones =
      Enum.map(socket.assigns.timezones, fn tz ->
        %{
          id: tz.id,
          city_name: tz.city_name,
          time:
            Timezone.convert_time(
              socket.assigns.selected_time,
              socket.assigns.client_timezone,
              tz.timezone
            ),
          timezone: tz.timezone
        }
      end)

    socket =
      socket
      |> assign(:time_live_update?, false)
      |> assign(:selected_time, selected_time)
      |> assign(:timezones, timezones)

    {:noreply, socket}
  end

  def handle_event("set_current_time", %{}, socket) do
    socket =
      socket
      |> assign(:time_live_update?, true)
      |> assign(:selected_time, current_local_time())

    {:noreply, socket}
  end

  def handle_event("submit_city", %{"city" => city}, socket) do
    city_id =
      String.split(city, "-")
      |> List.first()
      |> String.trim()
      |> String.to_integer()

    city = Cities.get_city!(city_id)

    city_time =
      Timezone.convert_time(
        socket.assigns.selected_time,
        socket.assigns.client_timezone,
        city.timezone
      )

    timezone = %{
      id: city.id,
      city_name: city.city,
      time: city_time,
      timezone: city.timezone
    }

    timezones = [timezone | socket.assigns.timezones]

    {:noreply, assign(socket, :timezones, timezones)}
  end

  def handle_event("remove_city", %{"id" => city_id}, socket) do
    timezones =
      Enum.filter(socket.assigns.timezones, fn tz ->
        tz.id != String.to_integer(city_id)
      end)

    {:noreply, assign(socket, :timezones, timezones)}
  end

  defp current_local_time do
    {_, erl_time} = :calendar.local_time()
    {:ok, time} = Time.from_erl(erl_time)

    time
  end
end
