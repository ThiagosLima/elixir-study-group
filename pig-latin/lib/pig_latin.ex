defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @vowels ~w(a e i o u)
  @vowels_char 'aeiou'
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&func/1)
    |> Enum.join(" ")
  end

  defp func(phrase) do
    start =
      phrase
      |> String.to_charlist()
      |> Enum.reduce_while([], fn x, acc ->
        if x not in @vowels_char or (get_head(acc) == ?q and x == ?u) do
          if (get_head(acc) == ?y or get_head(acc) == ?x) and x not in @vowels_char do
            {:halt, Enum.drop(acc, 1)}
          else
            {:cont, [x | acc]}
          end
        else
          {:halt, acc}
        end
      end)
      |> Enum.reverse()
      |> List.to_string()

    case String.starts_with?(phrase, @vowels) do
      true ->
        phrase <> "ay"

      _ ->
        String.replace(phrase, start, "") <> start <> "ay"
    end
  end

  defp get_head([]) do
    []
  end

  defp get_head([head | _]) do
    head
  end
end
