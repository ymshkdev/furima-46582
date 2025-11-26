require 'rails_helper'

RSpec.describe '商品購入機能', type: :system do
  before do
    # ユーザー作成
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)

    # 販売中の商品作成
    @item = FactoryBot.create(:item, user: @other_user)
  end

  context 'ログイン状態' do
    before do
      # ログイン
      sign_in @user
    end

    it '他人の販売中の商品を購入できること' do
      visit item_orders_path(@item)

      # 商品情報の表示確認
      expect(page).to have_content(@item.title)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.shipping_fee_status)
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")

      # フォーム入力
      fill_in '郵便番号', with: '123-4567'
      select '東京都', from: '都道府県'
      fill_in '市区町村', with: '新宿区'
      fill_in '番地', with: '1-1-1'
      fill_in '建物名', with: 'テストビル'
      fill_in '電話番号', with: '09012345678'
      fill_in 'カード番号', with: '4242424242424242'
      fill_in '有効期限', with: '12/30'
      fill_in 'セキュリティコード', with: '123'

      click_button '購入'

      # トップページに遷移しているか
      expect(current_path).to eq(root_path)

      # データベース反映確認
      expect(Order.last.item_id).to eq(@item.id)
      expect(Address.last.city).to eq('新宿区')
    end

    it '自身が出品した商品の購入ページにアクセスするとトップページにリダイレクト' do
      own_item = FactoryBot.create(:item, user: @user)
      visit item_orders_path(own_item)
      expect(current_path).to eq(root_path)
    end

    it '売却済み商品の購入ページにアクセスするとトップページにリダイレクト' do
      sold_item = FactoryBot.create(:item, user: @other_user)
      FactoryBot.create(:order, item: sold_item, user: @user)
      visit item_orders_path(sold_item)
      expect(current_path).to eq(root_path)
    end
  end

  context 'ログアウト状態' do
    it '購入ページにアクセスするとログインページにリダイレクト' do
      visit item_orders_path(@item)
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'エラーハンドリング' do
    before do
      sign_in @user
      visit item_orders_path(@item)
    end

    it '必須項目未入力で購入できず、エラーが表示されること' do
      click_button '購入'

      expect(page).to have_content("Postal code can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("Phone number can't be blank")
      expect(page).to have_content("Token can't be blank")
    end
  end
end
