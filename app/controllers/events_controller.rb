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
    end

    def new
        @event = Event.new
    end

    def edit
    end

    def my_asists
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
      flash[:danger] = "Are you sure you want to delete this event? <a class= 'button is-small' data-method='delete' href='/events/#{@event.id}' role='button'> 'Yes'</a>"
      redirect_to my_events_path
    end

    private

    def find_event
        @event = Event.find(params[:id])
    end
end
