FactoryBot.define do
  factory :task do
    title { 'test_title' }
    description { 'test_description' }
  end
  factory :task2, class: Task do
    title { 'test_title2' }
    description { 'test_description2' }
  end
end
