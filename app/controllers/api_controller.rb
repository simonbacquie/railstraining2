class ApiController < ApplicationController

  before_filter :authenticate_request!

end
