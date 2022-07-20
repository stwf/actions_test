if !Code.ensure_loaded?(ActionsTest.AppVersionHelper) do
  defmodule ActionsTest.AppVersionHelper do
    @moduledoc false
    @version_file_path "#{__DIR__}./../../VERSION"

    defmacro define_app_version_number do
      quote do
        @app_version_number unquote(read_version_file())
      end
    end

    def upgrade_revision([level | _]) do
      read_version_file()
      |> increment(level)
      |> write_version_file()
      |> IO.puts()
    end

    def increment(version, level) do
      version
      |> Version.parse!()
      |> do_increment(level)
      |> to_string()
    end

    def write_version_file(version) do
      @version_file_path
      |> Path.expand()
      |> Path.absname()
      |> File.write("#{version}\n")

      version
    end

    defp read_version_file do
      @version_file_path
      |> Path.expand()
      |> Path.absname()
      |> File.read!()
      |> String.trim()
    end

    defp do_increment(%Version{patch: patch} = version, "patch"),
      do: %{version | patch: patch + 1}

    defp do_increment(%Version{minor: minor} = version, "minor"),
      do: %{version | minor: minor + 1, patch: 0}

    defp do_increment(%Version{major: major} = version, "major"),
      do: %{version | major: major + 1, minor: 0, patch: 0}
  end
end
