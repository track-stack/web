class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

  def new
  end

  def show
  end
end
