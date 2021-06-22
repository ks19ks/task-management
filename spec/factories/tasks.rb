FactoryBot.define do
  factory :task do
    title { 'test_title' }
    description { 'test_description' }
    due_date { '2021-06-01' }
  end
  factory :task2, class: Task do
    title { 'test_title2' }
    description { 'test_description2' }
    due_date { '2021-07-01' }
  end
end
