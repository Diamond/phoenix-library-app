defmodule Library.LibraryTest do
  use Library.ModelCase

  alias Library.Library

  @valid_attrs %{address: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Library.changeset(%Library{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Library.changeset(%Library{}, @invalid_attrs)
    refute changeset.valid?
  end
end
