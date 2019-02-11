class Manage::RoomsController < Manage::ApplicationController
  include RoomsDiff

  def index
    @rooms = Room.where(building_id: building_id_param).order(:name)

    respond_to(&:json)
  end

  private

  def building_id_param
    params.require(:building_id)
  end
end
