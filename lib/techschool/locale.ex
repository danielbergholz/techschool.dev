defmodule Techschool.Locale do
  @moduledoc """
  This module provides functions to work with locales.
  """

  @default_locale Application.compile_env(:gettext, :default_locale)
  @available_locales Gettext.known_locales(TechschoolWeb.Gettext)

  def get_available_locales, do: @available_locales

  def get_default_locale, do: @default_locale
end
