defmodule MessageSystem.InboundProcessor do
  alias MessageQueueInterface, as: Queue

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def process do
    Queue.connect(self)
    _process
  end

  defp _process do
    receive do
      {:ok, msg } -> IO.puts "Got msg"
      _process
    end
  end
end

