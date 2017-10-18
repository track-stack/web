class GameInvitesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    return redirect_to "/games/new" unless invitee

    if invitation = GameInvite.create(invitee_id: invitee.id, inviter_id: current_user.id)
      redirect_to :root
    else
      flash[:error] = "There was a problem inviting #{invitee.name}"
      redirect_to "/games/new"
    end
  end

  private

  def invitee
    User.find_by(uid: params[:uid])
  end
end
