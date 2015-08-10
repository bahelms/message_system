defmodule ArcustMessage do
  def msg do
    %{record: %{
        "rccst.": Random.number}, 
      headers: %{
        message_source: "POS", 
        record_source:  "ARCUST",
        record_mode:    "INSERT" }}
  end
end
