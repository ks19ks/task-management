require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user2)
  end

  describe "ユーザー登録機能" do
    context "ユーザーの新規登録をした場合" do
      it "作成したユーザーが表示される" do
        visit new_user_path
        fill_in "ユーザー名",	with: "user1"
        fill_in "メールアドレス",	with: "user1@example.com"
        fill_in "パスワード",	with: "password"
        fill_in "パスワード確認",	with: "password"
        click_on '登録する'
        expect(page).to have_content 'user1'
      end
    end
    context "ログインせずにタスク一覧にアクセスした場合" do
      it "ログイン画面が表示される" do
        visit tasks_path
        expect(page).to have_content 'Please sign in'
      end
    end
  end

  describe "セッション機能" do
    before do
      visit login_path
      fill_in "Email",	with: "admin@example.com"
      fill_in "Password",	with: "password"
      click_button 'Login'
    end
    context "ログインをした場合" do
      it "タスク一覧のページが表示される" do
        expect(page).to have_content 'TODO一覧'
      end
    end
    context "マイページへアクセスした場合" do
      it "ユーザーの情報が表示される" do
        user = User.find_by(name: 'admin')
        visit user_path(user)
        expect(page).to have_content 'admin'
      end
    end
    context "他のユーザーの詳細画面にアクセスした場合" do
      it "タスク一覧画面が表示される" do
        another = User.find_by(name: 'general')
        visit user_path(another)
        expect(page).to have_content 'TODO一覧'
      end
    end
    context "ログアウトした場合" do
      it "ログアウト後にログイン画面が表示される" do
        click_on 'Logout'
        expect(page).to have_content 'Please sign in'
      end
    end
  end

  describe "管理画面機能" do
    context "管理ユーザーでログインした場合" do
      before do
        visit login_path
        fill_in "Email",	with: "admin@example.com"
        fill_in "Password",	with: "password"
        click_button 'Login'
        visit admin_users_path
      end
      it "管理画面にアクセスできる" do
        expect(page).to have_content 'ユーザー一覧'
      end
      it "ユーザーの新規登録ができる" do
        click_on '新規登録'
        fill_in "ユーザー名",	with: "user1"
        fill_in "メールアドレス",	with: "user1@example.com"
        fill_in "パスワード",	with: "password"
        fill_in "パスワード確認",	with: "password"
        click_on '登録する'
        expect(page).to have_content 'user1'
      end
      it "ユーザーの詳細画面にアクセスできる" do
        another = User.find_by(name: 'general')
        visit admin_user_path(another)
        expect(page).to have_content 'general'
      end
      it "ユーザーの編集ができる" do
        another = User.find_by(name: 'general')
        visit edit_admin_user_path(another)
        fill_in "ユーザー名",	with: "general_edit"
        click_on '更新する'
        expect(page).to have_content 'general_edit'
      end
      it "ユーザーを削除できる" do
        page.accept_confirm do
          first('tbody tr').click_on '削除'
        end
        expect(page).to have_content '削除しました'
      end
    end
    context "一般ユーザーでログインした場合" do
      before do
        visit login_path
        fill_in "Email",	with: "general@example.com"
        fill_in "Password",	with: "password"
        click_button 'Login'
        visit admin_users_path
      end
      it "管理画面にアクセスできない" do
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
  end
end
