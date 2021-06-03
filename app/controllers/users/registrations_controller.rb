# frozen_string_literal: true

# User Registrations Controller
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    response = Users::CreateUser.call(user_info: user_params)

    if response.success?
      flash[:notice] = 'Account successfully created. Please check your email for confirmation instructions.'
      redirect_to root_url
    else
      flash[:alert] = 'Unable to create account.'
      render :new, locals: { resource: response.user }
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
