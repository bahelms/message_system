defmodule MessageQueueInterface do
  def connect(processor) do
    MessageQueue.connect(processor)
  end
end

