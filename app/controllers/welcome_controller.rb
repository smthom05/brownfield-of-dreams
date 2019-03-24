class WelcomeController < ApplicationController
  def index
    # if params[:tag]
      render locals: {
        facade: WelcomeFacade.new(params, current_user)
      }
    #   @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    # else
    #   @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    # end
  end
end
