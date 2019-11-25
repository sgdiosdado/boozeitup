class EventsController < ApplicationController
    before_action :find_event, except: [:index, :create, :new, :my_events, :my_asists, :event_location_suggestions, :event_get_location_details]
    before_action :authenticate_user!
    def index
        @events = []
        Event.all.each do |event|
            if (event.creator != current_user.id)
                @events << event
            end
        end
    end

    def show
        @attending = attending?
    end

    def new
        @event = Event.new
    end

    def edit
    end 

    def my_asists
        @events = []
        Attend.all.each do |attend|
            if (attend.userID == current_user.id)
                @events << Event.find(attend.eventID)
            end
        end
    end
    
    def my_events
        @events = []
        Event.all.each do |event|
            if (event.creator == current_user.id)
                @events << event
            end
        end
    end

    def create
        @event = Event.create(creator: current_user.id,title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], description: params[:event][:description])
        redirect_to @event
    end

    def update
        @event.update(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], latitude: params[:event][:latitude], longitude: params[:event][:longitude], description: params[:event][:description])
        
        redirect_to @event
    end

    def create_attend
        @attend = Attend.create(userID: current_user.id, eventID: @event.id)
        redirect_to @event
    end

    def event_location_suggestions
        @here = Apis::HereApi.new(params[:address]).get_suggestions
        render json: @here
    end

    def event_get_location_details
        @loc = Apis::HereApi.new("").get_location_details(params[:locationid])
        render json: @loc
    end


    private

    def find_event
        @event = Event.find(params[:id])
    end

    def attending?
        user_id = current_user.id
        event_id = @event.id
        return (Attend.where(userID: user_id, eventID: event_id).empty?)
    end
end
