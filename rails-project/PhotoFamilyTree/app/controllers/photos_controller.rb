class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  def index
      @all_photos = Photo.all
  end

  # GET /Photos/1
  def show
      #@photo defined by set (below)
      @relatives = Relative.all
      @photo_tags = PhotoTag.where(photo_id:  @photo.id)
      @poster = @relatives.exists?(@photo.poster_id) ? @relatives.find(@photo.poster_id) : nil
  end

  # GET /Photos/new
  def new
      @relatives = Relative.all
      @photo = Photo.new
  end

  # GET /Photos/1/edit
  def edit
      @relatives = Relative.all
      #@photo defined by set (below)
  end

  # POST /Photos
  def create
      @relatives = Relative.all
      @photo = Photo.new(photo_params)
      if @photo.save
          flash[:notice] = 'Photo was successfully created.'
          redirect_to '/photos'
      else
          render "new"
      end
  end

  def update
      @relatives = Relative.all
      if @photo.update(photo_params)
          flash[:notice] = "Photo was successfully updated."
          redirect_to(:action => 'show', :id => @photo.id)
      else
          render 'edit'
      end
  end

  def destroy
      @photo.destroy
      flash[:notice] = 'Photo was successfully destroyed.'
      redirect_to(:action => 'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
        @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
        params.require(:photo).permit(  :taken_on,
                                        :header,
                                        :caption,
                                        :photograph,
                                        :poster_id,
                                        :location)
    end
end
