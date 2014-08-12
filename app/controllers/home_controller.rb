class HomeController < ApplicationController
  def index
  	@title = "Trang chu"
  	@images = Image.all
  end
end
