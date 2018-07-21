require_relative("../models/tag.rb")
require_relative("../models/plastic.rb")
require_relative("../models/product.rb")
require("pry-byebug")

Tag.delete_all()
Plastic.delete_all()

tag1 = Tag.new({
  "category" => "cosmetics"
  })
# tag1.save

tag2 = Tag.new({
  "category" => "hot_drink"
  })
tag2.save
tag2.category="takeaway_drink"
tag2.update
p tag2

tag3 = Tag.new({
  "category" => "plastic_bags"
  })
# tag3.save
# tag3.delete
# p Tag.all()

plastic1 = Plastic.new({
  'type' => 'PET1',
  'existance' => 750,
  'weight' => 40
  })
plastic1.save()

plastic2 = Plastic.new({
  'type' => 'PET1',
  'existance' => 450,
  'weight' => 40
})
plastic2.save()
