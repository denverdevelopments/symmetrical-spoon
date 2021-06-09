require 'rails_helper'

RSpec.describe 'the teams index' do
  before(:each)do
  @competition_1 = Competition.create!(name: 'Mens Regional', location: 'Louisville', sport: 'basketball')
  @competition_2 = Competition.create!(name: 'Northeast Invitational', location: 'New York', sport: 'pickleball')
  @team_1 = @competition_1.teams.create!(hometown: 'Leesburg', nickname: 'Rockets')
  @team_2 = @competition_1.teams.create!(hometown: 'Houston', nickname: 'Jaguars')
  @team_3 = @competition_2.teams.create!(hometown: 'Denver', nickname: 'Nuggets')
  @player_1 = Player.create!(name: 'Billy Bigshoes', age: 12)
  @player_2 = Player.create!(name: 'Steph Curry', age: 24)
  @player_3 = Player.create!(name: 'Joe Schmoe', age: 30)
  @player_4 = Player.create!(name: 'Pat Smith', age: 38)
  @player_5 = Player.create!(name: 'Jamie Jones', age: 41)

  @player_6 = Player.create!(name: 'Jill Smith', age: 20)

  TeamPlayer.create!(team: @team_1, player: @player_1)
  TeamPlayer.create!(team: @team_1, player: @player_2)
  TeamPlayer.create!(team: @team_1, player: @player_3)
  TeamPlayer.create!(team: @team_2, player: @player_4)
  TeamPlayer.create!(team: @team_2, player: @player_5)
  TeamPlayer.create!(team: @team_3, player: @player_6)

    visit "/teams"
  end

  # As a user
  # When I visit the team index
  # Then I see the nicknames of all teams
  # And next to the team nickname I see the average age of its players
  # And I see that all teams are sorted by this average age from highest to lowest
  #
  # (Note: you should not make a separate query for each team to calculate the average age)

  it 'lists all the team nicknames and avg player ages' do
    expect(page).to have_content(@team_1.nickname)
    expect(page).to have_content(@team_1.average_team_age)
    expect(page).to have_content(@team_2.nickname)
    expect(page).to have_content(@team_2.average_team_age)
    expect(page).to have_content(@team_3.nickname)
    expect(page).to have_content(@team_3.average_team_age)

  end

  it 'displays a link to each competition' do
    expect(page).to have_content(@competition_1.name)
    expect(page).to have_link(@competition_1.name)

    click_link(@competition_1.name)

    expect(page).to have_current_path("/competitions/#{@competition_1.id}")
    expect(page).to_not have_current_path("/competitions")
  end
end
