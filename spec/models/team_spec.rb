require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'relationships' do
    it { should belong_to(:competition) }
    it { should have_many(:team_players) }
    it { should have_many(:players).through(:team_players) }

  end

  describe 'validations' do
    it { should validate_presence_of(:nickname) }
    it { should validate_presence_of(:hometown) }
  end

  before(:each) do
    @competition_1 = Competition.create!(name: 'Mens Regional', location: 'Louisville', sport: 'basketball')
    @competition_2 = Competition.create!(name: 'Northeast Invitational', location: 'New York', sport: 'pickleball')
    @team_1 = @competition_1.teams.create!(hometown: 'Leesburg', nickname: 'Rockets')
    @team_2 = @competition_1.teams.create!(hometown: 'Houston', nickname: 'Jaguars')
    @team_3 = @competition_1.teams.create!(hometown: 'Denver', nickname: 'Nuggets') ##changed
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
  end

  describe 'class methods' do
    describe '#age_sorted' do
      it 'returns highest avg age teams first' do
        expect(Team.age_sorted).to eq([@team_2, @team_1, @team_3])
      end
    end
  end 
end
