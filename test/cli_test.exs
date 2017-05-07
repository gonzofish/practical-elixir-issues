defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_into_ascending_order: 1 ]

  test ":help is returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values return if three are given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted to 4 if 2 arguments are passed" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort ascending orders as expected" do
    result = _fake_created_at(["a", "b", "c"])
              |> sort_into_ascending_order
    issues = for issue <- result, do: Map.get(issue, "created_at")

    assert issues == ~w{ a b c}
  end

  defp _fake_created_at(list) do
    for value <- list, do: %{ "created_at" => value, "other_data": "xxx" }
  end
end
