class GameInvitesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :accept]

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
      flash[:error] = "❌ The invitation couldn't be found"
      return redirect_to "/"
    end

    unless invite.pending?
      flash[:error] = "❌ This invitation has already been accepted"
      return redirect_to "/"
    end

    unless invite.invitee_id == current_user.id
      flash[:error] = "❌ That invite doesn't belong to you"
      return redirect_to "/"
    end

    begin
      game = Game.from(invite: invite, invitee: current_user)
      redirect_to game_path(game)
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
