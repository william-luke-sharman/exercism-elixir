defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  # need to change comparison operator
  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime)
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.to_date(checkout_datetime)
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    |> Kernel.max(0)
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week
    |> Kernel.===(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)
  
    return_date(checkout)
    |> days_late(return)
    |> Kernel.*(rate)
    |> apply_discount(return)
  end

  defp apply_discount(fee, return) do
    if monday?(return), do: Kernel.trunc(fee * 0.5), else: fee
  end
end
