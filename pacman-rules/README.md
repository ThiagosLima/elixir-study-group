# Pac-Man

## Instructions

In this exercise, you need to translate some rules from the classic game Pac-Man into Elixir functions.

You have four rules to translate, all related to the game states.

> Don't worry about how the arguments are derived, just focus on combining the arguments to return the intended result.

### 1. Define if Pac-Man eats a ghost

Define the `Rules.eat_ghost?/2` function that takes two arguments (_if Pac-Man has a power pellet active_ and _if Pac-Man is touching a ghost_) and returns a boolean value if Pac-Man is able to eat the ghost. The function should return true only if Pac-Man has a power pellet active and is touching a ghost.

<!-- livebook:{"force_markdown":true} -->

```elixir
Rules.eat_ghost?(false, true)
# => false
```

### 2. Define if Pac-Man scores

Define the `Rules.score?/2` function that takes two arguments (_if Pac-Man is touching a power pellet_ and _if Pac-Man is touching a dot_) and returns a boolean value if Pac-Man scored. The function should return true if Pac-Man is touching a power pellet or a dot.

<!-- livebook:{"force_markdown":true} -->

```elixir
Rules.score?(true, true)
# => true
```

### 3. Define if Pac-Man loses

Define the `Rules.lose?/2` function that takes two arguments (_if Pac-Man has a power pellet active_ and _if Pac-Man is touching a ghost_) and returns a boolean value if Pac-Man loses. The function should return true if Pac-Man is touching a ghost and does not have a power pellet active.

<!-- livebook:{"force_markdown":true} -->

```elixir
Rules.lose?(false, true)
# => true
```

### 4. Define if Pac-Man wins

Define the `Rules.win?/3` function that takes three arguments (_if Pac-Man has eaten all of the dots_, _if Pac-Man has a power pellet active_, and _if Pac-Man is touching a ghost_) and returns a boolean value if Pac-Man wins. The function should return true if Pac-Man has eaten all of the dots and has not lost based on the arguments defined in part 3.

<!-- livebook:{"force_markdown":true} -->

```elixir
Rules.win?(false, true, false)
# => false
```

## Code

```elixir
defmodule Rules do
  def eat_ghost?(power_pellet_active, touching_ghost) do
    power_pellet_active and touching_ghost
  end

  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet or touching_dot
  end

  def lose?(power_pellet_active, touching_ghost) do
    touching_ghost and not power_pellet_active
  end

  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
  end
end
```

## Tests

```elixir
ExUnit.start(autorun: false, exclude: [pending: true])

defmodule RulesTest do
  use ExUnit.Case

  describe "eat_ghost?/2" do
    @tag task_id: 1
    test "ghost gets eaten" do
      assert Rules.eat_ghost?(true, true)
    end

    @tag task_id: 1
    test "ghost does not get eaten because no power pellet active" do
      refute Rules.eat_ghost?(false, true)
    end

    @tag task_id: 1
    test "ghost does not get eaten because not touching ghost" do
      refute Rules.eat_ghost?(true, false)
    end
  end

  describe "score?/2" do
    @tag task_id: 2
    test "score when eating dot" do
      assert Rules.score?(false, true)
    end

    @tag task_id: 2
    test "score when eating power pellet" do
      assert Rules.score?(true, false)
    end

    @tag task_id: 2
    test "no score when nothing eaten" do
      refute Rules.score?(false, false)
    end
  end

  describe "lose?/2" do
    @tag task_id: 3
    test "lose if touching a ghost without a power pellet active" do
      assert Rules.lose?(false, true)
    end

    @tag task_id: 3
    test "don't lose if touching a ghost with a power pellet active" do
      refute Rules.lose?(true, true)
    end

    @tag task_id: 3
    test "don't lose if not touching a ghost" do
      refute Rules.lose?(true, false)
    end
  end

  describe "win?/3" do
    @tag task_id: 4
    test "win if all dots eaten" do
      assert Rules.win?(true, false, false)
    end

    @tag task_id: 4
    test "don't win if all dots eaten, but touching a ghost" do
      refute Rules.win?(true, false, true)
    end

    @tag task_id: 4
    test "win if all dots eaten and touching a ghost with a power pellet active" do
      assert Rules.win?(true, true, true)
    end
  end
end

ExUnit.run()
```
