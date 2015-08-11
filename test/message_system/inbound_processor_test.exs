defmodule MessageSystem.InboundProcessorTest do
  use ExUnit.Case
  alias MessageSystem.InboundProcessor, as: Inbound

  test "does stuff" do
    assert GenServer.call(Inbound, :process) == :test_client
  end
end
