defmodule TechschoolWeb.Hooks.RestoreLocale do
  import Phoenix.Component

  @default_locale Application.compile_env(:gettext, :default_locale)

  def on_mount(:default, _params, session, socket) do
    locale = session["locale"] || @default_locale

    Gettext.put_locale(TechschoolWeb.Gettext, locale)

    {:cont, assign(socket, :locale, locale)}
  end
end
