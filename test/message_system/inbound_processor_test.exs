defmodule MessageSystem.InboundProcessorTest do
  use ExUnit.Case
  alias MessageSystem.InboundProcessor, as: Inbound

  setup do
    File.rm("test/tmp/POS_ARCUST.csv")
    {:ok, []}
  end

  test "saves the message to source" do
    payload = ArcustMessage.map("1234") |> :jsx.encode
    Inbound.handle_info({:deliver, payload}, nil)
    assert File.read!("test/tmp/POS_ARCUST.csv") == "rccst.:1234,rcname:bob\n"
  end
end
