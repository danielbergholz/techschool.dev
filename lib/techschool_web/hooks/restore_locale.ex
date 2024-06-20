defmodule TechschoolWeb.Hooks.RestoreLocale do
  import Phoenix.Component
  alias Techschool.Locale

  def on_mount(:default, _params, session, socket) do
    locale = session["locale"] || Locale.get_default_locale()

    Gettext.put_locale(TechschoolWeb.Gettext, locale)

    {:cont, assign(socket, :locale, locale)}
  end
end
