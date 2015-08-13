defmodule ArcustMessage do
  def map do
    %{record: %{
        "rccst.": Random.number}, 
      headers: %{
        message_source: "POS", 
        record_source:  "ARCUST",
        record_mode:    "INSERT" }}
  end

  def json do
    :jsx.encode(map)
  end
end
