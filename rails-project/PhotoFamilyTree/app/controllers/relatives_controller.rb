class RelativesController < ApplicationController
  before_action :set_relative, only: [:show, :edit, :update, :destroy]

  helper :relatives

  # GET /relatives
  def index
      @relatives = Relative.all
  end

  # GET /relatives/1
  def show
      @event_tags = EventTag.where(relative_id: @relative.id)
      @events = Event.all
      @memories = Memory.all
      @relatives = Relative.all
      @all_event_tags = EventTag.all
      @all_marriage_branches = MarriageBranch.all
      @all_descendant_branches = DescendantBranch.all
      #@relative defined by set (below)
  end

  # GET /relatives/new
  def new
      @relative = Relative.new
  end

  # GET /relatives/1/edit
  def edit
      #@relative defined by set (below)
  end

  # POST /relatives
  def create
      @relative = Relative.new(relative_params)
      if @relative.save
          flash[:notice] = 'Relative was successfully created.'
          @relative.create_birth_event_and_tags
          @relative.create_death_event_and_tags

          redirect_to '/relatives'
      else
          render "new"
      end
  end

  def update
      if @relative.update(relative_params)
          flash[:notice] = "Relative was successfully updated."
          @relative.update_birth_event_and_tags
          @relative.update_death_event_and_tags
          redirect_to(:action => 'show', :id => @relative.id)
      else
          render 'edit'
      end
  end

  def destroy
      @relative.destroy_death_event_and_tags
      @relative.destroy_birth_event_and_tags
      @relative.destroy_all_event_tags
      @relative.destroy_all_photo_tags #but not photos posted
      @relative.destroy
      #will need to destroy photo tags and all branches too
      flash[:notice] = 'Relative was successfully destroyed.'
      redirect_to(:action => 'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relative
        @relative = Relative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relative_params
        params.require(:relative).permit(   :first,
                                            :nickname,
                                            :middle,
                                            :maiden,
                                            :surname,
                                            :suffix,
                                            :sex,
                                            :birthday,
                                            :deathday,
                                            :profile_photo )
    end
end
