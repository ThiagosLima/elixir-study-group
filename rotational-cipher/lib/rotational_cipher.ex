defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&calc_value(&1, shift))
    |> List.to_string()
  end

  defp rotate_letter(value, shift) when value in ?A..?Z do
    ?A + rem(value - ?A + shift, 26)
  end

  defp rotate_letter(value, shift) when value in ?a..?z do
    ?a + rem(value - ?a + shift, 26)
  end

  defp rotate_letter(value, _shift) do
    value
  end
end
