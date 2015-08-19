defmodule MessageSystem.Source do
  # def update(msg) do
  def update(msg = %{"headers" => headers, "record" => record}) do
    File.open _file(headers), [:append], fn(file) ->
      IO.write(file, _convert_record(record))
    end
    msg
  end

  # defp _file(%{"headers" => headers}) do
  defp _file(headers) do
    file = "#{_file_path}/#{_file_name(headers)}"
    IO.puts file
    file
  end

  defp _file_name(%{"message_source" => source, "record_source" => table}) do
    "#{source}_#{table}.csv"
  end

  defp _file_path do
    Application.get_env(Mix.env, :source_file_path)
  end

  defp _convert_record(record) do
    Enum.map(record, fn(x) -> "#{elem(x, 0)}:#{elem(x, 1)}" end) |> Enum.join(",")
  end
end
