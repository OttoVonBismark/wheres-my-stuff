# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Authorization::Helpers

  rescue_from Authorization::NotAuthorizedError, with: :account_not_authorized

  private

  def account_not_authorized
    flash[:alert] = 'You do not have access to that.'
    redirect_back(fallback_location: root_path)
  end
end
