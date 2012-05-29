class StoriesController < ApplicationController
  def new
    @story = Story.new
    @title = t 'titles.story.new'
  end

  def show
    @story = Story.find(params[:id])
  end

  def create
    @story = current_user.stories_out.build(params[:story])
    if @story.save
      redirect_to @story, notice: t('flash.story.create')
    else
      flash[:warning] = t 'flash.story.error'
      render :new
    end
  end

  def update
    story = Story.find(params[:id])
    story.state_event = params[:state_event] if story

    if story.save
      flash[:info] = t "flash.story.state_#{story.state}"
    else
      flash[:error] = t 'flash.story.update_error'
    end

    redirect_to story
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    redirect_to current_user, notice: t('flash.story.destroyed')
  end
end
