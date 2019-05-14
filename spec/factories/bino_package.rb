FactoryBot.define do
  factory :bino_package do
    source { "Zendesk" }
    destiny  { "Runrunit" }
    external_source_id { rand(1000) }
    external_destiny_id { rand(1000) }
    status { :sent }
    package_type { 'tasks' }
  end
end
