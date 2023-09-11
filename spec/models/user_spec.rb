require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
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

    it 'お名前(全角)は、名字と名前が空では登録できない' do
      @user.first_name = ''
      @user.valid?
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角文字を使用してください", "Last name can't be blank", "Last name 全角文字を使用してください")
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

    it 'お名前カナ(全角)は、名字と名前が空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana 全角カナ文字を使用してください", "Last name kana can't be blank", "Last name kana 全角カナ文字を使用してください")
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

    it 'お名前カナ(全角)は、全角（カタカナ）で入力しないと登録できない' do
      @user.first_name_kana = 'ﾀﾛｳ'
      @user.valid?
      @user.last_name_kana = 'ﾔﾏﾀﾞ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カナ文字を使用してください","Last name kana 全角カナ文字を使用してください")
    end

    it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
