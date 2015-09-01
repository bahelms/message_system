defmodule MessageSystem.POS.Arcust do
  use Ecto.Model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "arcust" do
    field :"RCCST#"
    field :RCNAME
  end

  @required_fields ~w(RCCST#)
  @optional_fields []

  def changeset(customer, params \\ :empty) do
    customer 
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:"RCCST#")
  end

  @spec find_record(map) :: map
  def find_record(%{"RCCST#" => customer_number}) do
    from c in __MODULE__, where: c."RCCST#" == ^customer_number
  end
end
