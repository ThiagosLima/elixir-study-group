defmodule SecretHandshake do
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

  # use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce([], &add_text/2)
    |> Enum.reverse()
  end

  defp add_text({0, _}, acc), do: acc
  defp add_text({_, 0}, acc), do: ["wink" | acc]
  defp add_text({_, 1}, acc), do: ["double blink" | acc]
  defp add_text({_, 2}, acc), do: ["close your eyes" | acc]
  defp add_text({_, 3}, acc), do: ["jump" | acc]
  defp add_text({_, 4}, acc), do: Enum.reverse(acc)
  defp add_text({_, 5}, acc), do: acc

  # @secret %{
  #   1 => "wink",
  #   2 => "double blink",
  #   4 => "close your eyes",
  #   8 => "jump"
  # }

  # def commands(code) do
  #   response = Enum.reduce(@secret, [], fn { key, value }, acc ->
  #     if (code &&& key) > 0 do
  #       [value | acc]
  #     else
  #       acc
  #     end
  #   end)

  #   if (code &&& 16) == 0 do
  #     Enum.reverse(response)
  #   else
  #     response
  #   end
  # end

  # def commands(code), do: commands(code, [])
  # def commands(code, acc) when (code &&& 1) > 0, do: [@secret[1] | acc]
  # def commands(code, acc) when (code &&& 2) > 0, do: [@secret[2] | acc]
  # def commands(code, acc) when (code &&& 4) > 0, do: [@secret[4] | acc]
  # def commands(code, acc) when (code &&& 8) > 0, do: [@secret[8] | acc]
end
