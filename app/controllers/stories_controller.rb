class StoriesController < ApplicationController
  before_action :set_story, only: %i[show update destroy]

  def index
    @stories = Story.all
    respond_with @stories
  end

  def show
    respond_with @story
  end

  def create
    @story = Story.new(story_params)
    @story.save
    respond_with @story
  end

  def update
    @story.update(story_params)
    respond_with @story
  end

  def destroy
    @story.destroy
    respond_with @story
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:name)
  end
end
