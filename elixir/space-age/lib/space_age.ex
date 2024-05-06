defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @orbital_periods_in_earth_years %{
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    earth: 1.0,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132,
  }

  @seconds_in_earth_year 31557600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    with {:ok, orbital_period} <- Map.fetch(@orbital_periods_in_earth_years, planet),
         earth_seconds <- seconds / orbital_period,
         earth_years <- earth_seconds / @seconds_in_earth_year do
      {:ok, earth_years}
    else
      _ -> {:error, "not a planet"}
    end
  end
end
