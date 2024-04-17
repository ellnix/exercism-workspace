defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    search(String.downcase(base), normalize(base), candidates)
  end

  defp search(_, _, []), do: []
  defp search(base, normalized_base, [candidate | other_candidates]) do
    if base != String.downcase(candidate) and normalized_base == normalize(candidate) do
      [candidate | search(base, normalized_base, other_candidates)]
    else
      search(base, normalized_base, other_candidates)
    end
  end

  defp normalize(string) do
    string
    |> String.downcase
    |> String.split("")
    |> Enum.sort
    |> Enum.join
  end
end
