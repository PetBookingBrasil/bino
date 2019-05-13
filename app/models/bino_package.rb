class BinoPackage < ApplicationRecord
  validates :source, :destiny, presence: true
  validates :external_source_id, uniqueness: {scope: [:source, :destiny, :package_type]}, case_sensitive: false
  enum status: [ :sent, :waiting, :failed ]
  enum package_type: [ :ticket, :tasks ]
end
