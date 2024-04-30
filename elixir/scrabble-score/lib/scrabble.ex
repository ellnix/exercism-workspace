defmodule Scrabble do
  @letter_scores %{
    [?A, ?E, ?I, ?O, ?U, ?L, ?N, ?R, ?S, ?T] => 1,
    [?D, ?G] => 2,
    [?B, ?C, ?M, ?P] => 3,
    [?F, ?H, ?V, ?W, ?Y] => 4,
    [?K] => 5,
    [?J, ?X] =>  8,
    [?Q, ?Z] => 10
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> to_charlist
    |> Enum.map(&letter_score/1)
    |> Enum.sum
  end

  defp letter_score(letter) do
    Enum.find_value(
      @letter_scores, 0,
      fn {letters, score} -> if letter in letters, do: score end)
  end
end
