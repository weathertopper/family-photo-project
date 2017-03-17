class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
      @events = Event.all
  end

  # GET /events/1
  def show
      #@event defined by set (below)
  end

  # GET /events/new
  def new
      @event = Event.new
  end

  # GET /events/1/edit
  def edit
      #@event defined by set (below)
  end

  # POST /events
  def create
      @event = event.new(event_params)
      if @event.save
          flash[:notice] = 'Event was successfully created.'
          redirect_to '/events'
      else
          render "new"
      end
  end

  def update
      if @event.update(event_params)
          flash[:notice] = "Event was successfully updated."
          redirect_to(:action => 'show', :id => @event.id)
      else
          render 'edit'
      end
  end

  def destroy
      @event.destroy
      flash[:notice] = 'Event was successfully destroyed.'
      redirect_to(:action => 'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
        @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
        params.require(:event).permit(  :when,
                                        :content,
                                        :location )
    end
end
