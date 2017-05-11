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
      @relatives = Relative.all
      @child_id = params[:child_id]
      @parent_type = params[:parent_type]
  end

  # GET /descendant_branches/1/edit
  def edit
      @relatives = Relative.all
      @child_id = @descendant_branch.child_id
      @parent_type = @descendant_branch.parent_type
      #@descendant_branch defined by set (below)
  end

  # POST /descendant_branches
  def create
      @relatives = Relative.all
      @child_id = descendant_branch_params[:child_id]
      @parent_type = descendant_branch_params[:parent_type]
      @descendant_branch = DescendantBranch.new(descendant_branch_params)
      if @descendant_branch.save
          # => need to update all birth & death events
          parent = @relatives.find(@descendant_branch.parent_id)
          child = @relatives.find(@descendant_branch.child_id)
          parent.update_birth_event_and_tags
          parent.update_death_event_and_tags
          child.update_birth_event_and_tags
          child.update_death_event_and_tags

          flash[:notice] = 'Descendant branch was successfully created.'
          redirect_to :controller => 'relatives', :action => 'index'
      else
          render "new"
      end
  end

  def update
      @relatives = Relative.all
      @child_id = @descendant_branch.child_id
      @parent_type = @descendant_branch.parent_type
      if @descendant_branch.update(descendant_branch_params)
          # => need to update all birth & death events
          parent = @relatives.find(@descendant_branch.parent_id)
          child = @relatives.find(@descendant_branch.child_id)
          parent.update_birth_event_and_tags
          parent.update_death_event_and_tags
          child.update_birth_event_and_tags
          child.update_death_event_and_tags

          flash[:notice] = "Descendant branch was successfully updated."
          redirect_to :controller => 'relatives', :action => 'index'
      else
          render 'edit'
      end
  end

  def destroy
      @descendant_branch.destroy

      @relatives = Relative.all
      # => need to update all birth & death events
      parent = @relatives.find(@descendant_branch.parent_id)
      child = @relatives.find(@descendant_branch.child_id)
      parent.update_birth_event_and_tags
      parent.update_death_event_and_tags
      child.update_birth_event_and_tags
      child.update_death_event_and_tags

      flash[:notice] = 'Descendant branch was successfully destroyed.'
      redirect_to :controller => 'relatives', :action => 'show', :id => child.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descendant_branch
        @descendant_branch = DescendantBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def descendant_branch_params
        params.require(:descendant_branch).permit(  :parent_id,
                                                    :child_id,
                                                    :parent_type )
    end
end
