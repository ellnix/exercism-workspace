defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, & &1 + 1)
    |> Stream.filter(&prime?/1)
    |> Enum.at(count - 1)
  end

  defp prime?(n) do
    Range.new(2, trunc(n ** 0.5), 1)
    |> Enum.all?(fn divisor -> rem(n, divisor) != 0 end)
  end
end
