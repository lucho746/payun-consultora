defmodule ConsultoraWeb.Plugs.CanonicalHost do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    enabled =
      Keyword.get(opts, :enabled, Application.get_env(:consultora, :canonical_redirect, false))

    if enabled and conn.method in ["GET", "HEAD"] and
         conn.host in ["www.payunconsultora.com.ar", "payun-consultora.fly.dev"] do
      query = if conn.query_string == "", do: "", else: "?" <> conn.query_string

      conn
      |> put_resp_header(
        "location",
        "https://payunconsultora.com.ar" <> conn.request_path <> query
      )
      |> send_resp(301, "")
      |> halt()
    else
      conn
    end
  end
end
