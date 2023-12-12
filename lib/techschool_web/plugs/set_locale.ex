defmodule TechschoolWeb.SetLocale do
  @moduledoc """
  Set the process' locale based on the query params

  ## Example

    - When the user visits the following URL:
    http://localhost:4000/?locale=en

    - Then the process' locale will be set to "en"
  """

  @available_locales ["en", "pt"]

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _opts)
      when locale in @available_locales do
    Gettext.put_locale(TechschoolWeb.Gettext, locale)
    conn
  end

  def call(conn, _opts), do: conn
end
