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
    payload |> 
      :jsx.decode |>
      MessageSystem.Validator.validate
      # log msg retrieved
      # update source
      # log source update
      # transform source to public
      # update public
      # log public updated
      # generate responses
      # send responses
    {:noreply, queue}
  end
end

