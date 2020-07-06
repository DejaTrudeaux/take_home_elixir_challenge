defmodule CodeChallengeWeb.TodoController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  """
  use CodeChallengeWeb, :controller

  plug :require_query_params when action in [:show]
  @todos %{1 => "Read the paper", 2 => "Wash the dishes", 3 => "Feed the cats"}

  @spec require_query_params(%{query_params: any}, any) :: %{query_params: any}
  def require_query_params(%{query_params: query_params} = conn, _opts) do
    case query_params do
      %{"user" => "Kim", "password" => "insecurepw"} ->
        conn
      _ ->
        conn
        |> put_status(400)
        |> json("Access Restricted")
        |> Plug.Conn.halt()
  end
end

  @doc """
  Furnishes list of ToDo strings when "/todos" endpoint is hit.

  Example response:
    ["Read the paper", "Wash the dishes", "Feed the cats"]

  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    mapped_todos = Map.values(@todos)
    json(conn, mapped_todos)
  end

  @doc """
  Renders json string for a particular list item given that item's ID, but currently
  only when the query params "?user=Kim&password=insecurepw" are included (as per instructions).

  Example:
    Endpoint: "/todos/1?user=Kim&password=insecurepw"
    Gives us the response: "Read the paper"
    for ID 1 in the list

    however
    Endpoint: "/todos/1" (without query params)
    Gives us the response: "Access Restricted"
    because function plug requires aforementioned query params

    This method of authentication is a bad idea because you would never send a password like that
    in a get request in the query params. Instead, you would send it in a post request and encrypt
    the password.
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    # convert from json string to integer to get correct value
    id = String.to_integer(id)
    json(conn, Map.get(@todos, id))
  end
end
