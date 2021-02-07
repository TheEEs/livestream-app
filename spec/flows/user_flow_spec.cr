require "../spec_helper"

class User
end

describe "User create a new chatroom" do
  it "works" do
    flow = UserFlow.new
    flow.visit Home::Index
    flow.click "@new-room"
    flow.open_screenshot
    flow.el(".flash-success").should be_on_page
  end
end

describe "User access to Rooms::Show with wrong id" do
  it "should redirect user to home page" do
    flow = UserFlow.new
    flow.visit Rooms::Show.with(12312312.to_s)
    flow.should have_current_path(Home::Index)
  end
end
