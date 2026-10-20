defmodule ConsultoraWeb.SEOTest do
  use ConsultoraWeb.ConnCase, async: true

  test "each page includes distinct metadata and canonical URLs", %{conn: conn} do
    pages = [
      {"/", "Consultora ambiental"},
      {"/servicios", "Servicios de consultoría ambiental"},
      {"/equipo", "Nuestro equipo"}
    ]

    descriptions =
      for {path, title} <- pages do
        html =
          conn |> get(path <> "?utm_source=test") |> html_response(200) |> Floki.parse_document!()

        assert Floki.find(html, "title") |> Floki.text() =~ title

        assert Floki.attribute(html, "link[rel=canonical]", "href") == [
                 "https://payunconsultora.com.ar" <> path
               ]

        assert Floki.attribute(html, "meta[property='og:title']", "content") == [
                 title <> " · Payún"
               ]

        assert Floki.attribute(html, "meta[property='og:image']", "content") == [
                 "https://payunconsultora.com.ar/images/payun.jpg"
               ]

        assert Floki.attribute(html, "meta[name='twitter:card']", "content") == [
                 "summary_large_image"
               ]

        [description] = Floki.attribute(html, "meta[name=description]", "content")
        assert String.length(description) > 50
        description
      end

    assert length(Enum.uniq(descriptions)) == 3
  end

  test "sitemap and robots are publicly served", %{conn: conn} do
    sitemap = get(conn, "/sitemap.xml")
    assert sitemap.status == 200

    for path <- ["/", "/servicios", "/equipo"] do
      assert sitemap.resp_body =~ "<loc>https://payunconsultora.com.ar#{path}</loc>"
    end

    robots = get(conn, "/robots.txt")
    assert robots.status == 200
    assert robots.resp_body =~ "Sitemap: https://payunconsultora.com.ar/sitemap.xml"
    refute robots.resp_body =~ "Disallow: /"
  end

  test "production aliases redirect while preserving path and query" do
    for host <- ["www.payunconsultora.com.ar", "payun-consultora.fly.dev"] do
      conn = Plug.Test.conn(:get, "https://#{host}/servicios?utm_source=test")
      conn = ConsultoraWeb.Plugs.CanonicalHost.call(conn, enabled: true)
      assert conn.status == 301
      assert conn.halted

      assert get_resp_header(conn, "location") == [
               "https://payunconsultora.com.ar/servicios?utm_source=test"
             ]
    end
  end

  test "canonical host and local development do not redirect" do
    for host <- ["payunconsultora.com.ar", "localhost"] do
      conn = Plug.Test.conn(:get, "http://#{host}/")
      refute ConsultoraWeb.Plugs.CanonicalHost.call(conn, enabled: true).halted
    end

    conn = Plug.Test.conn(:get, "https://www.payunconsultora.com.ar/")
    refute ConsultoraWeb.Plugs.CanonicalHost.call(conn, enabled: false).halted
  end
end
