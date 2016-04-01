defmodule Library.ContactController do
  use Library.Web, :controller

  alias Library.Contact

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    contacts = Repo.all(Contact)
    render(conn, "index.json", data: contacts)
  end

  def create(conn, %{"data" => %{"attributes" => contact_params}}) do
    changeset = Contact.changeset(%Contact{}, contact_params)

    case Repo.insert(changeset) do
      {:ok, contact} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", contact_path(conn, :show, contact))
        |> render("show.json", data: contact)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Library.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Repo.get!(Contact, id)
    render(conn, "show.json", data: contact)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => contact_params}}) do
    contact = Repo.get!(Contact, id)
    changeset = Contact.changeset(contact, contact_params)

    case Repo.update(changeset) do
      {:ok, contact} ->
        render(conn, "show.json", data: contact)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Library.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Repo.get!(Contact, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(contact)

    send_resp(conn, :no_content, "")
  end
end
