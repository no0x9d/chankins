defmodule Chankins.Web.API.ParameterView do
  use Chankins.Web, :view
  alias Chankins.Web.API.ParameterView

  def render("index.json", %{parameters: parameters}) do
    %{data: render_many(parameters, ParameterView, "parameter.json")}
  end

  def render("show.json", %{parameter: parameter}) do
    %{data: render_one(parameter, ParameterView, "parameter.json")}
  end

  def render("parameter.json", %{parameter: parameter}) do
    %{id: parameter.id, key:  parameter.key, value: parameter.value, group: parameter.group}
  end
end
