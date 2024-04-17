defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(n) when is_integer(n) and n > 0, do: collatz_steps(n, 0)

  defp collatz_steps(1, acc), do: acc
  defp collatz_steps(n, acc) when rem(n, 2) == 1, do: collatz_steps(3 * n + 1, acc + 1)
  defp collatz_steps(n, acc) , do: collatz_steps(div(n, 2), acc + 1)
end
