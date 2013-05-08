class Reservation < ActiveRecord::Base
  attr_accessible :jour, :creneau_id, :aviron_id, :confirmation
  belongs_to :creneau
  belongs_to :aviron

  validates :jour, presence: true
  validates :creneau, presence: true
  validates :aviron, presence: true

  default_scope order: 'reservations.jour ASC'
end
