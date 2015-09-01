defmodule MessageSystem.Source do
  alias MessageSystem.Repo

  @spec apply_change(map) :: map
  def apply_change(msg = %{"headers" => headers, "record" => params}) do
    %{"record_mode" => mode, "record_source" => table} = headers
    model = _source_model(table)
    record = query_source_record(model, params)
    action = mode |> String.downcase |> String.to_atom
    apply(__MODULE__, action, [record, model, params])
  end

  @spec query_source_record(atom, map) :: map | none
  def query_source_record(model, params) do
    model.query_by(params) |> Repo.one
  end

  @spec insert(none, map, map) :: map
  def insert(nil, model, params) do
    {:ok, record} = Repo.insert(model.changeset(params))
    record
  end

  @spec insert(map, map, map) :: map
  def insert(record, model, params), do: update(record, model, params)

  @spec update(none, map, map) :: map
  def update(nil, model, params),    do: insert(nil, model, params)

  @spec update(map, map, map) :: map
  def update(record, model, params) do
    {:ok, record} = Repo.update(model.changeset(record, params))
    record
  end

  @spec delete(map, map, map) :: map
  def delete(record, _, _) do
    {:ok, record} = Repo.delete(record)
  end

  @spec _source_model(String.t) :: atom
  defp _source_model(table) do
    "Elixir.MessageSystem.POS.#{String.capitalize(table)}" |> String.to_atom
  end
end

