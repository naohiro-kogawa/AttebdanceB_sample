class ApplesController < ApplicationController
  def index
    @apples = Apple.all
  end
 
  def new
    @apples = Apple.new
    respond_to do |format|
      format.html
      format.js
    end
  end
 
  def create
    @apples = Apple.all
    @apple = Apple.new(apple_params)
    respond_to do |format|
      if @apple.save
        format.html
        format.js
      else
        format.js {render :new}
      end
    end
  end
 
  def apple_params
    params.require(:apple).permit(:name)
  end
end
