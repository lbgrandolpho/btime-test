ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Backend.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:backend)

Enum.each(Path.wildcard("test/support/**/*.ex"), &Code.require_file/1)
