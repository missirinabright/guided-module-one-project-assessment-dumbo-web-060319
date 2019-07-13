Adult.destroy_all
Child.destroy_all
Farmchore.destroy_all

mom = Adult.create(name: "🧚‍♀️ Mom")
dad = Adult.create(name: "👨‍🌾 Dad")
grandma = Adult.create(name: "👵 Babushka")
grandpa = Adult.create(name: "🎅 Ded")
aunt = Adult.create(name: "🧟‍♀️ Aunt Lydia")

francis = Child.create(name: "😎 Francis")
sean = Child.create(name: "😎 Sean")
abdul = Child.create(name: "😎 Abdul")
richard = Child.create(name: "😎 Richard")
samip = Child.create(name: "😎 Samip")
justin = Child.create(name: "😎 Justin")


chickens_food = Farmchore.create(description: "🐓 feed the chickens with leftover veggies 🐓 🥬 🌽 🍆 🐓", adult_id: mom.id, child_id: francis.id)
cows_am = Farmchore.create(description: "🐄 drop off the cows for the picnic trip 🐄 🧺 🐄", adult_id: dad.id, child_id: abdul.id)
cows_pm = Farmchore.create(description: "🐮 pick up the cows from the cowcare 🐮 🍼 🐮", adult_id: grandma.id, child_id: richard.id)
cows_milk = Farmchore.create(description: "🥛 milk the cows 🥛🥛", adult_id: grandma.id, child_id: samip.id)
cows_clean = Farmchore.create(description: "💩 clean the barn 💩", adult_id: aunt.id, child_id: sean.id)
geese_feed = Farmchore.create(description: "feed the geese", adult_id: aunt.id, child_id: sean.id)
