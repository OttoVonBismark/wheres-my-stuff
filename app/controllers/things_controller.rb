# frozen_string_literal: true

# ThingsController
class ThingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_member!

  def new
    render locals: { thing: Thing.new }
  end

  def create
    response = permit(Things::CreateThing).call(thing_params: thing_params)

    if response.success?
      flash[:info] = 'Thing saved successfully.'
      redirect_to things_url
    else
      flash[:warning] = 'Unable to save Thing.'
      redirect_back(fallback_location: root_url)
    end
  end

  def show
    render locals: { thing: Thing.find(params[:id]) }
  end

  def index
    render locals: { things: current_user.things }
  end

  def edit
    render locals: { thing: Thing.find(params[:id]) }
  end

  def update
    thing = Thing.find(params[:id])

    if thing.update!
      flash[:info] = 'Thing updated successfully!'
      redirect_to thing
    else
      redirect_back(fallback_location: things_url)
    end
  end

  def destroy
    Thing.find(params[:id]).destroy
    redirect_back(fallback_location: things_url)
  end

  private

  # We're leaving out has_shipped has_due_date and has_arrived because those are for stimulus and have no model refs.
  # You'll see those get rejected when POSTing from the form.
  def thing_params
    params.require(:thing).permit(
      :name,
      :description,
      :ordered_on,
      :shipped_on,
      :tracking_number,
      :due_on,
      :arrived_on,
      :price,
      :user_id
    )
  end
end
