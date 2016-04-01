defmodule Library.LibraryController do
  use Library.Web, :controller

  alias Library.Library, as: LibraryModel

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    libraries = Repo.all(LibraryModel)
    render(conn, "index.json", data: libraries)
  end

  def create(conn, %{"data" => %{"attributes" => library_params}}) do
    changeset = LibraryModel.changeset(%LibraryModel{}, library_params)

    case Repo.insert(changeset) do
      {:ok, library} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", library_path(conn, :show, library))
        |> render("show.json", data: library)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Library.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    library = Repo.get!(LibraryModel, id)
    render(conn, "show.json", data: library)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => library_params}}) do
    library = Repo.get!(LibraryModel, id)
    changeset = LibraryModel.changeset(library, library_params)

    case Repo.update(changeset) do
      {:ok, library} ->
        render(conn, "show.json", data: library)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Library.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    library = Repo.get!(LibraryModel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(library)

    send_resp(conn, :no_content, "")
  end
end
