# | Unit to convert | volume | in milliliters (mL) |
# | --------------- | ------ | ------------------- |
# | mL              | 1      | 1                   |
# | US cup          | 1      | 240                 |
# | US fluid ounce  | 1      | 30                  |
# | US teaspoon     | 1      | 5                   |
# | US tablespoon   | 1      | 15                  |

defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    { _unit, volume } = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    { unit, volume } = volume_pair

    { :milliliter, mils_in_unit(unit) * volume}
  end

  def from_milliliter(volume_pair, unit) do
    { unit, get_volume(volume_pair) / mils_in_unit(unit) }
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end

  defp mils_in_unit(unit) do
    case unit do
      :milliliter -> 1
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
    end
  end
end
