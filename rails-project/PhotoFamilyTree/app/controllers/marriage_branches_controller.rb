class MarriageBranchesController < ApplicationController
  before_action :set_marriage_branch, only: [:show, :edit, :update, :destroy]

  # GET /marriage_branches
  # GET /marriage_branches.json
  def index
    @marriage_branches = MarriageBranch.all
  end

  # GET /marriage_branches/1
  # GET /marriage_branches/1.json
  def show
  end

  # GET /marriage_branches/new
  def new
    @marriage_branch = MarriageBranch.new
  end

  # GET /marriage_branches/1/edit
  def edit
  end

  # POST /marriage_branches
  # POST /marriage_branches.json
  def create
    @marriage_branch = MarriageBranch.new(marriage_branch_params)

    respond_to do |format|
      if @marriage_branch.save
        format.html { redirect_to @marriage_branch, notice: 'Marriage branch was successfully created.' }
        format.json { render :show, status: :created, location: @marriage_branch }
      else
        format.html { render :new }
        format.json { render json: @marriage_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marriage_branches/1
  # PATCH/PUT /marriage_branches/1.json
  def update
    respond_to do |format|
      if @marriage_branch.update(marriage_branch_params)
        format.html { redirect_to @marriage_branch, notice: 'Marriage branch was successfully updated.' }
        format.json { render :show, status: :ok, location: @marriage_branch }
      else
        format.html { render :edit }
        format.json { render json: @marriage_branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marriage_branches/1
  # DELETE /marriage_branches/1.json
  def destroy
    @marriage_branch.destroy
    respond_to do |format|
      format.html { redirect_to marriage_branches_url, notice: 'Marriage branch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marriage_branch
      @marriage_branch = MarriageBranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marriage_branch_params
      params.fetch(:marriage_branch, {})
    end
end
