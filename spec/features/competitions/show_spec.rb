require 'rails_helper'

RSpec.describe 'the competition show' do
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

    visit "/competitions/#{@competition_1.id}"
  end

  it 'lists all the competition attributes, name, location, sport' do
    expect(page).to have_content(@competition_1.name)
    expect(page).to have_content(@competition_1.location)
    expect(page).to have_content(@competition_1.sport)
    expect(page).to_not have_content(@competition_2.name)
  end

  it 'lists all the competition teams nicknames, hometowns' do
    expect(page).to have_content(@competition_1.name)
    expect(page).to have_content(@team_1.hometown)
    expect(page).to have_content(@team_1.nickname)
    expect(page).to have_content(@team_2.hometown)
    expect(page).to have_content(@team_2.nickname)
    expect(page).to_not have_content(@team_3.hometown)
    expect(page).to_not have_content(@team_3.nickname)
  end

  it 'lists all the competition teams players average ages' do
    expect(page).to have_content("Competition Players Average Age:")
    expect(page).to have_content(29)
  end

  it 'has a link to register a new team' do
    expect(page).to have_link("Register New Team")
    click_link("Register New Team")
    expect(current_path).to eq("/competitions/#{@competition_1.id}/new_team")
  end
end
