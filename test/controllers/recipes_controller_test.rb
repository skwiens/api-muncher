require "test_helper"

describe RecipesController do
  describe "home" do
    it "successfully opens" do
      VCR.use_cassette("home") do
        get root_path
        must_respond_with :success
        flash[:status].must_equal :success
      end
    end
  end

  describe "index" do
    it "successfully loads but sends an error message for an empty search" do
      VCR.use_cassette("index_action") do
        get recipes_path
        must_respond_with :success
        flash[:status].must_equal :error
      end
    end

    it "successfully loads page with many recipes" do
      VCR.use_cassette("index_action") do
        get recipes_path("water")
        must_respond_with :success
        flash[:status].must_equal :success
      end
    end

    it "successfully loads for a bogus search" do
      VCR.use_cassette("index_action") do
        get recipes_path("l24ft")
        must_respond_with :success
        flash[:status].must_equal :error
      end
    end
  end

  describe "show" do
    let(:uri) {URI.encode("http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2")}

    it "loads the show page" do
      VCR.use_cassette("show_action") do
        recipe = EdamamApiWrapper.item_search(uri)
        get recipe_path(recipe.name, uri: recipe.uri )
        must_respond_with :success
        flash[:status].must_equal :success
      end
    end

    it "renders a 404 if the recipe is not found" do
      VCR.use_cassette("show_action") do
        get recipe_path("Bogus")
        must_respond_with :not_found
      end
    end

  end
end
