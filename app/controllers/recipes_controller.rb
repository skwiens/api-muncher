
require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    @recipes = EdamamApiWrapper.search(params[:term]).paginate(page: params[:page], per_page: 12)
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])

    render_404 unless @recipe
  end
end
