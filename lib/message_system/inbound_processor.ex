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
    msg = payload
      |> MessageSystem.MsgHandler.decode
      |> MessageSystem.MsgHandler.validate
      |> MessageSystem.MsgHandler.sanitize
      # log msg retrieved
      |> IO.inspect
      |> MessageSystem.Source.apply_change
    # transform source to public
    # update public
    # log public updated
    # generate responses
    # send responses
    {:noreply, queue}
  end
end

