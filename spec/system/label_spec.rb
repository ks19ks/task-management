require 'rails_helper'

RSpec.describe 'タスクラベル機能', type: :system do
  before do
    task_with_labels
  end
  describe "ラベル機能" do
    before do
      visit login_path
      fill_in "Email", with: "admin@example.com"
      fill_in "Password", with: "password"
      click_button 'Login'
    end
    context "タスク作成時にラベルを付与した場合" do
      it "作成したタスクがラベルとともに表示される" do
        visit new_task_path
        fill_in "タイトル",	with: "new task"
        fill_in "説明",	with: "task content"
        check 'Label1'
        click_on '登録する'
        expect(page).to have_content 'Label1'
      end
    end
    context "一覧表示画面でラベルで検索した場合" do
      it "該当するラベルをもつタスクが表示される" do
        select 'Label4', from: 'ラベル'
        click_on '検索'
        expect(page).to have_content 'test_title'
      end
    end
  end
end
