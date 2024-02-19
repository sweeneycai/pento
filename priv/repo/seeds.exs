# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Catalog
alias Pento.Catalog.Product
alias Pento.Accounts.User
alias Pento.Accounts
alias Pento.Survey
alias Pento.Repo

import Ecto.Query

products = [
  %{
    name: "Chess",
    description: "The classic strategy game.",
    sku: 5_678_910,
    unit_price: 10.00
  },
  %{
    name: "Tick-tac-toe",
    description: "The game of Xs and 0s",
    sku: 11_121_314,
    unit_price: 3.00
  },
  %{
    name: "Table tennis",
    description: "Bat the ball back and forth. Don't miss!",
    sku: 15_222_324,
    unit_price: 20.00
  },
  %{
    name: "Euro Truck",
    description: "像公路之王一样在欧洲穿行，将价值不菲的货物送向远方！",
    sku: 15_222_325,
    unit_price: 21.12
  },
  %{
    name: "Kingdom Rush Vengeance",
    description: "复仇的时刻已经来临！率领黑暗大军步步紧逼，让整个王国为你而颤抖吧！你将直面凶猛残暴的强敌，与至高至强的 boss 们展开终极决战。将防御塔与武器自由搭配，实现最具杀伤力的组合。训练传奇英雄，引领他们走向胜利！",
    sku: 15_222_326,
    unit_price: 18.50
  },
  %{
    name: "Kingdom Rush Origins",
    description: "率领精灵军队，在全新防御塔、英雄和法术的帮助下，击退海蛇、邪恶术士和豺狼族人一波又一波的进攻，与坏人们血战到底，保卫神秘大陆的安全。",
    sku: 15_222_327,
    unit_price: 14.50
  }
]

# create test products
Enum.each(products, fn product -> Catalog.create_product(product) end)

# create test users
for id <- 1..40 do
  Accounts.register_user(%{
    email: "user-#{id}@example.com",
    password: "user-#{id}@example.com"
  })
end

user_ids = (from u in User, select: u.id) |> Repo.all()
product_ids = (from p in Product, select: p.id) |> Repo.all()
gender_choice = ["male", "female", "others", "prefer not to say"]
age_choice = 1965..2024
stars_choice = 1..5

# create demographics
for user_id <- user_ids do
  Survey.create_demographic(%{
    user_id: user_id,
    year_of_birth: Enum.random(age_choice),
    gender: Enum.random(gender_choice)
  })
end

# create ratings
for user_id <- user_ids, product_id <- product_ids do
  Survey.create_rating(%{
    user_id: user_id,
    product_id: product_id,
    stars: Enum.random(stars_choice)
  })
end