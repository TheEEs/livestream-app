class Home::IndexPage < MainLayout
  def content
    div id: "app"
    js_link asset("js/home.js"), defer: "true", data_turbolinks_track: "reload"
  end
end
