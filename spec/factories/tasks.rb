FactoryBot.define do
  factory :task do
    title { 'test_title' }
    description { 'test_description' }
    due_date { '2021-06-01' }
    status { '着手中' }
  end
  factory :task2, class: Task do
    title { 'test_title2' }
    description { 'test_description2' }
    due_date { '2021-07-01' }
    status { '未着手' }
  end
  factory :task3, class: Task do
    title { 'タイトルテストです' }
    description { '説明テストです' }
    due_date { '2021-08-01' }
    status { '完了' }
  end
end
