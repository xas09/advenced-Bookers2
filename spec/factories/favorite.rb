FactoryBot.define do
    factory :favorite do
      #アソシエーションモデル
      association :user
      # userと書くだけでも事足りる
      association :book
      # bookと書くだけでも事足りる
    end
  end