ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Library.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Library.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Library.Repo)

