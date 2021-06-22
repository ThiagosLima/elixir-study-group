defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    Enum.count(strand, fn x -> x == nucleotide end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    # First approach
    # keys = [?A, ?T, ?C, ?G]
    # Map.new(keys, fn x -> {x, count(strand, x)} end)

    # Second approach
    map = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    Enum.reduce(strand, map, fn el, acc -> Map.update(acc, el, 1, fn old -> old + 1 end) end)

    # Third approach not working
    # Enum.reduce(strand, map, &Enum.frequencies/1)
  end
end
