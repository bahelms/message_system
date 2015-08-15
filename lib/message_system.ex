defmodule MessageSystem do
  use Application

  def start(_type, _args) do
    MessageSystem.Supervisor.start_link
  end
end

