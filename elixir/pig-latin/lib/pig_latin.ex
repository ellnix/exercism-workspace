defmodule PigLatin do
  @xy_followed_by_consonant ~r/^[xy][^aeiou]/i
  @consonant_ending_in_qu ~r/^([^aeiou]*qu)(.+)/i
  @consonant_cluster ~r/^([^aeiou][^aeiouy]*)(.+)/i
  @vowel ~r/^[aeiou]/i 
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&pigify/1)
    |> Enum.join(" ")
  end

  defp pigify([word]), do: word <> "ay"
  defp pigify([_, consonant_cluster, rest]) do
    rest <> consonant_cluster <> "ay"
  end

  defp pigify(word) do
    cond do
      word =~ @xy_followed_by_consonant -> 
        pigify([word])

      match = Regex.run(@consonant_ending_in_qu, word) -> 
        pigify(match)
        
      match = Regex.run(@consonant_cluster, word) -> 
        pigify(match)

      word =~ @vowel -> 
        pigify([word])
    end
  end
end
