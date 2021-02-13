FactoryBot.define do
    factory :book_comment do
      comment { Faker::Lorem.characters(number:10) }

      #アソシエーションモデル
      association :user
      # userと書くだけでも事足りる
      association :book
      # bookと書くだけでも事足りる
    end
  end