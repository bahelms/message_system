defmodule MessageSystem do
  use Application

  def start(_type, %{processor: processor}) do
    MessageSystem.Supervisor.start_link(processor)
  end
end

