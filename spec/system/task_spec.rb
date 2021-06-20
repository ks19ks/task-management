require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:task2)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル",	with: "new task"
        fill_in "説明",	with: "task content"
        click_on '登録する'
        expect(page).to have_content 'new task'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, title: 'new task') }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        new_task = all('tbody tr')[0]
        expect(new_task).to have_content 'new task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, title: 'task_a')
        visit tasks_path
        first('tbody tr').click_link '詳細'
        expect(page).to have_content 'task_a'
       end
     end
  end
end
