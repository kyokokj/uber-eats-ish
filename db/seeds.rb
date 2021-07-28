3.times do |n|
  restaurant = Restaurant.new(
    name: "test_restaurant#{n}",
    fee: 100,
    time_required: 10,
  )

  12.times do |m|
    restaurant.foods.build(
      name: "food_#{m}",
      price: 500,
      description: "This is discription of #{m}."
    )
  end

  restaurant.save!
end
