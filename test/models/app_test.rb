require 'test_helper'

class AppTest < ActiveSupport::TestCase
  
  test "should not save app without id" do
    app = App.new name: apps(:app_1).name
    assert_not app.save, "Saved the app without an id"
  end

  test "should not save app without name" do
    app = App.new id: apps(:app_2).id
    assert_not app.save, "Saved the app without a name"
  end

end
