defmodule MessageSystem.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(CustomQueue, []),
      worker(MessageSystem.InboundProcessor, []),
      worker(MessageSystem.Repo, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

