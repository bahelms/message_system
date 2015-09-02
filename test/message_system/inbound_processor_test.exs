defmodule MessageSystem.InboundProcessorTest do
  use ExUnit.Case
  alias MessageSystem.InboundProcessor, as: Inbound
  alias MessageSystem.POS.Arcust
  alias MessageSystem.Customer
  alias MessageSystem.Repo

  setup do
    payload = ArcustMessage.json(customer_number: "1234")
    Inbound.handle_info({:deliver, payload}, nil)
    {:ok, []}
  end

  test "saves the message to source" do
    source = Repo.one Arcust.query_by(%{"RCCST#" => "1234"})
    assert source."RCNAME" == "bob"
  end

  test "saves the transformation of source to public" do
    customer = Repo.one Customer.query_by(%{customer_number: "1234"})
    assert customer.name == "bob"
  end

  test "sends response message" do
    raise "Not implemented"
  end
end

