class DescendantBranchesController < ApplicationController
  before_action :set_descendant_branch, only: [:show, :edit, :update, :destroy]

  # GET /descendant_branches
  # GET /descendant_branches.json
  def index
    @descendant_branches = DescendantBranch.all
  end

  # GET /descendant_branches/1
  # GET /descendant_branches/1.json
  def show
  end

  # GET /descendant_branches/new
  def new
    @descendant_branch = DescendantBranch.new
  end

  # GET /descendant_branches/1/edit
  def edit
  end

  # POST /descendant_branches
  # POST /descendant_branches.json
  def create
    @descendant_branch = DescendantBranch.new(descendant_branch_params)

    respond_to do |format|
      if @descendant_branch.save
        format.html { redirect_to @descendant_branch, notice: 'Descendant branch was successfully created.' }
        format.json { render :show, status: :created, location: @descendant_branch }
      else
        format.html { render :new }
        format.json { render json: @descendant_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descendant_branches/1
  # PATCH/PUT /descendant_branches/1.json
  def update
    respond_to do |format|
      if @descendant_branch.update(descendant_branch_params)
        format.html { redirect_to @descendant_branch, notice: 'Descendant branch was successfully updated.' }
        format.json { render :show, status: :ok, location: @descendant_branch }
      else
        format.html { render :edit }
        format.json { render json: @descendant_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descendant_branches/1
  # DELETE /descendant_branches/1.json
  def destroy
    @descendant_branch.destroy
    respond_to do |format|
      format.html { redirect_to descendant_branches_url, notice: 'Descendant branch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descendant_branch
      @descendant_branch = DescendantBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def descendant_branch_params
      params.fetch(:descendant_branch, {})
    end
end
