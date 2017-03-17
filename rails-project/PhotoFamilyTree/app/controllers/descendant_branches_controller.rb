class DescendantBranchesController < ApplicationController
  before_action :set_descendant_branch, only: [:show, :edit, :update, :destroy]

  # GET /descendant_branches
  def index
      @descendant_branches = DescendantBranch.all
  end

  # GET /descendant_branches/1
  def show
      #@descendant_branch defined by set (below)
  end

  # GET /descendant_branches/new
  def new
      @descendant_branch = DescendantBranch.new
  end

  # GET /descendant_branches/1/edit
  def edit
      #@descendant_branch defined by set (below)
  end

  # POST /descendant_branches
  def create
      @descendant_branch = DescendantBranch.new(descendant_branch_params)
      if @descendant_branch.save
          flash[:notice] = 'Descendant branch was successfully created.'
          redirect_to '/descendant_branches'
      else
          render "new"
      end
  end

  def update
      if @descendant_branch.update(descendant_branch_params)
          flash[:notice] = "Descendant branch was successfully updated."
          redirect_to(:action => 'show', :id => @descendant_branch.id)
      else
          render 'edit'
      end
  end

  def destroy
      @descendant_branch.destroy
      flash[:notice] = 'Descendant branch was successfully destroyed.'
      redirect_to(:action => 'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descendant_branch
        @descendant_branch = DescendantBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def descendant_branch_params
        params.require(:descendant_branch).permit(  :parent_id,
                                                    :child_id )
    end
end
