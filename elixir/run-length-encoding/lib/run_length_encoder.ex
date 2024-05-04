defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.split("")
    |> tl
    |> Stream.chunk_by(&(&1))
    |> Enum.map_join(&encode_list/1)
  end

  defp encode_list([char]), do: char
  defp encode_list(list), do: to_string(length(list)) <> hd(list)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    do_decode(string, "")
  end

  defp do_decode(<<>>, acc), do: acc
  defp do_decode(string, acc) do
    {count, <<ch, rest::bitstring>>} = 
      case Integer.parse(string) do
        :error -> {1, string}
        {count, rest} -> {count, rest}
      end

    do_decode(
      rest,
      acc <> String.duplicate(<<ch>>, count)
    )
  end
end
