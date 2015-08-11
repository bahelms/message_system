defmodule MessageSystem.InboundProcessor do
  use GenServer

  ## Client

  def start_link(client) do
    GenServer.start_link(__MODULE__, [message_client: client], [name: __MODULE__])
  end

  ## Server

  def handle_call(:process, _, [message_client: client] = state) do
    {:reply, client, state}
  end
end

