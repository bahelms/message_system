defmodule MessageSystem do
  use Application

  def start(_type, [message_client: client]) do
    MessageSystem.Supervisor.start_link(client)
  end
end

