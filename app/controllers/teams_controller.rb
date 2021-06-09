class TeamsController < ApplicationController
  def index
    # @teams = Team.all
    @age_sorted_teams = Team.all.age_sorted
  end
end
