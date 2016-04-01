defmodule Library.Contact do
  use Library.Web, :model

  schema "contacts" do
    field :email, :string
    field :message, :string

    timestamps
  end

  @required_fields ~w(email message)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
