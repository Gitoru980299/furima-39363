FactoryBot.define do
  factory :item do
    item_name              {'プログラミング上達の秘訣扇風機'}
    explanation            {'プログラミングが上達する扇風機です'}
    price                  {'10000'}
    category_id               {2}
    status_id                 {2}
    delivery_charge_id        {2}
    prefecture_id             {2}
    days_to_ship_id           {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
