defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, fn digit -> digit < 0 || digit >= input_base end) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {
        :ok,
        digits
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.map(fn {digit, idx} -> digit * input_base ** idx end)
        |> Enum.sum
        |> decimal_to_base(output_base)
        |> Enum.reverse
      }
    end
  end

  defp decimal_to_base(decimal, base) when decimal < base, do: [decimal]
  defp decimal_to_base(decimal, base) do
    digit = rem(decimal, base)
    leftover = div(decimal, base)
    [digit | decimal_to_base(leftover, base)]
  end
end
