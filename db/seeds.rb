require_relative("../models/tag.rb")
require_relative("../models/plastic.rb")
require_relative("../models/product.rb")
require("pry-byebug")

Tag.delete_all()

tag1 = Tag.new({
  "category" => "cosmetics"
  })

tag1.save

tag2 = Tag.new({
  "category" => "hot_drink"
  })

tag2.save

tag3 = Tag.new({
  "category" => "plastic_bags"
  })

tag3.save

p Tag.all()
