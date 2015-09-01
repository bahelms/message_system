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

  def insert(nil, model, params) do
    # Repo.insert
  end

  def insert(record, model, params), do: update(record, model, params)

  def update(nil, model, params), do: insert(nil, model, params)

  def update(record, model, params) do
  end

  def delete(record, model, params) do
  end

  @spec _source_model(String.t) :: atom
  defp _source_model(table) do
    "Elixir.MessageSystem.POS.#{String.capitalize(table)}" |> String.to_atom
  end
end

