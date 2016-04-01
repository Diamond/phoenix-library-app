defmodule Library.LibraryView do
  use Library.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :address, :phone]
end
