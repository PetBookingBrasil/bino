class Task < ApplicationRecord
  belongs_to :source, class_name: 'Agent'
  belongs_to :destiny, class_name: 'Agent', optional: true
  enum status: [ :imported, :exported ]
end
