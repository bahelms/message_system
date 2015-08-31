defmodule MessageSystem.Customer do
  use Ecto.Model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "customers" do
    field :customer_number
    field :name
  end

  def changeset(customer, params \\ :empty) do
    customer 
      |> cast(params, ~w(customer_number), ~w())
      |> unique_constraint(:customer_number, name: :customers_pkey)
  end
end
