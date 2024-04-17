defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    digits_len = length(digits)

    number == digits
              |> Stream.map(& &1 ** digits_len)
              |> Enum.sum
  end
end
