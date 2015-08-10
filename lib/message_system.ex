defmodule MessageSystem do
  use Application

  def start(_type, _args) do
    {:ok, _} = MessageSystem.Supervisor.start_link
  end
end

