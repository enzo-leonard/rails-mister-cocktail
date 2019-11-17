
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'lancement du seed...'
Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

# Ingredient.create!(name: "lemon")
# Ingredient.create!(name: "ice")
# Ingredient.create!(name: "mint leaves")


# Cocktail.create!(name: "mojito")
# Cocktail.create!(name: "mazut")
# Cocktail.create!(name: "vodka tagada")

require 'nokogiri'

url = "https://www.1001cocktails.com/recettes/selection_96-grands-classiques.aspx"
url2= "https://www.1001cocktails.com/recettes/selection_96-grands-classiques.aspx?page=2"
url3= "https://www.1001cocktails.com/recettes/selection_96-grands-classiques.aspx?page=3"
url4= "https://www.1001cocktails.com/recettes/selection_96-grands-classiques.aspx?page=4"


def fetch_cocktail(url)
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  arg_cocktail = {}
  arg_dose = {}
  i = 0
  html_doc.search('.recipe-card').each do |element|


    i += 1
    puts '-------------'
    print "cocktail : #{i} - "
    cocktail = ""

    element.search('.recipe-card__add-to-notebook').each do |item|
      arg_cocktail[:photo] = item.attribute('data-recipe-thumbnail').value
      arg_cocktail[:name] = item.attribute('data-recipe-title').value

      cocktail = Cocktail.new(arg_cocktail)
      cocktail.save
      puts "name : #{cocktail.name} "
      #puts "photo : #{item.attribute('data-recipe-thumbnail').value} "
      puts '-------------'
    end

    element.search('.recipe-card-link').each do |item|
      link = item.attribute('href').value
      ingredients = fetch_ingredient(link, cocktail)
      #puts "ingredient : #{ingredients}"
    end


  end
end

url_ingredient = "https://www.1001cocktails.com/recettes/recette_mojito_354965.aspx"

def fetch_ingredient(link, cocktail)
  html_file = open(link).read
  html_doc = Nokogiri::HTML(html_file)
  ingredients = []

  html_doc.search('.recipe-preparation__list').each do |item|

    cocktail.description = item.text.delete("\t").gsub(/(Etape.\d)/, '- \1'+": \n")
    cocktail.save
    puts "----\n\ndescription de la recette : \n #{cocktail.description}"
  end

  html_doc.search('.recipe-ingredients__list').each do |item|
    item.search('div').each do |ingredient|
      nom_ingredient = ingredient.text
      .gsub('cl de ', '')
      .gsub("cl d'", '')
      .gsub(/\d+/,"")
      .gsub('.',"")
      .gsub('/',"")
      .gsub('cuillère à café de ', '')
      .strip.downcase
      ingredients << nom_ingredient

      if Ingredient.find_by(name: nom_ingredient)
        finded = Ingredient.find_by(name: nom_ingredient)
      else
        p "new ingredient : #{nom_ingredient}"
        i = Ingredient.new(name: nom_ingredient)
        i.save!
        finded = i
      end


      arg_dose = {
        description: ingredient.text,
        cocktail_id: cocktail.id,
        ingredient_id: finded.id
      }
      dose = Dose.new(arg_dose)
      dose.save
    end
  end
  ingredients
end

fetch_cocktail(url)
fetch_cocktail(url2)
fetch_cocktail(url3)
fetch_cocktail(url4)




# url_ingredients = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

# def generator_list(array)
#   array.each do |item|
#     Ingredient.create!(name: item['strIngredient1'])
#   end
# end


# def generator_from_json(url)
#   url_ingredients_readed = open(url).read
#   result = JSON.parse(url_ingredients_readed)
#   generator_list(result['drinks'])
# end


# generator_from_json(url_ingredients)


puts 'fin du seed'
puts "--------\n"

Ingredient.all.each { |item| puts item.name}
Cocktail.all.each { |item| puts item.name}
Dose.count




