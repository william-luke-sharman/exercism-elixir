defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = car) do
    "#{car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%RemoteControlCar{} = car) do
    "Battery at #{car.battery_percentage}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car
  
  def drive(%RemoteControlCar{} = car) do
    car
    |> Map.replace(:battery_percentage, car.battery_percentage - 1)
    |> Map.replace(:distance_driven_in_meters, car.distance_driven_in_meters + 20)
  end
end
