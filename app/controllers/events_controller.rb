class EventsController < ApplicationController
    before_action :find_event, except: [:index, :create, :new, :my_events, :my_asists]
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
        @event = Event.create(creator: current_user.id,title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])
        redirect_to @event
    end

    def update
        @event.update(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])

        redirect_to @event
    end

    def destroy
      @event.destroy
      redirect_to my_events_path
    end

    def confirmation
      flash[:danger] = "Are you sure you want to delete this event? <a class='button is-danger is-block center-block' style='width: 50%;' data-method='delete' href='/events/#{@event.id}'> Yes</a>"
      redirect_to my_events_path
    end

    def create_attend
        @attend = Attend.create(userID: current_user.id, eventID: @event.id)
        redirect_to @event
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
