class Nomination < ActiveRecord::Base
  attr_accessible :nominee

  state_machine :initial => :nominated do
    event :elect do
      transition :nominated => :elected
    end

    event :defeat do
      transition :nominated => :defeated
    end
  end

  scope :elected, lambda{with_state(:elected)}
  scope :defeated, lambda{with_state(:defeated)}

  belongs_to :nominee, :class_name => 'Member'

  delegate :name, :to => :nominee
end
