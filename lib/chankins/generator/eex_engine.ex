defmodule Chankins.Generator.EExEngine do
  @moduledoc """
    This template engine uses EEx to render a file or binary content
  """

  def render_file(input, assigns) do
    EEx.eval_file(input, assigns)
  end

  def render_content(input, assigns) do
    EEx.eval_string(input, assigns)
  end
  
end