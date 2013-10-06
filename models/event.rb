class Event
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :timestamp, :type => DateTime
  field :name, :type => String
  field :msg, :type => String
  field :seq_nr, :type => Integer
  field :user, :type => String
  field :session, :type => String
  field :extra, :type => Hash
  belongs_to :application
  before_create :check_or_add_timestamp

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
  def check_or_add_timestamp
    self.timestamp = Time.now if self.timestamp.nil?
  end
end
