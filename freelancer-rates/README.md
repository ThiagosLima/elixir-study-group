# Freelancer Rates

## Instructions

In this exercise you'll be writing code to help a freelancer communicate with a project manager by providing a few utilities to quickly calculate daily and
monthly rates, optionally with a given discount.

We first establish a few rules between the freelancer and the project manager:

* The daily rate is 8 times the hourly rate.
* A month has 22 billable days.

The freelancer is offering to apply a discount if the project manager chooses to let the freelancer bill per month, which can come in handy if there is a certain budget the project manager has to work with.

Discounts are modeled as fractional numbers representing percentage, for example `25.0` (25%).

### 1. Calculate the daily rate given an hourly rate

Implement a function to calculate the daily rate given an hourly rate:

<!-- livebook:{"force_markdown":true} -->

```elixir
FreelancerRates.daily_rate(60)
# => 480.0
```

The returned daily rate should be a float.

### 2. Calculate a discounted price

Implement a function to calculate the price after a discount.

<!-- livebook:{"force_markdown":true} -->

```elixir
FreelancerRates.apply_discount(150, 10)
# => 135.0
```

The returned value should always be a float, not rounded in any way.

### 3. Calculate the monthly rate, given an hourly rate and a discount

Implement a function to calculate the monthly rate, and apply a discount:

<!-- livebook:{"force_markdown":true} -->

```elixir
FreelancerRates.monthly_rate(77, 10.5)
# => 12130
```

The returned monthly rate should be rounded up (take the ceiling) to the nearest integer.

### 4. Calculate the number of workdays given a budget, hourly rate and discount

Implement a function that takes a budget, a hourly rate, and a discount, and calculates how many days of work that covers.

<!-- livebook:{"force_markdown":true} -->

```elixir
FreelancerRates.days_in_budget(20000, 80, 11.0)
# => 35.1
```

The returned number of days should be rounded down (take the floor) to one decimal place.

## Code

```elixir
defmodule FreelancerRates do
  @daily_hours 8.0
  @monthly_days 22.0

  def daily_rate(hourly_rate) do
    hourly_rate * @daily_hours
  end

  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  def monthly_rate(hourly_rate, discount) do
    (daily_rate(hourly_rate) * @monthly_days)
    |> apply_discount(discount)
    |> Float.ceil()
    |> round()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_discount =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    Float.floor(budget / daily_discount, 1)
  end
end
```

## Tests

```elixir
ExUnit.start(autorun: false, exclude: [pending: true])

defmodule FreelancerRatesTest do
  use ExUnit.Case

  describe "daily_rate/1" do
    @tag task_id: 1
    test "it's the hourly_rate times 8" do
      assert FreelancerRates.daily_rate(50) == 400.0
    end

    @tag task_id: 1
    test "it always returns a float" do
      assert FreelancerRates.daily_rate(60) === 480.0
    end

    @tag task_id: 1
    test "it does not round" do
      assert FreelancerRates.daily_rate(55.1) == 440.8
    end
  end

  describe "apply_discount" do
    @tag task_id: 2
    test "a discount of 10% leaves 90% of the original price" do
      assert FreelancerRates.apply_discount(140.0, 10) == 126.0
    end

    @tag task_id: 2
    test "it always returns a float" do
      assert FreelancerRates.apply_discount(100, 10) == 90.0
    end

    @tag task_id: 2
    test "it doesn't round" do
      assert_in_delta FreelancerRates.apply_discount(111.11, 13.5), 96.11015, 0.000001
    end
  end

  describe "monthly_rate/1" do
    @tag task_id: 3
    test "it's the daily_rate times 22" do
      assert FreelancerRates.monthly_rate(62, 0.0) == 10_912
    end

    @tag task_id: 3
    test "it always returns an integer" do
      assert FreelancerRates.monthly_rate(70, 0.0) === 12_320
    end

    @tag task_id: 3
    test "the result is rounded up" do
      # 11_052.8
      assert FreelancerRates.monthly_rate(62.8, 0.0) == 11_053
      # 11_475.2
      assert FreelancerRates.monthly_rate(65.2, 0.0) == 11_476
    end

    @tag task_id: 3
    test "gives a discount" do
      # 11_792 - 12% * 11_792 = 10_376.96
      assert FreelancerRates.monthly_rate(67, 12.0) == 10_377
    end
  end

  describe "days_in_budget/3" do
    @tag task_id: 4
    test "it's the budget divided by the daily rate" do
      assert FreelancerRates.days_in_budget(1_600, 50, 0.0) == 4
    end

    @tag task_id: 4
    test "it always returns a float" do
      assert FreelancerRates.days_in_budget(520, 65, 0.0) === 1.0
    end

    @tag task_id: 4
    test "it rounds down to one decimal place" do
      # 10.02273
      assert FreelancerRates.days_in_budget(4_410, 55, 0.0) == 10.0
      # 10.18182
      assert FreelancerRates.days_in_budget(4_480, 55, 0.0) == 10.1
    end

    @tag task_id: 4
    test "it applies the discount" do
      # 1.25
      assert FreelancerRates.days_in_budget(480, 60, 20) == 1.2
    end
  end
end

ExUnit.run()
```
