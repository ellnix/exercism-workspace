defmodule LibraryFees do
  def datetime_from_string(string) do
    # sigil_format = string 
    #   |> String.trim_trailing("Z")
    #   |> String.replace("T", " ")

    {:ok, thing} = NaiveDateTime.from_iso8601(string)
    thing
  end

  def before_noon?(datetime) do
    Time.before?(NaiveDateTime.to_time(datetime), ~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    Date.add(NaiveDateTime.to_date(checkout_datetime), days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    lateness = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if lateness < 0, do: 0, else: lateness
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    fees = days_late(return_date(datetime_from_string(checkout)), datetime_from_string(return)) * rate

    if monday?(datetime_from_string(return)), do: div(fees, 2), else: fees
  end
end
