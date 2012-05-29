require 'test_helper'

class Web::StoriesControllerTest < ActionController::TestCase
  setup do
    @story = FactoryGirl.create(:story)
    sign_in @story.requester
    @count = Story.count
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get story" do
    get :show, id: @story.id
    assert_response :success
  end
  
  test "should create story" do
    post :create, story: { content: @story.content, owner_id: @story.owner }
    assert_response :redirect
    
    assert_in_delta Story.count, @count, 1
  end

  test "should update story" do
    post :update, id: @story.id, state_event: 'starting'
    assert_response :redirect
    
    @story.reload
    assert_match 'started', @story.state
  end

  test "should destroy story" do
    delete :destroy, id: @story
    assert_response :redirect
    
    assert !Story.exists?(@story)
  end
end
