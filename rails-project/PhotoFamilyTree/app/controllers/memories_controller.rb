class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]

  # GET /memories
  def index
      @memories = Memory.all
  end

  # GET /memories/1
  def show
      #@memory defined by set (below)
  end

  # GET /memories/new
  def new
      @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit
      #@memory defined by set (below)
  end

  # POST /memories
  def create
      @memory = Memory.new(memory_params)
      if @memory.save
          flash[:notice] = 'Memory was successfully created.'
          redirect_to '/memories'
      else
          render "new"
      end
  end

  def update
      if @memory.update(memory_params)
          flash[:notice] = "Memory was successfully updated."
          redirect_to(:action => 'show', :id => @memory.id)
      else
          render 'edit'
      end
  end

  def destroy
      @memory.destroy
      flash[:notice] = 'Memory was successfully destroyed.'
      redirect_to(:action => 'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
        @memory = Memory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memory_params
        params.require(:memory).permit(  :when,
                                        :content,
                                        :location )
    end
end
