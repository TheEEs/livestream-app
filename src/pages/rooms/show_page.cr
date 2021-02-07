class Rooms::ShowPage < MainLayout

  def page_title
    "Living room"
  end

  def content
    div do 
      div id: "app"
    end
    js_link asset("js/show.js"), defer: "true", data_turbolinks_track: "reload"
  end
end
