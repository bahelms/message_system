:random.seed(:os.timestamp)

defmodule Random do
  def number(digits \\ 8) do
    round(:random.uniform * :math.pow(100, digits/2))
  end
end
