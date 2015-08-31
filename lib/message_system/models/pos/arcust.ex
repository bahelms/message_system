defmodule MessageSystem.POS.Arcust do
  use Ecto.Model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "source.arcust" do
    field :"RCCST#"
    field :RCNAME
  end
end
