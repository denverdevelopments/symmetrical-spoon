class Team < ApplicationRecord
  validates :nickname, presence: true
  validates :hometown, presence: true

  belongs_to :competition

  has_many :team_players
  has_many :players, through: :team_players

  def self.age_sorted
    # self.joins(:players).select('teams.*, average(players.age) as average_team_age').group('teams.id').order('average_team_age desc')
    self.joins(:players).select('teams.*, sum(players.age)/count(players.id) as average_team_age').group('teams.id').order('average_team_age desc')
  end
end
