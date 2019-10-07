class EventsController < ApplicationController
    before_action :find_event, except: [:index, :create, :new]
    
    def index
        @events = Event.all
    end

    def show
    end

    def new
        @event = Event.new
    end

    def edit
    end

    def create
        @event = Event.create(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])
        redirect_to @event
    end

    def update
        @event.update(title: params[:event][:title], cover: params[:event][:cover], date: params[:event][:date], location: params[:event][:location], description: params[:event][:description])
        
        redirect_to @event
    end

    private

    def find_event
        @event = Event.find(params[:id])
    end
end
