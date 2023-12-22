defmodule TechschoolWeb.PageHTML do
  use TechschoolWeb, :html

  embed_templates "page_html/*"

  def footer(assigns) do
    ~H"""
    <footer class="text-center text-gray py-2 container-l1">
      <span class="text-sm">
        <%= gettext("Developed by") %>
        <a href="https://bergdaniel.com.br/" target="_blank" rel="noreferrer" class="underline">
          Daniel Bergholz
        </a>
        . <%= gettext("Code available on") %>
        <a
          href="https://github.com/danielbergholz/techschool"
          target="_blank"
          rel="noreferrer"
          class="underline"
        >
          GitHub
        </a>
      </span>
    </footer>
    """
  end

  attr :inverse_locale, :string, required: true

  def translate_button(assigns) do
    ~H"""
    <div class="gradient-container mt-4 w-max items-center mx-auto md:mx-0">
      <a href={"?locale=#{@inverse_locale}"} class="gradient-item p-1 md:p-2 items-center">
        <img
          src={"/images/flags/#{@inverse_locale}.svg"}
          alt={"Flag of #{String.upcase(@inverse_locale)}"}
          class="w-7 md:w-8"
        />
        <p class="font-bold ml-1 md:ml-2"><%= gettext("Translate") %></p>
      </a>
    </div>
    """
  end

  defp inverse_locale(locale) do
    case locale do
      "pt" -> "en"
      "en" -> "pt"
    end
  end
end
