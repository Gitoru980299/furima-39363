require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameが存在すれば登録できる' do
        expect(@user).to be_valid
      end
  
      it 'emailが存在すれば登録できる' do
        expect(@user).to be_valid
      end
  
      it 'passwordが存在すれば登録できる' do
        expect(@user).to be_valid
      end
  
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
  
      it '重複していないemailであれば登録できる' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        expect(@user).to be_valid
      end
  
      it 'emailが@を含んでいれば登録できる' do
        @user.email = 'rest@test'
        expect(@user).to be_valid
      end
  
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd1234'
        expect(@user).to be_valid
      end
  
      it 'passwordは英数字混合であれば登録できる' do
        @user.password = 'abcd1234'
        expect(@user).to be_valid
      end
  
      it 'passwordとpassword_confirmationが一致していれば登録できる' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd1234'
        expect(@user).to be_valid
      end
  
      it 'お名前(全角)は、名字が存在すれば登録できる' do
        @user.last_name = '松本'
        expect(@user).to be_valid
      end
  
      it 'お名前(全角)は、名前が存在すれば登録できる' do
        @user.first_name = '徹'
        expect(@user).to be_valid
      end
  
      it 'お名前(全角)は、名字を全角（漢字・ひらがな・カタカナ）で入力していれば登録できる' do
        @user.last_name = '矢まダ'
        expect(@user).to be_valid
      end
  
      it 'お名前カナ(全角)は、名字が存在すれば登録できる' do
        @user.last_name_kana = 'トオル'
        expect(@user).to be_valid
      end
  
      it 'お名前カナ(全角)は、名前が存在すれば登録できる' do
        @user.first_name_kana = 'マツモト'
        expect(@user).to be_valid
      end
  
      it 'お名前カナ(全角)は、名字を全角（カタカナ）で入力していれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
  
      it 'お名前カナ(全角)は、名前を全角（カタカナ）で入力していれば登録できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
  
      it '生年月日が入力していれば登録できる' do
        @user.birthday = '1974-05-02'
        expect(@user).to be_valid
      end
  
      it 'passwordで半角英字と半角数字が両方入力していれば登録できる' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd1234'
        expect(@user).to be_valid
      end
  
      it '全角文字を含まないパスワードでは登録できる' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd1234'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
  
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
  
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
  
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
  
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
  
      it 'passwordは英数字混合でないと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'お名前(全角)は、名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
  
      it 'お名前(全角)は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
  
      it 'お名前(全角)は、名字を全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
  
      it 'お名前カナ(全角)は、名字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
  
      it 'お名前カナ(全角)は、名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
  
      it 'お名前カナ(全角)は、名字を全角（カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カナ文字を使用してください")
      end
  
      it 'お名前カナ(全角)は、名前を全角（カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カナ文字を使用してください")
      end
  
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
  
      it 'passwordで半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include( )
      end
  
      it 'passwordで半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include( )
      end
  
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａａa １１1'
        @user.password_confirmation = 'ａａa １１1'
        @user.valid?
        expect(@user.errors.full_messages).to include( )
      end
    end    
  end
end
