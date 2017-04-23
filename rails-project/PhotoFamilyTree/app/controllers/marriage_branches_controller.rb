class MarriageBranchesController < ApplicationController
  before_action :set_marriage_branch, only: [:show, :edit, :update, :destroy]

  # GET /marriage_branches
  def index
      @marriage_branches = MarriageBranch.all
  end

  # GET /marriage_branches/1
  def show
      #@marriage_branch defined by set (below)
  end

  # GET /marriage_branches/new
  def new
      @marriage_branch = MarriageBranch.new
      @relatives = Relative.all

      @husband_id = params[:husband_id]
      @wife_id = params[:wife_id]


  end

  # GET /marriage_branches/1/edit
  def edit
      @husband_id = @marriage_branch.husband_id
      @wife_id = @marriage_branch.wife_id
      @relatives = Relative.all
  end

  # POST /marriage_branches
  def create
      @husband_id = params[:husband_id]
      @wife_id = params[:wife_id]

      @marriage_branch = MarriageBranch.new(marriage_branch_params)
      @relatives = Relative.all

      if @marriage_branch.save
          flash[:notice] = 'Marriage branch was successfully created.'
          @marriage_branch.create_anniversary_event_and_tags
          @marriage_branch.create_marriage_end_event_and_tags

          redirect_to :controller => 'relatives', :action => 'index'
      else
          render "new"
      end
  end

  def update
      @husband_id = @marriage_branch.husband_id
      @wife_id = @marriage_branch.wife_id
      @relatives = Relative.all
      if @marriage_branch.update(marriage_branch_params)
          flash[:notice] = "Marriage branch was successfully updated."
          @marriage_branch.update_anniversary_event_and_tags
          @marriage_branch.update_marriage_end_event_and_tags
          redirect_to :controller => 'relatives', :action => 'index'
      else
          render 'edit'
      end
  end

  def destroy
      @marriage_branch.destroy_anniversary_event_and_tags
      @marriage_branch.destroy_marriage_end_event_and_tags

      @marriage_branch.destroy
      flash[:notice] = 'Marriage branch was successfully destroyed.'
      redirect_to :controller => 'relatives', :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marriage_branch
        @marriage_branch = MarriageBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marriage_branch_params
        params.require(:marriage_branch).permit(    :husband_id,
                                                    :wife_id,
                                                    :anniversary,
                                                    :marriage_end )
    end
end
