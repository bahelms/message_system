defmodule MessageSystem.Source do
  import Ecto.Query
  alias MessageSystem.Repo

  @spec apply_change(map) :: map
  def apply_change(msg = %{"headers" => headers, "record" => params}) do
    %{"record_mode" => action, "record_source" => table} = headers
    function = action |> String.downcase |> String.to_atom
    record = query_source_record(table, params)
    # apply(__MODULE__, function, [params])
    # if exists update
    # if not exists insert
  end

  @spec query_source_record(String.t, map) :: map | []
  def query_source_record(table, params) do
    _source_model(table).find_record(params) |> Repo.all
  end

  @spec _source_model(String.t) :: atom
  defp _source_model(table) do
    "Elixir.MessageSystem.POS.#{String.capitalize(table)}" |> String.to_atom
  end
end

