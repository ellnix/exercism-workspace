defmodule RomanNumerals do
  @roman_chars [["I", "V", "X"], ["X", "L", "C"], ["C", "D", "M"], ["M"]]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    digits = to_string(number)
    |> String.codepoints()
    |> Enum.reverse()

    Enum.zip(digits, @roman_chars)
    |> Enum.map(&decimal_to_roman/1)
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp decimal_to_roman({digit, [large]}), do: String.duplicate(large, String.to_integer(digit))

  defp decimal_to_roman({"9", [small, _, large]}), do: small <> large

  defp decimal_to_roman({"4", [small, medium, _]}), do: small <> medium

  defp decimal_to_roman({digit, [small, medium, _]}) do
    case String.to_integer(digit) do
      d when d >= 5 -> medium <> String.duplicate(small, d - 5)
      d -> String.duplicate(small, d)
    end
  end
end
