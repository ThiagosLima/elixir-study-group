defmodule ResistorColor do
  @moduledoc false

  @colors %{
    "black" => 0,
    "brown" => 1,
    "red" => 2,
    "orange" => 3,
    "yellow" => 4,
    "green" => 5,
    "blue" => 6,
    "violet" => 7,
    "grey" => 8,
    "white" => 9
  }

  @spec colors() :: list(String.t())
  def colors do
    @colors
    |> Map.to_list()
    |> List.keysort(1)
    |> Enum.map(fn {color, _} -> color end)
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    @colors[color]
  end
end
