class Rooms::Show < BrowserAction
  get "/rooms/" do
    html ShowPage
  end
end
