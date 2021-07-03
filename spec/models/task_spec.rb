require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '', description: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'タスクタイトル', description: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'タスクタイトル', description: 'タスク説明')
        expect(task).to be_valid
      end
    end
  end

  describe "検索機能" do
    let!(:task) { FactoryBot.create(:task, title: 'this is task', status: '完了') }
    let!(:task2) { FactoryBot.create(:task2, title: 'sample', status: '未着手') }
    context 'タイトルでタスクの検索をした場合' do
      it '検索キーワードを含むタスクに絞り込まれる' do
        expect(Task.search_by_title('task')).to include(task)
        expect(Task.search_by_title('task')).not_to include(task2)
        expect(Task.search_by_title('task').count).to eq 1
      end
    end
    context 'ステータスでタスクの検索をした場合' do
      it 'ステータスに完全一致するタスクに絞り込まれる' do
        expect(Task.search_by_status('完了')).to include(task)
        expect(Task.search_by_status('完了')).not_to include(task2)
        expect(Task.search_by_status('完了').count).to eq 1
      end
    end
    context 'タイトルとステータスでタスクの検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクに絞り込まれる' do
        expect(Task.search_by_title('task').search_by_status('完了')).to include(task)
        expect(Task.search_by_title('task').search_by_status('完了')).not_to include(task2)
        expect(Task.search_by_title('task').search_by_status('完了').count).to eq 1
      end
    end
  end
end
