class PhotoTagsController < ApplicationController
  before_action :set_photo_tag, only: [:show, :edit, :update, :destroy]

  # GET /photo_tags
  # GET /photo_tags.json
  def index
    @photo_tags = PhotoTag.all
  end

  # GET /photo_tags/1
  # GET /photo_tags/1.json
  def show

  end

  # GET /photo_tags/new
  def new
    @photo_tag = PhotoTag.new
    @photos = Photo.all
    @relatives = Relative.all
  end

  # GET /photo_tags/1/edit
  def edit
      @photos = Photo.all
      @relatives = Relative.all
  end

  # POST /photo_tags
  # POST /photo_tags.json
  def create
    @photo_tag = PhotoTag.new(photo_tag_params)
    @photos = Photo.all
    @relatives = Relative.all
    if @photo_tag.save
        flash[:notice] = 'Photo Tag was successfully created.'
        redirect_to :controller => 'photos', :action => "show", :id => @photo_tag.photo_id
    else
        render "new"
    end
  end

  # PATCH/PUT /photo_tags/1
  # PATCH/PUT /photo_tags/1.json
  def update
      @photos = Photo.all
      @relatives = Relative.all
      if @photo_tag.update(photo_tag_params)
          flash[:notice] = "Photo tag was successfully updated."
          redirect_to :controller => 'photos', :action => 'index'
      else
         render 'edit'
     end
  end

  # DELETE /photo_tags/1
  # DELETE /photo_tags/1.json
  def destroy
    @photo_id = @photo_tag.photo_id
    @photo_tag.destroy
    flash[:notice] = 'Photo Tag was successfully destroyed.'
    redirect_to :controller => 'photos', :action => "show", :id => @photo_id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo_tag
      @photo_tag = PhotoTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_tag_params
        params.require(:photo_tag).permit(  :photo_id,
                                            :relative_id)
    end
end
