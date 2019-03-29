class TutorialsController < ApplicationController
  def show
    if params[:alert].present?
      flash[:alert] = 'User must login to bookmark videos'
    end
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
