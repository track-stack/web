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

  def accept
    unless invite
      flash[:error] = "We couldn't find the invite"
      return redirect_to "/"
    end

    unless invite.invitee_id == current_user.id
      flash[:error] = "You can't accept someone else's invite"
      return redirect_to "/"
    end

    begin
      invite.accept!
      redirect_to "/"
    rescue
      flash[:error] = "We weren't able to accept this invite"
      redirect_to "/"
    end
  end

  private

  def invite
    GameInvite.find_by(id: params[:game_invite_id])
  end

  def invitee
    User.find_by(uid: params[:uid])
  end
end
