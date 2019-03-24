class FriendsController < ApplicationController
  def create
    friend = User.find_by(uid: params[:friend])
    new_friend = Friend.new(friend_id: friend.id, user_id: current_user.id)
    unless new_friend.save
      flash[:error] = "Invalid Friendship"
    end
    
    redirect_to dashboard_path
  end

end
