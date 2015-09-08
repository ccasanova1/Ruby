class Team
	attr_accessor :name_team, :players_team 
  def initialize
    @name_team
    @players_team = []
  end

  def to_s
    "#{name_team}"
  end
end
