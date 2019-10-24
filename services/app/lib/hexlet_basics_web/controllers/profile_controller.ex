defmodule HexletBasicsWeb.ProfileController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasicsWeb.Plugs.{DetectDomainForRoot}
  alias HexletBasics.{User, UserManager, UserManager.Guardian}
  import Ecto

  plug DetectDomainForRoot when action in [:show]

  def show(%{assigns: %{current_user: current_user}} = conn, _params) do
    github_account = assoc(current_user, :accounts) |> Repo.get_by(provider: "github")

    render(conn, "show.html",
      user: current_user,
      github_account: github_account,
      user_active?: User.active?(current_user)
    )
  end

  def delete(%{assigns: %{current_user: current_user}} = conn, _) do
    case UserManager.remove_user!(current_user) do
      {:ok, _} ->
        conn
        |> Guardian.Plug.sign_out()
        |> put_flash(:info, gettext("Your account has been successfully deleted"))
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(
          :error,
          gettext(
            "Something went wrong! Please contact support <a href=mailto:support@hexlet.io> support@hexlet.io </a>."
          )
        )
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete_account(
        %{assigns: %{current_user: current_user}} = conn,
        %{"account_id" => account_id, "redirect_to" => redirect_to, "provider" => provider} =
          _params
      ) do
    case UserManager.delete_account(current_user, account_id) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          gettext("Your %{provider} account has been successfully deleted", provider: provider)
        )
        |> redirect(to: redirect_to)

      {:error, _} ->
        conn
        |> put_flash(
          :error,
          gettext(
            "Something went wrong! Please contact support <a href=mailto:support@hexlet.io> support@hexlet.io </a>."
          )
        )
        |> redirect(to: redirect_to)
    end
  end
end
