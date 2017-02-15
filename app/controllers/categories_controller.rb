class CategoriesController < ApplicationController

  def index
    @categories =
      if params[:children]
        if params[:category_id]
          if params[:category_id] == '-1'
            []
          else
            Category.find(params[:category_id]).children
          end
        elsif params[:category_ids]
          Category.find(params[:category_ids]).map(&:children)
        end
      else
        Category.all
      end
  end

  def image
    category = Category.find params[:id]
    if category.image.nil?
      render status: :not_found, nothing: true
    else
      redirect_to get_image_path(category.image.id)
    end
  end

end
