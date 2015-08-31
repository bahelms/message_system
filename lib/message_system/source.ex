defmodule MessageSystem.Source do
  alias MessageSystem.Repo

  def update(msg = %{"headers" => headers, "record" => record}) do
    # find source
    # if exists update
    # if not exists insert
  end
end
