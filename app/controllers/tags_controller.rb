class TagsController < ApplicationController
    before_action :authorize_request
  
    def index
      @tags = Tag.all
      render json: @tags
    end
  end
  