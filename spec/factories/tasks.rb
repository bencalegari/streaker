FactoryGirl.define do
  factory :task do
    name "Remember keys."
    description "Just remember them."
    start_time Time.now - 1.hour
    end_time Time.now + 1.hour
    last_checkin_creation Time.now - 1.day
    user

    after(:create) do |task|
      task.day_list.add(Time.now.strftime("%A"))
      task.save
    end

  end
end
