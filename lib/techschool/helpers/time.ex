defmodule Techschool.Helpers.Time do
  use Gettext, backend: TechschoolWeb.Gettext

  def format_time_ago(datetime, opts \\ []) do
    prefix = Keyword.get(opts, :prefix, "")

    {time, unit, plural} = time_ago(datetime)
    prefix <> gettext("%{time} %{unit} ago", time: time, unit: unit <> plural)
  end

  def time_ago(datetime) do
    now = DateTime.utc_now()
    diff = DateTime.diff(now, datetime)

    cond do
      diff < 60 ->
        {diff, gettext("second"), plural(diff)}

      diff < 3600 ->
        minutes = div(diff, 60)
        {minutes, gettext("minute"), plural(minutes)}

      diff < 86400 ->
        hours = div(diff, 3600)
        {hours, gettext("hour"), plural(hours)}

      diff < 2_592_000 ->
        days = div(diff, 86400)
        {days, gettext("day"), plural(days)}

      true ->
        months = div(diff, 2_592_000)

        case months do
          1 ->
            {months, gettext("month"), ""}

          _ ->
            {months, gettext("months"), ""}
        end
    end
  end

  defp plural(1), do: ""
  defp plural(_number), do: "s"
end
