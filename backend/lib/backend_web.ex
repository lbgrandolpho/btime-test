defmodule BackendWeb do
  @moduledoc """
  Documentation for `BackendWeb`.
  """

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/backend_web/templates"
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      import Plug.Conn
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: BackendWeb

      import Phoenix.LiveView.Controller
      import Plug.Conn
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
