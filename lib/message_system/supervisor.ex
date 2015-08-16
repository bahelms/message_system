defmodule MessageSystem.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(MessageQueue, []),
      worker(Task, [MessageSystem.InboundProcessor, :process, []])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

