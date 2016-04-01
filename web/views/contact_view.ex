defmodule Library.ContactView do
  use Library.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email, :message]
end
