defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    list
    |> do_keep(fun, [])
    |> Enum.reverse()
  end

  defp do_keep([], _fun, acc), do: acc

  defp do_keep([head | tail], fun, acc) do
    case fun.(head) do
      true -> do_keep(tail, fun, [head | acc])
      _ -> do_keep(tail, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: keep(list, &(!fun.(&1)))

  # Other solution
  # def discard(list, fun) do
  # list
  # |> do_discard(fun, [])
  # |> Enum.reverse()
  # end

  # defp do_discard([], _fun, acc) do
  #  acc
  # end

  # defp do_discard([head | tail], fun, acc) do
  #  case fun.(head) do
  # 		true -> do_discard(tail, fun, acc)
  # 		_ -> do_discard(tail, fun, [head | acc])
  # 	end
  # end
end
