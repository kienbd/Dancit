class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @videos = @category.videos.paginate(:page => params[:page],per_page: APP_CONFIG['per_page'])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
