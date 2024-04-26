defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, 0), do: text
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(fn ch -> do_rotate(ch, shift) end)
    |> to_string
  end

  defp do_rotate(ch, shift) when ch >= 65 and ch <= 90, do: rem(ch + shift - 65, 26) + 65
  defp do_rotate(ch, shift) when ch >= 97 and ch <= 122, do: rem(ch + shift - 97, 26) + 97
  defp do_rotate(ch, _), do: ch
end
