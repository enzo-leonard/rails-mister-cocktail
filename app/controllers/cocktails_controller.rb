class CocktailsController < ApplicationController

  before_action :find_cocktail, only: [ :show, :destroy, :edit, :update]

  def index
    if params[:get]
      if params[:get][:ig].size < 3
        ig_id = params[:get][:ig][1]
        ig = Ingredient.find(ig_id)
        sql = "ingredient_id = #{ig_id}"
        @cocktails = Cocktail.joins(:ingredients).where(sql)
        @result_msg = "Liste des cocktails avec : #{ig.name} "
      else

        array_id = []
        params[:get][:ig].each { |id| array_id << id if id!=''}
        array_name = []
        array_id.each { |id| array_name << Ingredient.find(id).name}
        sql = "doses.ingredient_id = #{array_id[0]} "

        array_id.each do |id|
          sql+= "and doses.ingredient_id = #{id} "
        end

        s = " doses.ingredient_id = 2074 and doses.ingredient_id = 2097 "

        #mojito = 1268
        ig1 = Cocktail.joins(:ingredients).where("ingredient_id = 2074").map {|x| x.name }
        ig2 = Cocktail.joins(:ingredients).where("ingredient_id = 2097").map {|x| x.name }
        ig1 & ig2
        #@result_msg = "Voici les cocktails que tu peux faire avec : #{array_name} "
        @result_msg = sql
        @cocktails = Cocktail.joins(:doses).where(s)
      end

      @cocktails = Cocktail.where(id: params[:get][:name]) if params[:get][:name].present?
    else
      @cocktails = Cocktail.all.order(:id)
      @result_msg = "Liste de tout les cocktails"
    end
  end

  def new
    @cocktail = Cocktail.new
  end

  def edit
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save

    redirect_to cocktails_path
  end

  def update
  end

  def destroy
  end

  def show
    @cocktail.description = read_description(@cocktail.description)
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

  def read_description(description)
    description.gsub(/\n/, '').strip
  end


end
