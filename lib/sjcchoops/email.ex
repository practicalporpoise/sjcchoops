defmodule SJCCHoops.Email do
  import Swoosh.Email

  alias SJCCHoops.DateHelpers

  @from {"SJCC Hoops", "dave@practicalporpoise.com"}

  def welcome(player) do
    new()
    |> to({player.name, player.email})
    |> from(@from)
    |> subject("Hoops - Tuesday, Feb 2nd")
    |> html_body("<h1>Hello #{player.name}</h1>")
    |> text_body("Hello #{player.name}\n")
  end

  def daily(%{player: player, date: date, url: url}) do
    fmt_date = DateHelpers.long_format(date)

    new()
    |> to({player.name, player.email})
    |> from(@from)
    |> subject("Hoops - #{fmt_date}")
    |> html_body(daily_template(player, fmt_date, url))
    |> text_body(daily_template(player, fmt_date, url))
  end

  def daily_template(player, date, url) do
    """
    <p>Hi #{first_name(player.name)},</p></br>
    <p>Click the link below if you are hooping today: <b>#{date}</b>.</p></br>
    <a href="#{url}" style="#{link_styles()}">IN</a>
    </br></br>
    <p>Thanks!</p>
    SJCC Hoops
    """
  end

  defp link_styles() do
    Enum.join([
      "background-color: #5680cc;",
      "border-radius: 5px;",
      "color: white;",
      "font-weight: bold;",
      "padding: 1em 2em;"
    ])
  end

  defp first_name(name) do
    name
    |> String.split()
    |> Enum.at(0)
  end
end
