defmodule MessageSystem.POS.Arcust do
  use Ecto.Model
  @type t :: map

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "arcust" do
    field :"RCCST#"
    field :RCNAME
  end

  @required_fields ~w(RCCST#)
  @optional_fields ~w(RCNAME)

  @spec changeset(map) :: map
  def changeset(params \\ :empty) do
    changeset(%MessageSystem.POS.Arcust{}, params)
  end

  @spec changeset(map, map) :: map
  def changeset(arcust, params) do
    arcust
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:"RCCST#")
  end

  @spec query_by(map) :: t
  def query_by(%{"RCCST#" => customer_number}) do
    from c in __MODULE__, where: c."RCCST#" == ^customer_number
  end
end
