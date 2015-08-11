defmodule MessageSystem.Supervisor do
  use Supervisor

  def start_link(client) do
    Supervisor.start_link(__MODULE__, client)
  end

  def init(client) do
    children = [worker(MessageSystem.InboundProcessor, [client])]
    supervise(children, strategy: :one_for_one)
  end
end

