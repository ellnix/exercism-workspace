defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    list_of_chars = sentence
    |> String.downcase
    |> to_charlist

    alphabet = ?a..?z
    |> Enum.to_list

    alphabet -- list_of_chars == []
  end
end
