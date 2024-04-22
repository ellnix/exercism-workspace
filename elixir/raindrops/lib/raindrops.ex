defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    raindrop(rem(number, 3), rem(number, 5), rem(number, 7)) || to_string(number)
  end

  defp raindrop(0, 0, 0), do: "PlingPlangPlong"
  defp raindrop(_, 0, 0), do: "PlangPlong"
  defp raindrop(0, _, 0), do: "PlingPlong"
  defp raindrop(0, 0, _), do: "PlingPlang"
  defp raindrop(_, _, 0), do: "Plong"
  defp raindrop(0, _, _), do: "Pling"
  defp raindrop(_, 0, _), do: "Plang"
  defp raindrop(_, _, _), do: nil
end
