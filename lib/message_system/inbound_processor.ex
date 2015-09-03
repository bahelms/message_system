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
    payload
      |> MessageSystem.MsgHandler.decode
      |> MessageSystem.MsgHandler.validate
      |> MessageSystem.MsgHandler.sanitize
      # log msg retrieved
      |> MessageSystem.Source.apply_change
      # log record saved to source
      # |> MessageSystem.MsgHandler.map_to_public
      # |> MessageSystem.Public.apply_change
      # log public updated
      # generate responses
      # send responses
      # log messages sent
    {:noreply, queue}
  end
end

