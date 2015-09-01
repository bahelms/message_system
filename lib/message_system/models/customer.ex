defmodule MessageSystem.Customer do
  use Ecto.Model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "customers" do
    field :customer_number
    field :name
  end

  @required_fields ~w(customer_number)
  @optional_fields []

  def changeset(customer, params \\ :empty) do
    customer 
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:customer_number)
  end
end
