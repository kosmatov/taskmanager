class CommentsController < ApplicationController
  def create
    story = Story.find(params[:story_id])
    @comment = story.comments.build(params[:comment]) if story
    @comment.user = current_user

    if @comment.save
      flash[:success] = t 'flash.comment.created'
    else
      flash[:error] = t 'flash.comment.error'
    end

    redirect_to story
  end
end
