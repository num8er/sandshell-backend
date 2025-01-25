defmodule SandshellApi.Router do
  use SandshellApi, :router
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:put_root_layout, html: {SandshellApi.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  if Mix.env() == :dev do
    scope "/__system" do
      pipe_through :browser
      live_dashboard "/dashboard"
    end
  end

  scope "/manifest", SandshellApi.Handlers do
    pipe_through :api

    get("/", ManifestHandler, :handle)
  end

  # /v1
  scope "/v1", SandshellApi.Handlers.V1 do
    pipe_through :api

    # /v1/db
    scope "/db", Db do
      # /v1/db/info
      get("/info", InfoHandler, :handle)
    end

    # /v1/users
    scope "/users", Users do
      # /v1/users/:id
      get("/:id", GetByIdHandler, :handle)
    end
  end

  scope "/pages", SandshellApi.Handlers do
    pipe_through :browser

    get("/", IndexPageHandler, :handle)
  end
end
