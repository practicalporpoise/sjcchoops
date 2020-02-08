defmodule SJCCHoops.DateHelpers do
  @days [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ]

  @months [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]

  def long_format(date) when is_binary(date) do
    long_format(Date.from_iso8601!(date))
  end

  def long_format(date) do
    day_of_week = Enum.at(@days, Date.day_of_week(date) - 1)
    month = Enum.at(@months, date.month - 1)
    day = day_str(date.day)
    "#{day_of_week}, #{month} #{day}"
  end

  defp day_str(day) do
    ext =
      case day do
        n when n in [1, 21, 31] -> "st"
        n when n in [2, 22] -> "nd"
        n when n in [3, 23] -> "rd"
        _ -> "th"
      end

    "#{day}#{ext}"
  end
end
