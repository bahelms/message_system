defmodule MessageSystem.Validator do
  def validate(%{"headers" => headers} = msg) do
    validate_headers(headers)
    msg
  end

  def validate_headers(headers) do
    %{"message_source" => _source, 
      "record_source"  => _table, 
      "record_mode"    => _action} = headers
  end
end
