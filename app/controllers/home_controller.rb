
class HomeController < ApplicationController
  before_action :check_log_in, :only => [:upload]
  before_action :get_image, :only => [:update, :delete_image, :detail]
  
  
  def index
  	@title = "Fake - Home"
  	@images = Image.all
  end
  # GET upload page UI
  def upload
    @title = "Fake - Upload image"
  	@image = Image.new
  end
  #POST upload image
  def upload_image
    #account = Account.find_by_email(session[:name])
    uploaded_io = params[:image][:url]
    unless uploaded_io.nil?
      title = params[:image][:title]
      @image = current_account.images.new(:url => uploaded_io.original_filename, :title => title, :like => 0)
      if @image.save
        File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        redirect_to root_path
      end
    else
        render :upload
    end
  end
  #GET UI FLICKR
  def flickr_photo
    @title = "Fake - Flickr photo"
    require 'flickraw'

    FlickRaw.api_key="6c104f421e1d9e0f4d2aa1ce118cbea8"
    FlickRaw.shared_secret="6ba05fe9fad16d5c"
    @list   = flickr.photos.getRecent

    # - @list.each do |img|
    # - @info = flickr.photos.getInfo(:photo_id => img.id)
    # img src=FlickRaw.url_b(@info) height="297px" 
  end
  #Get image of user
  def image
    @title = "Fake - Image"
    #@account = Account.find_by_email(session[:name])
    #@images = current_account.images
  end
  #edit image
  def edit
    @title = "Fake - Update image"
    #@account = Account.find_by_email(session[:name])
    @images = current_account.images
  end

  def update
    #@image = Image.find(params[:id])
    @image.title = params[:title]
    if @image.save
      redirect_to edit_home_index_path
    end
  end
  
  def delete_image
    #@image = Image.find(params[:id]) 
    path = Rails.root + "public/uploads/#{@image.url}"
    File.delete(path) if File::exist?(path)
    if @image.destroy
      redirect_to edit_home_index_path
    end
  end

  def detail
    #@image = Image.find(params[:id])
    @images = Image.where(:account_id => @image.account_id).take(5)
  end

  private
  def check_log_in
    if session[:name].nil?
      redirect_to sign_in_account_index_path
    end
  end

  def get_image
    @image = Image.find(params[:id])
  end

  def current_account
    @account = Account.find_by_email(session[:name])
  end
end
