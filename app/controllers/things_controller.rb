# frozen_string_literal: true

# ThingsController
class ThingsController < ApplicationController
  def new
    render locals: { thing: Thing.new }
  end

  def create
    thing = Thing.new(thing_params)

    if thing.save
      # flash[:info] = 'Thing saved successfully.'
      redirect_to things_url
    else
      # flash[:warning] = "Shit's broke, yo!"
      redirect_back(fallback_location: root_url)
    end
  end

  def show
    render locals: { thing: Thing.find(params[:id]) }
  end

  def index
    render locals: { things: Thing.all }
  end

  def edit
    render locals: { thing: Thing.find(params[:id]) }
  end

  def update
    thing = Thing.find(params[:id])

    if thing.update
      # flash[:info] = "Thing updated successfully!"
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

  def thing_params
    params.require(:thing).permit(
                            :name,
                            :description,
                            :ordered_on,
                            :shipped_on,
                            :tracking_number,
                            :due_on,
                            :arrived_on
                          )
  end
end
