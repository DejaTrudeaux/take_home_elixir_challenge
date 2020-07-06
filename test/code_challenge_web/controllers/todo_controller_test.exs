defmodule CodeChallengeWeb.TodoControllerTest do
  @moduledoc """
  Tests for Todo Controller
  """
  use CodeChallengeWeb.ConnCase


  test "GET /todos", %{conn: conn} do
    conn = get(conn, Routes.todo_path(conn, :index))
    assert "Read the paper" in json_response(conn, 200)
    assert "Wash the dishes" in json_response(conn, 200)
  end

  test "GET /todos/:id", %{conn: conn} do
    conn = get(conn, Routes.todo_path(conn, :show, 1))
    assert json_response(conn, 400) =~ "Access Restricted"

    conn = get(conn, Routes.todo_path(conn, :show, 2))
    assert json_response(conn, 400) =~ "Access Restricted"

  end
end
