class EventsController < ApplicationController
    def index
        @events = Event.all
    end

    def show
        @event = Event.find_by_id(params[:id])
    end

    def create
        @event = Event.new(event_params)
    end

    private
    def event_params
        params.require(:event).permit(:name, :event_type)
    end
end


