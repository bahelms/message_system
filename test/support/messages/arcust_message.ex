defmodule ArcustMessage do
  def map(options \\ []) do
    %{"record" => %{
        "rccst#"  => Keyword.get(options, :customer_number, Random.number),
        "rcname"  => "bob",
        "rcaddr1" => "one happy day",
        "rccity"  => "Greatsville",
        "rcstate" => "NC",
        "rczip"   => "12345"},
      "headers" => %{
        "message_source" => "POS",
        "record_source"  => "ARCUST",
        "record_mode"    => Keyword.get(options, :record_mode, "INSERT") }}
  end

  def json(options \\ []) do
    map(options) |> :jsx.encode
  end
end

