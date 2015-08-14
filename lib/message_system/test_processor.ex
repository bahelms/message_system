defmodule MessageSystem.TestProcessor do
  def start_link do
    pid = spawn(MessageSystem.TestProcessor, connect, [])
    {:ok, pid}
  end

  def connect do
    :ok
  end
end

