class WelcomeFacade

  def initialize(params, current_user)
    @params = params
    @user = current_user
  end

  def tutorials
    if @user.class == User
      users_tutorials
    else
      visitors_tutorials
    end
  end

  def users_tutorials
    if @params[:tag]
      Tutorial.tagged_with(@params[:tag]).paginate(page: @params[:page], per_page: 5)
    else
      Tutorial.all.paginate(page: @params[:page], per_page: 5)
    end
  end

  def visitors_tutorials
    if @params[:tag]
      Tutorial.where(classroom: false).tagged_with(@params[:tag]).paginate(page: @params[:page], per_page: 5)
    else
      Tutorial.where(classroom: false).paginate(page: @params[:page], per_page: 5)
    end
  end

end
