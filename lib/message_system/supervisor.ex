defmodule MessageSystem.Supervisor do
  use Supervisor

  def start_link(processor) do
    Supervisor.start_link(__MODULE__, processor)
  end

  def init(inbound_processor) do
    children = [worker(inbound_processor, [])]
    supervise(children, strategy: :one_for_one)
  end
end

