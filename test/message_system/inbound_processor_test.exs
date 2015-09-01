defmodule MessageSystem.InboundProcessorTest do
  use ExUnit.Case
  alias MessageSystem.InboundProcessor, as: Inbound
  alias MessageSystem.POS.Arcust
  alias MessageSystem.Repo

  test "saves the message to source" do
    payload = ArcustMessage.map(customer_number: "1234") |> :jsx.encode
    Inbound.handle_info({:deliver, payload}, nil)
    assert Repo.one Arcust.query_by(%{"RCCST#" => "1234"})
  end
end
