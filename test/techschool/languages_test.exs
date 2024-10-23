defmodule Techschool.LanguagesTest do
  use Techschool.DataCase

  alias Techschool.Languages

  describe "languages" do
    alias Techschool.Languages.Language

    import Techschool.LanguagesFixtures

    @invalid_attrs %{name: nil, icon_name: 999}

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Languages.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Languages.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      valid_attrs = %{
        name: "some name",
        icon_name: "some icon_name"
      }

      assert {:ok, %Language{} = language} = Languages.create_language(valid_attrs)
      assert language.name == "some name"
      assert language.icon_name == "some icon_name"
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Languages.create_language(@invalid_attrs)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Languages.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Languages.get_language!(language.id) end
    end
  end
end
