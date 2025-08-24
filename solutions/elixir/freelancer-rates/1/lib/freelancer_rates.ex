defmodule FreelancerRates do
  @hours_per_day 8.0
  @days_per_month 22

  def daily_rate(hourly_rate), do: hourly_rate * @hours_per_day

  def apply_discount(before_discount, discount), do: before_discount - (before_discount * discount / 100.0)

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
      |> daily_rate
      |> Kernel.*(@days_per_month)
      |> apply_discount(discount)
      |> Float.ceil
      |> trunc
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_daily_rate = 
      hourly_rate
      |> daily_rate
      |> apply_discount(discount)
  
    days_in_budget =
      budget
      |> Kernel./(discounted_daily_rate)
      |> Float.floor(1)

    days_in_budget
  end
end
