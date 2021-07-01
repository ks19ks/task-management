require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:task2)
    FactoryBot.create(:task3)
  end

  describe "検索機能" do
    before do
      visit tasks_path
    end
    context "タイトルであいまい検索した場合" do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in "タイトル",	with: "タイトル"
        click_on '検索'
        expect(page).to have_content 'タイトルテスト'
      end
    end
    context "ステータス検索した場合" do
      it 'ステータスに完全一致するタスクに絞り込まれる' do
        select '完了', from: 'ステータス'
        click_on '検索'
        expect(page).to have_content 'タイトルテスト'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "タイトル",	with: "タイトル"
        select '完了', from: 'ステータス'
        click_on '検索'
        expect(page).to have_content 'タイトルテスト'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル",	with: "new task"
        fill_in "説明",	with: "task content"
        select '完了', from: 'ステータス'
        click_on '登録する'
        expect(page).to have_content '完了'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, title: 'new task', due_date: '2021-05-01') }
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
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        visit new_task_path
        fill_in "タイトル",	with: "新しいタスク"
        fill_in "説明",	with: "終了期限の確認"
        fill_in "終了期限",	with: "002020-04-01"
        click_on '登録する'
        visit tasks_path
        click_on '終了期限'
        task = all('tbody tr').last
        expect(task).to have_content '新しいタスク'
      end
    end
    context '優先度でソートするボタンを押した場合' do
      it '優先度の高い順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '優先度'
        expect(all('tbody tr').last).to have_content 'タイトルテスト'
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
