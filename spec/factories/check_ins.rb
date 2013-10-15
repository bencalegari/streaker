# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :check_in do
    task_id 1
    state "pending"
    start_time (Time.now - 1.hour)
    end_time (Time.now + 1.hour)
  end
end
