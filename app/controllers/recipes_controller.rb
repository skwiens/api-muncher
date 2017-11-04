
require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    @recipes = EdamamApiWrapper.search(params[:term]).paginate(page: params[:page], per_page: 12)

    if @recipes == []
      flash.now[:status] = :error
      flash.now[:result_text] = "Sorry! We couldn't find anything delicious flavours matching #{params[:term]} Please try a different flavor!"
    else
      flash.now[:status] = :success
      flash.now[:result_text] = "Results found for #{params[:term]}"
    end
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])

    if @recipe
      flash.now[:status] = :success
      flash.now[:result_text] = "#{@recipe.name} found!"
    end

    render_404 unless @recipe
  end
end
