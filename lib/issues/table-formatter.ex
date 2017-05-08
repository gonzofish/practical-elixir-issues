defmodule Issues.TableFormatter do
  @doc """
  Takes a list of issues and formats them into
  a table
  """
  def format(issues, headers) do
    with columns = _make_printable_rows(issues, headers),
          column_widths = Enum.map(columns, &_set_width(&1)) do
      IO.puts inspect column_widths
      _print_row(headers, column_widths, " | ")
      _print_separator(column_widths)

      [_headers | data] = Enum.zip(columns)
      _print_data(data, column_widths)
    end
  end

  defp _make_printable_rows(rows, headers) do
    for header <- headers do
      [header] ++ for row <- rows, do: _make_printable(row[header])
    end
  end
  defp _make_printable(value) when is_binary(value), do: value
  defp _make_printable(value), do: to_string(value)

  defp _set_width(column) do
    Enum.map(column, &String.length/1) |> Enum.max
  end

  defp _print_separator(column_widths) do
    Enum.map(column_widths, &String.duplicate("-", &1))
      |> _print_row(column_widths, "-+-")
  end

  defp _print_data(columns, widths) do
    Enum.map(columns, &Tuple.to_list/1)
      |> Enum.each(&_print_row(&1, widths, " | "))
  end

  defp _print_row(columns, widths, separator) do
    Enum.zip(columns, widths)
      |> Enum.map(fn ({ column, width }) ->
        String.pad_trailing(column, width)
      end)
      |> Enum.join(separator)
      |> IO.puts
  end
end