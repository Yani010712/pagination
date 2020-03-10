require 'test_helper'

require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = { "Content-Type": "application/json", "Accept": "application/json" }
  end

  test "by param is required" do
    body = '{"params":{"range":{"start":3,"end":17,"max":5,"order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    assert JSON.parse(@response.body)["error"], "Should return an error message"
  end

  test "missing by param gives right error" do
    body = '{"params":{"range":{"start":3,"end":17,"max":5,"order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    expected = "the 'by' parameter is required"
    actual = JSON.parse(@response.body)["error"]
    assert_equal expected, actual, "Should return the right error message"
  end

  test "with by=id the start should be integer" do
    body = '{"params":{"range":{"by":"id", "start":"ana","end":17,"max":5,"order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    expected = "'start' and 'end' values must be Integer when sorting by id"
    actual = JSON.parse(@response.body)["error"]
    assert_equal expected, actual, "Should return the right error message"
  end
  
  test "with by equal id without max or end it should give a max of 50 items" do
    body = '{"params":{"range":{"by":"id"}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal id and start equal 2 should give a max of 50 items" do
    body = '{"params":{"range":{"by":"id","start":2}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal id and start equal 1 and end equal 53 the max should give a max of 50 items" do
    body = '{"params":{"range":{"by":"id","start":1,"end":53}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal id and start equal 1 and end equal 53 and the max equal 5" do
    body = '{"params":{"range":{"by":"id","start":1,"end":53, "max":5}}}'
    post apps_url, headers: @headers, params: body
    expected = 5
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return 5 items"
  end

  test "with by equal id and start equal 1 and end equal 6 and max equal 5" do
    body = '{"params":{"range":{"by":"id","start":1,"end":6, "max":5}}}'
    post apps_url, headers: @headers, params: body
    expected = 5
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return 5 items"
  end

  test "with by equal id and max equal 5" do
    body = '{"params":{"range":{"by":"id", "max":5}}}'
    post apps_url, headers: @headers, params: body
    expected = 5 
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return 5 items"
  end

  test "with by equal id and max equal 5 and order equal asc" do
    body = '{"params":{"range":{"by":"id", "max":5, "order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    first_expected = 1
    first_actual = JSON.parse(@response.body).first["id"]
    assert_equal first_expected, first_actual, "Should return 1" 
  end

  test "with by equal id and max equal 5 and order equal desc" do
    body = '{"params":{"range":{"by":"id", "max":5, "order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    last_expected = 5
    last_actual = JSON.parse(@response.body).last["id"]
    assert_equal last_expected, last_actual, "Should return 5" 
  end
  
  test "with by equal name should give a max of 50 items" do
    body = '{"params":{"range":{"by":"name"}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal name and start equal my-app-005 it should give a max of 50 items" do
    body = '{"params":{"range":{"by":"name","start":"my-app-005"}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal name and start equal my-app-001 and end equal my-app-053 give a max of 50 items" do
    body = '{"params":{"range":{"by":"name","start":"my-app-001","end":"my-app-053"}}}'
    post apps_url, headers: @headers, params: body
    expected = 50
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 50 items"
  end

  test "with by equal name and start equal my-app-001 and end equal my-app-053 and max equal 5" do
    body = '{"params":{"range":{"by":"name","start":"my-app-001","end":"my-app-053","max":5}}}'
    post apps_url, headers: @headers, params: body
    expected = 5
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 5 items"
  end

  test "with by equal name and max equal 5" do
    body = '{"params":{"range":{"by":"name","max": 5}}}'
    post apps_url, headers: @headers, params: body
    expected = 5
    actual = JSON.parse(@response.body).length
    assert_equal expected, actual, "Should return a default of 5 items"
  end

  test "with by equal name and max equal 5 and order equal asc" do
    body = '{"params":{"range":{"by":"name", "max":5, "order":"asc"}}}'
    post apps_url, headers: @headers, params: body
    first_expected = "my-app-001"
    first_actual = JSON.parse(@response.body).first["name"]
    assert_equal first_expected, first_actual, "Should return my-app-001" 
  end

  test "with by equal name and max equal 5 and order equal desc" do
    body = '{"params":{"range":{"by":"name", "max":5, "order":"desc"}}}'
    post apps_url, headers: @headers, params: body
    first_expected = "my-app-005"
    first_actual = JSON.parse(@response.body).first["name"]
    assert_equal first_expected, first_actual, "Should return my-app-005" 
  end

end