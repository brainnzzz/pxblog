defmodule Pxblog.Blog.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  alias Pxblog.Blog.User

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_digest, :string

    timestamps()

    #virtual fields
    field :password, :string, virtual: true
  end

  @required_fields [:username, :email, :password]
  @optional_fields [:password_digest]
  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password, message: "Password does not match")
    |> validate_length(:password, min: 5)
    |> unique_constraint(:email, message: "Email already in use")
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
