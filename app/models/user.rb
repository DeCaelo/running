class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attachment :photo

  has_many :events, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :run_level, presence: true

  RUNNING_TYPE = ["Running rapide", "Running fractionné", "Running endurance", "Running blabla", "Marche rapide", "Marche plaisante"]

  RUNNER_LEVEL = ["Débutant", "Intermédiaire", "Confirmé"]

  def full_name
    "#{first_name} #{last_name}"
  end

  def events_as_participant
    participations.map(&:event)
  end

  def events_only_as_participant
    events_as_participant.select {|event| event.user != self}
  end

  def my_run_buddies
    events_as_participant.map{|event| event.users.where.not(id: self.id)}.flatten.uniq
  end

  def adversaires_buddies
    events_as_participant.map{|event| event.users.where.not(id: self.id)}.flatten.uniq

  end

  def private_events
    private_events = self.events_as_participant.select {|event| event.private && event.user_id != self.id}
  end

  def refused_events
    events = []
    self.participations.each do |participation|
      if participation.status == "can t go"
        events << participation.event
      end
    end
    events
  end

end
