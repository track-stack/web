class PagesController < ApplicationController
  def index
    render "pages/index", locals: { view: Pages::IndexView.new(user: current_user) }
  end
end
