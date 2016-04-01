defmodule Library.InvitationView do
  use Library.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email]
end
