class EventsController < ApplicationController
    before_action :find_event, except: [:index, :create, :new, :my_events, :my_asists, :event_location_suggestions, :event_get_location_details]
    before_action :authenticate_user!

    # Function: index
    # Gets all the events that are not created by the current user.
    # Returns:
    #   Array of Event objects
    def index
        @events = []
        Event.all.each do |event|
            if (event.creator != current_user.id)
                @events << event
            end
        end
    end

    # Function: show
    # Gets a single Event object and sends it to the view.
    # Also, returns a function to be used at the view.
    # Returns:
    #   Single Event object
    #   Function attending?
    def show
        @attending = attending?
    end

    # Function: new
    # Gets an empty single event object and sends it to the view.
    # Returns:
    #   Empty single Event object
    def new
        @event = Event.new
    end

    # Function: edit
    # Gets a single event object with all the attributes and sends it to the view.
    # Returns:
    #   Single Event object
    def edit
    end

    # Function: my_assists
    # Gets an array of events which the current user is attending to and sends it to the view.
    # Returns:
    #   Array of Event objects
    def my_asists
        @events = []
        Attend.all.each do |attend|
            if (attend.userID == current_user.id)
                @events << Event.find(attend.eventID)
            end
        end
    end

    # Function: my_events
    # Gets an array of events created by the current user and sends it to the view.
    # Returns:
    #   Array of Event objects
    def my_events
        @events = []
        Event.all.each do |event|
            if (event.creator == current_user.id)
                @events << event
            end
        end
    end

    # Function: create
    # Creates a new instance of Event, pass all the parameters from the user and make a persistent record in the database.
    def create
        @event = Event.create(creator: current_user.id,title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], description: params[:event][:description], latitude: params[:event][:latitude], longitude: params[:event][:longitude], address: params[:event][:location])
        redirect_to @event
    end

    # Function: update
    # Updates an existing instance of Event, pass all the parameters from the user and update the persistent record in the database.
    def update
        @event.update(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], latitude: params[:event][:latitude], longitude: params[:event][:longitude], description: params[:event][:description], address: params[:event][:location])
        
        redirect_to @event
    end

    # Function: create_attend
    # Creates a new instance of Attend, pass all the parameters from the user and make a persistent record in the database.
    def create_attend
        @attend = Attend.create(userID: current_user.id, eventID: @event.id)
        redirect_to @event
    end

    # Function: confirmation
    # Loads a partial view of a confirmation menu in another view.
    def confirmation
      flash[:danger]= "<p class='m-b-md'>Are you sure you want to delete this event?</p> <a class='button is-danger is-block center-block' style='width: 50%;'  data-method='delete' href='/events/#{@event.id}'> Yes</a>"
      redirect_to my_events_path
    end

    # Function: destroy
    # Deletes an existing instance of Event from the database.
    def destroy
        Attend.all.each do |attend|
            if (attend.eventID == @event.id)
                attend.destroy
            end
        end
        @event.destroy
        redirect_to my_events_path
    end
    
    # Function: event_location_suggestions
    # Gets the best five matches for the current address typed and returns them.
    # Returns:
    #   Array of Suggestions object
    def event_location_suggestions
        @here = Apis::HereApi.new(params[:address]).get_suggestions
        render json: @here
    end

    # Function: event_get_location_details
    # Gets the details of an specific location.
    # Returns
    #   LocationDetails object
    def event_get_location_details
        @loc = Apis::HereApi.new("").get_location_details(params[:locationid])
        render json: @loc
    end


    private

    # Function: find_event
    # Gets the data of the current event
    # Returns:
    #   Event object
    def find_event
        @event = Event.find(params[:id])
    end

    # Function: attending?
    # Returns true or false depending of the existance of an specific Attend object
    # Returns:
    #   Boolean scalar
    def attending?
        user_id = current_user.id
        event_id = @event.id
        return (Attend.where(userID: user_id, eventID: event_id).empty?)
    end
end
