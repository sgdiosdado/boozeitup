class EventsController < ApplicationController
    before_action :find_event, except: [:index, :create, :new, :my_events, :my_asists]

    def index
    end

    def show
    end

    def new
        @event = Event.new
    end

    def edit
    end

    def my_asists
    end

    def my_events
        @events = Event.all
    end

    def create
        @event = Event.create(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])
        redirect_to @event
    end

    def update
        @event.update(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])

        redirect_to @event
    end

    def destroy
      @event.destroy
      redirect_to root_path
    end

    def confirmation
      redirect_to my_events_path
      flash[:danger] = "Are you sure you want to delete the event? <a class='button is-small' data-method='delete' href='events/#{@event.id}' role='button'> Yes</a>"
    end

    private

    def find_event
        @event = Event.find(params[:id])
    end
end
