defmodule ProteinTranslation do
  @codons %{"AUG" => "Methionine", "UUU" => "Phenylalanine", "UUC" => "Phenylalanine", "UUA" => "Leucine", "UUG" => "Leucine", "UCU" => "Serine", "UCC" => "Serine", "UCA" => "Serine", "UCG" => "Serine", "UAU" => "Tyrosine", "UAC" => "Tyrosine", "UGU" => "Cysteine", "UGC" => "Cysteine", "UGG" => "Tryptophan", "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP"}

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do 
    proteins = split_rna(rna)

    case is_valid?(proteins) do
      true -> 
        proteins
        |> Enum.map(fn codon -> @codons[codon] end)
        |> Enum.take_while(fn codon -> codon != "STOP" end)
        |> has_protein?()

          # |> split_in_stop()

        # case proteins do
        #  [] ->
        #    {:error, "invalid RNA"}
        #  _ ->
        #    {:ok, proteins}
        # end
        
      _ -> 
        {:error, "invalid RNA"}
    end
  end

  defp split_rna(rna) do
    rna 
    |> String.to_charlist() 
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_string/1)
  end

  defp is_valid?(rna) do
    Enum.all?(rna, fn x -> x in Map.keys(@codons) end)
  end

  defp has_protein?([]) do
    {:error, "invalid RNA"}
  end

  defp has_protein?(proteins) do
    {:ok, proteins}
  end

  # defp split_in_stop(proteins) do
    # [head | _] = 
    #  proteins
    #  |> Enum.into("", fn protein -> "#{protein} " end) 
    #  |> String.split("STOP")
    # String.split(head)
  # end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case codon in Map.keys(@codons) do
      true ->
        {:ok, @codons[codon]}
      _ ->
        {:error, "invalid codon"}
    end
  end
end
