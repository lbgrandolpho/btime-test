defmodule BackendWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: MyAppWeb.Schema

  ## Channels
  channel("rooms:*", BackendWeb.RoomChannel)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
