defmodule BackendWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :backend
  use Absinthe.Phoenix.Endpoint

  plug(CORSPlug, origin: ["*"])

  socket("/socket", BackendWeb.UserSocket)

  plug(Plug.Logger)

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.Session,
    store: :cookie,
    key: "_backend_key",
    signing_salt: "a secret salt"
  )

  plug(BackendWeb.Router)

  plug(Absinthe.Plug,
    schema: BackendWeb.Schema
  )

  plug(Absinthe.Plug.GraphiQL,
    schema: BackendWeb.Schema,
    interface: :simple,
    context: %{pubsub: BackendWeb.Endpoint}
  )
end
