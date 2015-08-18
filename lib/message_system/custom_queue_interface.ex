defmodule CustomQueueInterface do
  def subscribe(processor) do
    {:ok, _queue} = CustomQueue.subscribe(processor)
  end
end

