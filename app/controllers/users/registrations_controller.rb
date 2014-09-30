class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  protect_from_forgery with: :null_session

  def create
    puts params[:stripeToken]
    super
  end

  def new
    super
  end

  def edit
    super
  end
end
