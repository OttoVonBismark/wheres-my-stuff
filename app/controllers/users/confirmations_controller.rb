# frozen_string_literal: true

# User Confirmations Controller
class Users::ConfirmationsController < Devise::ConfirmationsController
  def update
    token = params[:confirmation_token]
    user = User.find_or_initialize_with_error_by(:confirmation_token, token)
    user_auth_info = user_params.extract!(:password, :password_confirmation)

    results = Users::ConfirmUser.call(user: user, user_info: user_params, user_auth_info: user_auth_info)

    case results.status
    when :needs_password
      render :show, locals: { resource: results.data, requires_password: true, confirmation_token: token }
    when :errors
      render :new, locals: { resource: results.data }
    when :complete
      flash[:notice] = :confirmed
      redirect_to root_url
    end
  end

  def show
    token = params[:confirmation_token]
    user = User.find_or_initialize_with_error_by(:confirmation_token, token)

    results = Users::ConfirmUser.call(user: user)
    case results.status
    when :needs_password
      results.data.errors.clear

      render :show, locals: { resource: results.data, requires_password: true, confirmation_token: token }
    when :has_errors
      render :new, locals: { resource: user }
    when :complete
      flash[:notice] = :confirmed
      redirect_to root_url
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
