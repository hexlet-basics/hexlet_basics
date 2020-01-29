defmodule HexletBasics.Repo.Migrations.MigrateSocialNetworkUids do
  use Ecto.Migration
  import Ecto.Query
  alias HexletBasics.Repo
  alias HexletBasics.{User, UserManager}

  def change do
    query = from(u in User, where: not is_nil(u.github_uid) or not is_nil(u.facebook_uid))
    users = Repo.all(query)
    Enum.each(users, fn user -> 
      if user.github_uid do
        UserManager.create_account(%{provider: "github", uid: to_string(user.github_uid), user_id: user.id})
      end
      if user.facebook_uid do
        UserManager.create_account(%{provider: "facebook", uid: user.facebook_uid, user_id: user.id})
      end
    end)
  end
end
