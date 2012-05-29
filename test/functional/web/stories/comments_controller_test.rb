require 'test_helper'

class Web::Stories::CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = FactoryGirl.create(:comment)
    sign_in @comment.story.requester
  end

  test "should create comment" do
    content = FactoryGirl.generate(:string)
    post :create, story_id: @comment.story.id, comment: { content: content }
    assert_response :redirect
   
    assert_not_nil Comment.find_by_content(content)
  end
end
