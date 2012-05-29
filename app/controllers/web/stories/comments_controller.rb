class Web::Stories::CommentsController < Web::Stories::ApplicationController
  def create
    @comment = current_story.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:success] = f_t :created
    else
      flash[:error] = f_t :error
    end

    redirect_to current_story
  end
end
