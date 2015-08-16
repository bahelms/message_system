defmodule MessageQueue do
  use GenServer
  @message_count 5

  ## Client

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def connect(pid) do
    GenServer.cast(__MODULE__, {:send_msg, pid})
  end

  ## Server

  def init(_) do
    Code.load_file("test/support/messages/arcust_message.ex")
    state = Enum.reduce 0..@message_count, [], fn(_, list) ->
      list |> List.insert_at(0, ArcustMessage.map)
    end
    {:ok, state}
  end

  def handle_cast({:send_msg, pid}, state) do
  end
end

