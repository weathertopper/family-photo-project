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
  end

  # GET /marriage_branches/1/edit
  def edit
      #@marriage_branch defined by set (below)
  end

  # POST /marriage_branches
  def create
      @marriage_branch = MarriageBranch.new(marriage_branch_params)
      if @marriage_branch.save
          flash[:notice] = 'Marriage branch was successfully created.'
          redirect_to '/marriage_branches'
      else
          render "new"
      end
  end

  def update
      if @marriage_branch.update(marriage_branch_params)
          flash[:notice] = "Marriage branch was successfully updated."
          redirect_to(:action => 'show', :id => @marriage_branch.id)
      else
          render 'edit'
      end
  end

  def destroy
      @marriage_branch.destroy
      flash[:notice] = 'Marriage branch was successfully destroyed.'
      redirect_to(:action => 'index')
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
                                                    :end )
    end
end
