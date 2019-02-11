class Borrow::CategoriesController < Borrow::ApplicationController
  def index(category_id = params[:category_id])
    categories = (current_user.all_categories & Category.find(category_id).children).sort

    output = categories.map { |category| { id: category.id, name: category.label(category_id) } }

    render json: output
  end
end
