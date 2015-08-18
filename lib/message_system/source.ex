defmodule MessageSystem.Source do
  def update(msg) do
    File.open _file(msg), [:append], fn(file) ->
      IO.write(file, "hey")
    end
    msg
  end

  defp _file(%{"headers" => headers}) do
    "#{_file_path}/#{_file_name(headers)}"
  end

  defp _file_name(%{"message_source" => source, "record_source" => table}) do
    "#{source}_#{table}.csv"
  end

  defp _file_path do
    "tmp"
  end
end
