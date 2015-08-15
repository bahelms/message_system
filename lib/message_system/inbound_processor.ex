defmodule MessageSystem.InboundProcessor do
  use GenServer 

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
end

