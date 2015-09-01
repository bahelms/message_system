defmodule MessageSystem.MsgHandler do
  @spec decode(String.t) :: map
  def decode(json_payload) do
    :jsx.decode(json_payload)
  end

  @spec sanitize(map) :: map
  def sanitize(msg) do
    _upcase_record_keys(msg)
  end

  @spec validate(map) :: map
  def validate(%{"headers" => headers} = msg) do
    validate_headers(headers)
    msg
  end

  @spec validate_headers(map) :: any
  def validate_headers(headers) do
    %{"message_source" => _source, 
      "record_source"  => _table, 
      "record_mode"    => _action} = headers
  end

  @spec _upcase_record_keys(map) :: map
  defp _upcase_record_keys(%{"record" => params} = msg) do
    upcased_params = Enum.reduce params, %{}, fn({k,v}, acc) -> 
      Map.put(acc, String.upcase(k), v) 
    end
    Map.put(msg, "record", upcased_params)
  end
end
