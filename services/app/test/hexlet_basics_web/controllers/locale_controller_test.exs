defmodule HexletBasicsWeb.LocaleControllerTest do
  use HexletBasicsWeb.ConnCase
  alias HexletBasics.UserManager.Guardian
  alias HexletBasics.UserManager
  alias HexletBasicsWeb.Helpers.CustomUrl

  test "switch to ru", %{conn: conn} do
    locale = "ru"
    url = CustomUrl.redirect_current_url(conn, locale)
    user = insert(:user)

    conn = conn
       |> Guardian.Plug.sign_in(user)
       |>get(locale_path(conn, :switch, redirect_url: url, locale: locale))

    new_locale = get_session(conn, :locale)
    user = UserManager.get_user!(user.id)
    assert redirected_to(conn) == url
    assert new_locale == locale
    assert user.locale == locale
  end

  test "switch en", %{conn: conn} do
    locale = "en"
    url = CustomUrl.redirect_current_url(conn, locale)
    user = insert(:user)

    conn = conn
       |> Guardian.Plug.sign_in(user)
       |>get(locale_path(conn, :switch, redirect_url: url, locale: locale))

    new_locale = get_session(conn, :locale)
    user = UserManager.get_user!(user.id)
    assert redirected_to(conn) == url
    assert new_locale == locale
    assert user.locale == locale
  end
end
