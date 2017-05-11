class EventTagsController < ApplicationController
  before_action :set_event_tag, only: [:show, :edit, :update, :destroy]

  # GET /event_tags
  # GET /event_tags.json
  def index
    @event_tags = EventTag.all
  end

  # GET /event_tags/1
  # GET /event_tags/1.json
  def show
  end

  # GET /event_tags/new
  def new
      @relatives = Relative.all
      @event_tag = EventTag.new
      @event_id = params[:event_id]
      @event = Event.find(@event_id)
      @relative_id = params[:relative_id]
  end

  # GET /event_tags/1/edit
  # def edit
  # end

  # POST /event_tags
  # POST /event_tags.json
  def create
    @relatives = Relative.all
    @event_tag = EventTag.new(event_tag_params)
    @events = Event.all
    @event_id = params[:event_id]
    if @event_tag.save
        flash[:notice] = 'Event Tag was successfully created.'
        redirect_to :controller => 'relatives', :action => 'index'
    else
        render "new"
    end
  end

  # PATCH/PUT /event_tags/1
  # PATCH/PUT /event_tags/1.json
  # def update
  #   if @event_tag.update(event_tag_params)
  #       format.html { redirect_to @event_tag, notice: 'Event tag was successfully updated.' }
  #   else
  #       format.html { render :edit }
  #   end
  # end

  # DELETE /event_tags/1
  # DELETE /event_tags/1.json
  def destroy
    if @event_tag.destroy
        redirect_to :controller => 'relatives', :action => 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_tag
      @event_tag = EventTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_tag_params
        params.require(:event_tag).permit(  :event_id,
                                            :relative_id)
    end
end
