defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @handshake_bits %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump",
  }

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    cmd = @handshake_bits
    |> Stream.filter(fn { mask, _ } -> Bitwise.band(mask, code) > 0 end)
    |> Enum.map(fn { _, cmd } -> cmd end)

    if Bitwise.band(code, 16) > 0 do
      Enum.reverse(cmd)
    else
      cmd
    end
  end
end
