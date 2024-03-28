defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, distance_driven_in_meters: 0, battery_percentage: 100]

  def new(nickname \\ "none") do
    %RemoteControlCar { nickname: nickname }
  end

  def display_distance(%RemoteControlCar { distance_driven_in_meters: dist}) do
    "#{dist} meters"
  end

  def display_battery(%RemoteControlCar { battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar { battery_percentage: bat}) do
    "Battery at #{bat}%"
  end

  def drive(%RemoteControlCar { battery_percentage: 0, distance_driven_in_meters: dist, nickname: name}) do
      %RemoteControlCar {
        nickname: name,
        distance_driven_in_meters: dist,
        battery_percentage: 0
      }
  end

  def drive(%RemoteControlCar { battery_percentage: bat, distance_driven_in_meters: dist, nickname: name}) do
    %RemoteControlCar {
      nickname: name,
      distance_driven_in_meters: dist + 20,
      battery_percentage: bat - 1
    }
  end
end
