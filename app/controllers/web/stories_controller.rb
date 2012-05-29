class Web::StoriesController < Web::ApplicationController
  def new
    @story = Story.new
    @title = t_t 'new'
  end

  def show
    @story = Story.find(params[:id])
    @title = @story.content
  end

  def create
    @story = current_user.stories_out.build(params[:story])
    if @story.save
      flash[:success] = f_t 'create'
      redirect_to @story
    else
      flash[:warning] = f_t 'error'
      render :new
    end
  end

  def update
    story = Story.find(params[:id])
    story.state_event = params[:state_event]

    if story.save
      flash[:success] = f_t "state_#{story.state}"
    else
      flash[:error] = f_t 'update_error'
    end

    redirect_to story
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    flash[:success] = f_t :destroyed
    redirect_to current_user
  end
end
