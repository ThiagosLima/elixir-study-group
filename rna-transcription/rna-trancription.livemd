# RNA Transcription

## Description

Given a DNA strand, return its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`

## Code

```elixir
defmodule RnaTranscription do
  @dna_to_rna %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(fn nucleodite -> @dna_to_rna[nucleodite] end)
  end
end
```

## Tests

```elixir
ExUnit.start(autorun: false, exclude: [pending: true])

defmodule RnaTranscriptionTest do
  use ExUnit.Case

  # @tag :pending
  test "transcribes guanine to cytosine" do
    assert RnaTranscription.to_rna('G') == 'C'
  end

  # @tag :pending
  test "transcribes cytosine to guanine" do
    assert RnaTranscription.to_rna('C') == 'G'
  end

  # @tag :pending
  test "transcribes thymidine to adenine" do
    assert RnaTranscription.to_rna('T') == 'A'
  end

  # @tag :pending
  test "transcribes adenine to uracil" do
    assert RnaTranscription.to_rna('A') == 'U'
  end

  # @tag :pending
  test "it transcribes all dna nucleotides to rna equivalents" do
    assert RnaTranscription.to_rna('ACGTGGTCTTAA') == 'UGCACCAGAAUU'
  end
end

ExUnit.run()
```
