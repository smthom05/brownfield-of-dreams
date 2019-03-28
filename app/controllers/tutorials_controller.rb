class TutorialsController < ApplicationController
  def show
    flash[:alert] = 'User must login to bookmark videos' if params[:alert].present?
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
