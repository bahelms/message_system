defmodule CustomQueue do
  use GenServer
  @message_count 5

  ## Client

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def subscribe(pid) do
    GenServer.cast(__MODULE__, {:deliver, pid})
    {:ok, :queue}
  end

  ## Server

  def init([]) do
    Code.load_file("test/support/messages/arcust_message.ex")
    msgs = Enum.reduce 1..@message_count, [], fn(_, list) ->
      [ArcustMessage.json | list]
    end
    {:ok, msgs}
  end

  def handle_cast({:deliver, pid}, msgs) do
    msgs |> Enum.each fn(msg) ->
      send pid, {:deliver, msg}
    end
    {:noreply, []}
  end
end

