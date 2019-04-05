class Package < ApplicationRecord
  enum status: [ :send, :waiting, :failed ]
  enum type: [ :ticket, :card ]
end
