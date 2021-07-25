FactoryBot.define do
  factory :label do
    sequence(:name) { |n| "Label#{n}" }
  end
end

def task_with_labels(labels_count: 2)
  user_a = FactoryBot.create(:user)

  FactoryBot.create(:task, user: user_a) do |task|
    FactoryBot.create_list(:label, labels_count, tasks: [task])
  end

  FactoryBot.create(:task2, user: user_a)
  FactoryBot.create(:task3, user: user_a)
end
