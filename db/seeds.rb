require_relative("../models/tag.rb")
require_relative("../models/plastic.rb")
require_relative("../models/product.rb")
require("pry-byebug")

Product.delete_all()
Tag.delete_all()
Plastic.delete_all()


tag1 = Tag.new({
  "category" => "cosmetics"
  })
tag1.save

tag2 = Tag.new({
  "category" => "hot_drink"
  })
tag2.save
tag2.category="takeaway_drink"
tag2.update
p tag2
p Tag.all()


tag3 = Tag.new({
  "category" => "plastic_bags"
  })
tag3.save
tag3.delete
p Tag.all()

plastic1 = Plastic.new({
  'type' => 'PET1',
  'existence' => 750,
  'weight' => 40
  })
plastic1.save()

plastic2 = Plastic.new({
  'type' => 'PET1',
  'existence' => 450,
  'weight' => 40
})
plastic2.save()
# plastic2.delete()

plastic3 = Plastic.new({
  'type' => 'PET4',
  'existence' => 250,
  'weight' => 10
})
plastic3.save()
plastic3.type = "PET5"
plastic3.update

p plastic1.existence()



product1 = Product.new({
  'name' => 'plastic cup',
  'avoidability' => true,
  'quantity' => 1,
  'plastic_id' => plastic1.id,
  'tag_id' => tag2.id
  })
product1.save

product2 = Product.new({
  'name' => 'shampoo',
  'avoidability' => false,
  'quantity' => 1,
  'plastic_id' => plastic2.id,
  'tag_id' => tag1.id
  })
product2.save

product3 = Product.new({
  'name' => 'shower gel',
  'avoidability' => true,
  'quantity' => 1,
  'plastic_id' => plastic2.id,
  'tag_id' => tag1.id
  })
product3.save()
product3.name = 'hand cream'
product3.update()
p product1.existence()


# p product1.plastic()
# p product2.tag()
# p plastic1.tags()
# p tag1.plastics()
# p Product.quantity()
# p Product.avoidable(true)
# p Plastic.weight()
