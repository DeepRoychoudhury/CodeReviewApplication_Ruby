require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url

@note=notes(:one) 
end

  test "should get index" do
    get project_notes_url(@note.project_id)
    assert_response :success
  end

  test "should get show" do
    get project_note_url(@note.project_id,@note.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_note_url(@note.id,@note.project_id)
    assert_response :success
  end

end
