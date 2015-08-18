defmodule MessageSystem.Validator do
  def validate(%{"headers" => headers} = msg) do
    validate_headers(headers)
    msg
  end

  def validate_headers(%{"message_source" => _source, 
                         "record_source"  => _table, 
                         "record_mode"    => _action}) do
  end
end
