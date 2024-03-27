defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna([dna | rest]) do
    rna = case dna do
      ?A -> ?U
      ?C -> ?G
      ?T -> ?A
      ?G -> ?C
    end

    [rna | to_rna(rest)]
  end

  def to_rna([]), do: []
end
