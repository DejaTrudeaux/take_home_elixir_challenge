defmodule CodeChallengeWeb.TodoControllerTest do
  @moduledoc """
  Tests for Todo Controller
  """
  use CodeChallengeWeb.ConnCase


  test "GET /todos returns a list of strings", %{conn: conn} do
    conn = get(conn, Routes.todo_path(conn, :index))
    assert "Read the paper" in json_response(conn, 200)
    assert "Wash the dishes" in json_response(conn, 200)
  end

  test "GET /todos/:id returns `Access Restricted`", %{conn: conn} do
    conn = get(conn, Routes.todo_path(conn, :show, 1))
    assert json_response(conn, 400) =~ "Access Restricted"

    conn = get(conn, Routes.todo_path(conn, :show, 2))
    assert json_response(conn, 400) =~ "Access Restricted"
  end

  test "GET /todos/:id?user=Kim&password=insecurepw returns a single string for a todo item", %{conn: conn} do
    conn = get(conn, "/todos/1?user=Kim&password=insecurepw")
    assert json_response(conn, 200) =~ "Read the paper"
    refute json_response(conn, 200) =~ "Wash the dishes"

    conn = get(conn, "/todos/2?user=Kim&password=insecurepw")
    assert json_response(conn, 200) =~ "Wash the dishes"
    refute json_response(conn, 200) =~ "Feed the cats"
  end
end
