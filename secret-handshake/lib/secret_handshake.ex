defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @secret %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }

  @spec commands(code :: integer) :: list(String.t())
  # def commands(code), do: commands(code, [])
  # def commands(code, acc) when (code &&& 1) > 0, do: [@secret[1] | acc]
  # def commands(code, acc) when (code &&& 2) > 0, do: [@secret[2] | acc]
  # def commands(code, acc) when (code &&& 4) > 0, do: [@secret[4] | acc]
  # def commands(code, acc) when (code &&& 8) > 0, do: [@secret[8] | acc]

  def commands(code) do
    # Integer.digits(code, 2) |> Enum.reverse |> Enum.with_index

    response = Enum.reduce(@secret, [], fn { key, value }, acc ->
      if (code &&& key) > 0 do
        [value | acc]
      else
        acc
      end 
    end)

    if (code &&& 16) == 0 do
      Enum.reverse(response)
    else
      response
    end
  end
end
