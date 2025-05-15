# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

puts "Cleaning DB..."
Bookmark.destroy_all
Recipe.destroy_all
Category.destroy_all

puts "Creating new recipes..."
Recipe.create!(
  name: "Spaghetti",
  description: "Caramelized tomato sauce makes this a wonderfully savory dish. The reduction of the tomato broth brings out the sweetness of the tomatoes which balances well with the spiciness of the chili flakes.",
  image_url: "https://www.allrecipes.com/thmb/d7abApqc-ESWQ2WYOm8p07kune4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/ALR-8534000-spaghetti-allassassina-assassins-spaghetti-VAT-hero-4x3-b-f3617177055043949f46673b7d44c701.jpg",
  rating: 5)
Recipe.create!(
  name: "Pizza",
  description: "This is a great recipe when you don't want to wait for the dough to rise. You just mix it and allow it to rest for 5 minutes and then it's ready to go! It yields a soft, chewy crust.",
  image_url: "https://www.allrecipes.com/thmb/6ZAAX_NKYS6JjWd9ojfW8aX6f88=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/ALR-20171-quick-and-easy-pizza-crust-VAT-4x3-2-229693959a224d749b062d4eb8983351.jpg",
  rating: 4)
Recipe.create!(
  name: "Fries",
  description: "These butternut squash fries are baked in the oven until tender-crisp for a tasty and nutritious side dish! They taste like sweet potato fries but better!",
  image_url: "https://www.allrecipes.com/thmb/3HugpQEwRJIJrsVMD2F1uKkf_og=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/717440-f9d9eb1cb8af40eeb86fb03e3636fc43.jpg",
  rating: 3)
Recipe.create!(
  name: "Chinese Noodles",
  description: "These stir fried noodles with ramen and veggies are a quick, easy, and delicious recipe that all will enjoy. Try adding cooked, cubed pork, chicken, or any of your favorite vegetables to this versatile recipe.",
  image_url: "https://www.allrecipes.com/thmb/zgklY_B5OQ50982x-5wBz5S9kzs=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/34668-chinese-fried-noodles-VAT-013-4x3-01-f85522393cbe4e81b8053dc60cd04252.jpg",
  rating: 3.5)
Recipe.create!(
  name: "Garlic Bread",
  description: "Easy roasted garlic bread made with roasted garlic, butter, and Parmesan cheese.",
  image_url: "https://www.allrecipes.com/thmb/o922AaTlEYbnCxi5ySonP_zICbo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/797993-d6d41b02c0a9467785575745de2558c8.jpg",
  rating: 4.5)

  puts "#{Recipe.count} recipes created"

  def recipe_builder(id)
    url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
    meal_serialized = URI.parse(url).read
    meal = JSON.parse(meal_serialized)["meals"][0]

    Recipe.create!(
      name: meal["strMeal"],
      description: meal["strInstructions"],
      image_url: meal["strMealThumb"],
      rating: rand(2..5.0).round(1)
    )
  end

  categories = ["Breakfast", "Pasta", "Seafood", "Dessert"]

  categories.each do |category|
    url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
    recipe_list = URI.parse(url).read
    recipes = JSON.parse(recipe_list)
    recipes["meals"].take(5).each do |recipe|
      p recipe["idMeal"]
    end
  end

  puts "Done! #{Recipe.count} recipes created."
