# Lasagna

## Instructions

In this exercise you're going to write some code to help you cook a brilliant lasagna from your favorite cooking book.

You have five tasks, all related to the time spent cooking the lasagna.

### 1. Define the expected oven time in minutes

Define the `Lasagna.expected_minutes_in_oven/0` method that does not take any arguments and returns how many minutes the lasagna should be in the oven. According to the cooking book, the expected oven time in minutes is 40:

<!-- livebook:{"force_markdown":true} -->

```elixir
Lasagna.expected_minutes_in_oven()
# => 40
```

### 2. Calculate the remaining oven time in minutes

Define the `Lasagna.remaining_minutes_in_oven/1` method that takes the actual minutes the lasagna has been in the oven as a argument and returns how many minutes the lasagna still has to remain in the oven, based on the expected oven time in minutes from the previous task.

<!-- livebook:{"force_markdown":true} -->

```elixir
Lasagna.remaining_minutes_in_oven(30)
# => 10
```

### 3. Calculate the preparation time in minutes

Define the `Lasagna.preparation_time_in_minutes/1` method that takes the number of layers you added to the lasagna as a argument and returns how many minutes you spent preparing the lasagna, assuming each layer takes you 2 minutes to prepare.

<!-- livebook:{"force_markdown":true} -->

```elixir
Lasagna.preparation_time_in_minutes(2)
# => 4
```

### 4. Calculate the total working time in minutes

Define the `Lasagna.total_time_in_minutes/2` method that takes two arguments: the first argument is the number of layers you added to the lasagna, and the second argument is the number of minutes the lasagna has been in the oven. The function should return how many minutes in total you've worked on cooking the lasagna, which is the sum of the preparation time in minutes, and the time in minutes the lasagna has spent in the oven at the moment.

<!-- livebook:{"force_markdown":true} -->

```elixir
Lasagna.total_time_in_minutes(3, 20)
# => 26
```

### 5. Create a notification that the lasagna is ready

Define the `Lasagna.alarm/0` method that does not take any arguments and returns a message indicating that the lasagna is ready to eat.

<!-- livebook:{"force_markdown":true} -->

```elixir
Lasagna.alarm()
# => "Ding!"
```

## Code

```elixir
defmodule Lasagna do
  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(actual_minutes) do
    expected_minutes_in_oven() - actual_minutes
  end

  def preparation_time_in_minutes(layers), do: layers * 2

  def total_time_in_minutes(layers, time) do
    preparation_time_in_minutes(layers) + time
  end

  def alarm, do: "Ding!"
end
```

## Tests

```elixir
ExUnit.start(autorun: false, exclude: [pending: true])

defmodule LasagnaTest do
  use ExUnit.Case
  # doctest Lasagna

  @tag task_id: 1
  test "expected minutes in oven" do
    assert Lasagna.expected_minutes_in_oven() === 40
  end

  @tag task_id: 2
  test "remaining minutes in oven" do
    assert Lasagna.remaining_minutes_in_oven(25) === 15
  end

  @tag task_id: 3
  test "preparation time in minutes for one layer" do
    assert Lasagna.preparation_time_in_minutes(1) === 2
  end

  @tag task_id: 3
  test "preparation time in minutes for multiple layers" do
    assert Lasagna.preparation_time_in_minutes(4) === 8
  end

  @tag task_id: 4
  test "total time in minutes for one layer" do
    assert Lasagna.total_time_in_minutes(1, 30) === 32
  end

  @tag task_id: 4
  test "total time in minutes for multiple layers" do
    assert Lasagna.total_time_in_minutes(4, 8) === 16
  end

  @tag task_id: 5
  test "notification message" do
    assert Lasagna.alarm() === "Ding!"
  end
end

ExUnit.run()
```
