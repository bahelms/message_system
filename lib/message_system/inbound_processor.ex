defmodule MessageSystem.InboundProcessor do
  use GenServer
  alias CustomQueueInterface, as: Queue

  ## Client

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  ## Server

  def init(_) do
    {:ok, _queue} = Queue.subscribe(self)
  end

  def handle_info({:deliver, payload}, queue) do
    IO.puts payload
    {:noreply, queue}
  end
end

