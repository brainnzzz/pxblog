defmodule PxblogWeb.LayoutViewTest do
  use PxblogWeb.ConnCase, async: true

  alias PxblogWeb.LayoutView
  alias Pxblog.Blog.User
  alias Pxblog.Repo

  setup do
    User.changeset(%User{}, %{username: "test", password: "secret", password_confirmation: "secret", email: "email@example.com"})
    |> Repo.insert

    {:ok, conn: build_conn()}
  end

  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "test", password: "secret"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end

  test "deletes the user session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully!"
    assert redirected_to(conn) == post_path(conn, :index)
  end
end
