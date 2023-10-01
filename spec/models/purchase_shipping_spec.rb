require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    sleep 1
    item = FactoryBot.create(:item)    
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
  end

  describe '購入情報と配送先情報の保存' do
    ### 正常系テスト
    context '購入できるとき' do
      it 'ユーザー, 商品, 郵便番号, 都道府県, 市区町村, 番地, ビル・建物名, 電話番号が正しく存在すれば登録できる' do
        expect(@purchase_shipping).to be_valid
      end

      it 'ビル・建物名が空欄でもその他が正しく存在すれば登録できる' do
        @purchase_shipping.building_name = ''
        expect(@purchase_shipping).to be_valid
      end
    end

    context '購入できないとき' do
      ### 異常系テスト
      ## ユーザー
      it 'ユーザーが紐付いていなければ登録できない' do
        @purchase_shipping.user_id = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
      end

      ## 商品
      it '商品が紐付いていなければ登録できない' do
        @purchase_shipping.item_id = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
      end

      ## 郵便番号
      it '郵便番号が空欄では登録できない' do
        @purchase_shipping.post_code = ''
        @purchase_shipping.valid?      
        expect(@purchase_shipping.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号にハイフンがないと登録できない' do
        @purchase_shipping.post_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      
      ## 都道府県
      it '都道府県が1では登録できない' do
        @purchase_shipping.prefecture_id = '1'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end   

      ## 市区町村
      it '市区町村が空欄では登録できない' do
        @purchase_shipping.city_address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("City address can't be blank")
      end      

      ## 番地
      it '番地が空欄では登録できない' do
        @purchase_shipping.street_address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Street address can't be blank")
      end      

      ## 電話番号
      it '電話番号が空欄では登録できない' do
        @purchase_shipping.telephone_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '電話番号が10桁未満では登録できない' do
        @purchase_shipping.telephone_number = '123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number must be 10 digits or 11 digits number")
      end

      it '電話番号が11桁を超えたら登録できない' do
        @purchase_shipping.telephone_number = '123456789012'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number must be 10 digits or 11 digits number")
      end

      it '電話番号が数字以外だと登録できない（英字）' do
        @purchase_shipping.telephone_number = 'aaaaaaaaaa'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number must be 10 digits or 11 digits number")
      end

      it '電話番号に数字以外が入っていると登録できない' do
        @purchase_shipping.telephone_number = '090-123-456'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Telephone number must be 10 digits or 11 digits number")
      end

      ## token
      it 'tokenがなければ登録できない' do
        @purchase_shipping.token = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end