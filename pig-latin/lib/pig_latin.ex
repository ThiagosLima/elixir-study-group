defmodule PigLatin do
  @vowels 'aeiou'

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
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    word
    |> get_start()
    |> build_end(word)
  end

  defp get_start(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce_while([], &pig_latin_rules/2)
    |> Enum.reverse()
    |> List.to_string()
  end

  defp pig_latin_rules(character, consonants) do
    cond do
      are_y_or_x_considered_vowels?(consonants, character) ->
        {:halt, Enum.drop(consonants, 1)}

      qu_after_consonant?(consonants, character) ->
        {:cont, [character | consonants]}

      consonant?(character) ->
        {:cont, [character | consonants]}

      true ->
        {:halt, consonants}
    end
  end

  defp are_y_or_x_considered_vowels?(consonants, character) do
    (last_consonant_is_y?(consonants) or last_consonant_is_x?(consonants)) and
      consonant?(character)
  end

  defp last_consonant_is_y?(consonants) do
    get_last_consonant(consonants) == ?y
  end

  defp last_consonant_is_x?(consonants) do
    get_last_consonant(consonants) == ?x
  end

  defp get_last_consonant([]), do: []
  defp get_last_consonant([consonant | _]), do: consonant

  defp consonant?(character) do
    character not in @vowels
  end

  defp qu_after_consonant?(consonants, current_character) do
    get_last_consonant(consonants) == ?q and current_character == ?u
  end

  defp build_end("", word), do: word <> "ay"

  defp build_end(start, word), do: String.replace(word, start, "", global: false) <> start <> "ay"
end
