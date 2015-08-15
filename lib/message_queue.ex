defmodule MessageQueue do
  use GenServer

  ## Client

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  ## Server

  def init(_) do
    Code.load_file("test/support/messages/arcust_message.ex")
    state = Enum.reduce 0..5, [], fn(_, list) ->
      list |> List.insert_at(0, ArcustMessage.map)
    end
    {:ok, state}
  end
end
