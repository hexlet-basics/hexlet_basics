defmodule HexletBasics.Upload do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Upload


  schema "uploads" do
    field :language_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Upload{} = upload, attrs) do
    upload
    |> cast(attrs, [:language_name])
    |> validate_required([:language_name])
  end
end
