# | Nucleic Acid | Code   |
# | ------------ | ------ |
# | a space      | `0000` |
# | A            | `0001` |
# | C            | `0010` |
# | G            | `0100` |
# | T            | `1000` |

defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
      _ -> 0
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
      0 -> ? 
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc
  defp do_encode([head | rest], acc) do
    head = encode_nucleotide(head)
    do_encode(rest, <<acc::bitstring, head::4>>)
  end

  def decode(dna) do
    Enum.reverse(do_decode(dna, []))
  end

  defp do_decode(<<>>, acc), do: acc
  defp do_decode(<<head::4, rest::bitstring>>, acc) do
    head = decode_nucleotide(head)
    do_decode(rest, [head | acc])
  end
end
