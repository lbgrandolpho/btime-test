defmodule BackendWeb.ErrorView do
  use BackendWeb, :view

  def render("500.html", _assigns) do
    "Internal Server Error"
  end

  def render("404.html", _assigns) do
    "Not Found"
  end

  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
