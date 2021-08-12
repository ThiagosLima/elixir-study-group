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

  @vowels ~w(a e i o u y x)
  @vowels_char 'aeiouyx'
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do

  start =
    phrase
    |> String.to_charlist()
    |> Enum.take_while(fn x -> x not in @vowels_char end)
    |> List.to_string()
    
     case String.starts_with?(phrase, @vowels) do
      true -> phrase <> "ay"
      _ -> 
        String.replace(phrase, String.length(start), "") <> start <> "ay"
    end
  end 
end
