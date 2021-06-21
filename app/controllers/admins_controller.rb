# frozen_string_literal: true

# AdminsController - for all the things that Admins should be able to do.
class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def users_index
    render locals: { users: User.all }
  end

  def users_show
    render locals: { user: User.find(params[:id]) }
  end
  
  def things_index
    render locals: {
      things: Thing.all,
      things_due_this_week: Thing.all.due_this_week,
      things_due_this_month: Thing.all.due_this_month,
      things_arrived_this_week: Thing.all.arrived_this_week,
      things_arrived_this_month: Thing.all.arrived_this_month
    }
  end
end
