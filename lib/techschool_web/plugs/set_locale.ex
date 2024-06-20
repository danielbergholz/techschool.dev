defmodule TechschoolWeb.Plugs.SetLocale do
  @moduledoc """
  Set the process' locale based on the URL path and store it in a cookie.
  It expires in 1 year.

  ## Example

    - When the user visits the following URL:
    http://localhost:4000/pt

    - Then the process' locale will be set to "pt"
  """
  import Plug.Conn

  @default_locale Techschool.Locale.get_default_locale()
  @available_locales Techschool.Locale.get_available_locales()
  @one_year 365 * 24 * 60 * 60

  def init(_opts), do: nil

  def call(conn, _opts) do
    case fetch_locale_from(conn) do
      nil ->
        conn
        |> assign(:locale, @default_locale)
        |> put_session(:locale, @default_locale)

      locale ->
        conn
        |> assign(:locale, locale)
        |> put_session(:locale, locale)
        |> put_resp_cookie("locale", locale, max_age: @one_year)
    end
  end

  defp fetch_locale_from(conn) do
    (conn.params["locale"] || conn.cookies["locale"])
    |> check_locale
  end

  defp check_locale(locale) when locale in @available_locales, do: locale
  defp check_locale(_), do: nil
end
