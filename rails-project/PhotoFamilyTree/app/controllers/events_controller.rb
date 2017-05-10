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
      @relative_id = params[:relative_id]
  end

  # GET /events/1/edit
  def edit
      @relative_id = params[:relative_id]
  end

  # POST /events
  def create
    #   @relative_id = event_params[:event_owner_id]
      @event = Event.new(event_params)
      if @event.save
          @event.create_owner_tag
          flash[:notice] = 'Event was successfully created.'
          redirect_to :controller => 'relatives', :action => 'show', :id => @event.event_owner_id
      else
          render "new"
      end
  end

  def update
      @relative_id = @event.event_owner_id

      if @event.update(event_params)
          flash[:notice] = "Event was successfully updated."
          redirect_to :controller => 'relatives', :action => 'show', :id => @relative_id
      else
          render 'edit'
      end
  end

  def destroy
      @event.delete_all_tags
      @event.destroy
      flash[:notice] = 'Event was successfully destroyed.'
      redirect_to :controller => 'relatives', :action => 'index'
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
                                        :location,
                                        :event_owner_id )
    end
end
