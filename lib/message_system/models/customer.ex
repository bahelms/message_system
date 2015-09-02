defmodule MessageSystem.Customer do
  use Ecto.Model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "customers" do
    field :customer_number
    field :name
  end

  @required_fields ~w(customer_number)
  @optional_fields ~w(name)

  def changeset(customer, params \\ :empty) do
    customer
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:customer_number)
  end

  @spec query_by(map) :: map
  def query_by(%{customer_number: customer_number}) do
    from c in __MODULE__, where: c.customer_number == ^customer_number
  end
end
