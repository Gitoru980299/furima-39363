FactoryBot.define do
  factory :purchase_shipping do
    post_code { '123-4567' }
    prefecture_id { '2' }
    city_address { '渋谷区' }
    street_address { '青山１－１－１' }
    building_name { 'ヒルズ１０１' }
    telephone_number { '08011111111' }
    #token {"tok_abcdefghijk00000000000000000"}
  end
end