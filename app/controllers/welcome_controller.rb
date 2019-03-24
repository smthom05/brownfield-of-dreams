class WelcomeController < ApplicationController
  def index
    render locals: {
      facade: WelcomeFacade.new(params, current_user)
    }
  end
end
