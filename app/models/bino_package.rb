class BinoPackage < ApplicationRecord
  validates :source, :destiny, presence: true
  enum status: [ :sent, :waiting, :failed ]
  enum package_type: [ :ticket, :tasks ]
end
