require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = FactoryGirl.create(:comment)
    sign_in @comment.story.requester
    @count = Comment.count
  end

  test 'should create comment' do
    post :create, story_id: @comment.story.id, comment: { content: @comment.content }
    assert_response :redirect
   
    assert_in_delta Comment.count, @count, 1
  end
end
