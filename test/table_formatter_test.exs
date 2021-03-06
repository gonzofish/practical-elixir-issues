defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  def headers, do: ["c1", "c2", "c4"]
  def simple_test_data do
    [
      %{"c1" => "r1 c1", "c2" => "r1 c2", "c3" => "r1 c3", "c4" => "r1 c4"},
      %{"c1" => "r2 c1", "c2" => "r2 c2", "c3" => "r2 c3", "c4" => "r2 c4"},
      %{"c1" => "r3 c1", "c2" => "r3 c2", "c3" => "r3 c3", "c4" => "r3++++c4"},
      %{"c1" => "r4 c1", "c2" => "r4 c2", "c3" => "r4 c3", "c4" => "r4 c4"}
    ]
  end

  test "Should format the table given a list of headers and a matrix of data" do
    result = capture_io fn ->
      TF.format(simple_test_data(), headers())
    end

    assert result ===
      ~s"c1    | c2    | c4      \n" <>
      ~s"------+-------+---------\n" <>
      ~s"r1 c1 | r1 c2 | r1 c4   \n" <>
      ~s"r2 c1 | r2 c2 | r2 c4   \n" <>
      ~s"r3 c1 | r3 c2 | r3++++c4\n" <>
      ~s"r4 c1 | r4 c2 | r4 c4   \n"
  end
end