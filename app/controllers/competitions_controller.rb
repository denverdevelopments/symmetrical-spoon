class CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
  end

  def create
    competition = Competition.find(params[:competition_id])
    new_team = competition.teams.new(hometown: params[:hometown], nickname: params[:nickname])
    # new_team = @competition.teams.create!(hometown: params[:hometown], nickname: params[:nickname])
    # new_team = @competition.teams.create!(hometown: :hometown, nickname: :nickname) #, competition_id: @competition.id)  SUBMITTED
    # new_team.update
    new_team.save
    redirect_to "/competitions/#{competition.id}"
  end
end
