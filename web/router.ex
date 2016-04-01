defmodule Library.Router do
  use Library.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", Library do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Library do
    pipe_through :api
    resources "/invitations", InvitationController, except: [:new, :edit]
    resources "/libraries", LibraryController, except: [:new, :edit]
    resources "/contacts", ContactController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Library do
  #   pipe_through :api
  # end
end
