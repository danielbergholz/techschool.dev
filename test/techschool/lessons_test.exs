defmodule Techschool.LessonsTest do
  use Techschool.DataCase

  alias Techschool.Lessons

  describe "lessons" do
    alias Techschool.Lessons.Lesson

    import Techschool.LessonsFixtures

    @invalid_attrs %{
      name: nil,
      optional: nil,
      image_url: nil,
      description_en: nil,
      description_pt: nil,
      language_names: nil,
      framework_names: nil,
      tool_names: nil
    }

    test "list_lessons/0 returns all lessons" do
      lesson = lesson_fixture()
      assert Lessons.list_lessons() == [lesson]
    end

    test "get_lesson!/1 returns the lesson with given id" do
      lesson = lesson_fixture()
      assert Lessons.get_lesson!(lesson.id) == lesson
    end

    test "create_lesson/1 with valid data creates a lesson" do
      valid_attrs = %{
        name: "some name",
        optional: true,
        image_url: "some image_url",
        description_en: "some description_en",
        description_pt: "some description_pt",
        language_names: "some language_names",
        framework_names: "some framework_names",
        tool_names: "some tool_names"
      }

      assert {:ok, %Lesson{} = lesson} = Lessons.create_lesson(valid_attrs)
      assert lesson.name == "some name"
      assert lesson.optional == true
      assert lesson.image_url == "some image_url"
      assert lesson.description_en == "some description_en"
      assert lesson.description_pt == "some description_pt"
      assert lesson.language_names == "some language_names"
      assert lesson.framework_names == "some framework_names"
      assert lesson.tool_names == "some tool_names"
    end

    test "create_lesson/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lessons.create_lesson(@invalid_attrs)
    end

    test "delete_lesson/1 deletes the lesson" do
      lesson = lesson_fixture()
      assert {:ok, %Lesson{}} = Lessons.delete_lesson(lesson)
      assert_raise Ecto.NoResultsError, fn -> Lessons.get_lesson!(lesson.id) end
    end
  end
end
