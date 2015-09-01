defmodule ArcustMessage do
  def map(customer_number \\ Random.number) do
    %{"record" => %{
        "rccst#" => customer_number,
        "rcname" => "bob"}, 
      "headers" => %{
        "message_source" => "POS", 
        "record_source"  => "ARCUST",
        "record_mode"    => "INSERT" }}
  end

  def json do
    :jsx.encode(map)
  end
end

