class FriendsController < ApplicationController
  def create
    friend = User.find_by(uid: params[:friend])
    new_friend = Friend.new(friend_id: friend.id, user_id: current_user.id)
    flash[:error] = 'Invalid Friendship' unless new_friend.save
    redirect_to dashboard_path
  end
end
