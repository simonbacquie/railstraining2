class Api::ImagesController < ::ApiController

  def index
    # scope by user
    render status: 200, json: {ee: 1}
  end

  def upload
  end

  def guess
    # check if this is your image
    # check if this image has already been guessed on
    # process guess and save on record
  end

end
