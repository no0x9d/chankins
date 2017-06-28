defmodule Chankins.Generator do
  @moduledoc """
    Generator is used to render templete files and dynamic data with different render engines based on file extensions.
    Even multiple rendering runs are supported. For a file like "layout.md.eex" the EExEngine is used in the first run and
    the MarkdownEngine in a second run with the result of the EExEngine. This mechanism can build an arbitrary deep pipline of
    intermediate rendering results with one single result

    All available rendering engines can be configured in the Mix config.exs in a map with the extension as key and the engine as value.
    config :chankins, Chankins.Generator,
      engines: %{".md" => Chankins.Generator.MarkdownEngine, ".eex" => Chankins.Generator.EExEngine}

    For all unknown extensions the FileEngine is used.
  """
  alias  Chankins.Generator.{FileEngine, Context}

  @engines_config :engines
  @default_engine FileEngine

  def generate(template, assigns) do
    render_file template, assigns
  end

  defp render_file(path, assigns) do
    engine = get_engine_for_path path
    context = Context.build(path, engine)
    assigns = Keyword.put(assigns, :context, context)
    rendered_content = engine.render_file(path, assigns)

    next_pass(rendered_content, context, assigns)
  end

  def next_pass(content, old_context, assigns) do
    if render_again? old_context do
      new_file = Path.basename(old_context.file, old_context.ext)
      engine = get_engine_for_path new_file
      new_context = Context.build(Path.join(old_context.dir, new_file), engine)
      render_content content, new_context, assigns
    else
      content
    end
  end

  @doc """
    Checks the current filename for multiple extensions, e.g. layout.html.eex and returns true in this case.

     iex> true == render_again?(%Context{file: "layout.html.eex"})
     iex> false == render_again?(%Context{file: "layout.html"})
  """
  defp render_again?(context) do
    "" != Path.basename(context.file, context.ext)
    |> Path.extname()
  end

  defp render_content(content, context, assign) do
    context.engine.render_content(content, assign)
  end


  def include(path, context, assigns) do
    path
    |> Path.expand(context.dir)
    |> render_file(assigns)
  end

  defp get_engine_for_path path do
    Path.extname(path) |> get_engine_for_extension
  end

  defp get_engine_for_extension(ext) do
    Application.get_env(:chankins, Chankins.Generator, [])
    |> Keyword.get(@engines_config, %{})
    |> Map.get(ext, @default_engine)
  end

  defmodule Context do
    defstruct file: nil, dir: nil, ext: "", engine: FileEngine

    def build(file_path, engine \\ :nil) do
      file_name = Path.basename(file_path)
      dir = Path.dirname(file_path)
      ext = Path.extname(file_path)
      %Context{file: file_name, dir: dir, ext: ext, engine: engine}
    end
  end
end