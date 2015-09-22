
require_relative 'utils/form'
require_relative 'player'
require_relative 'team'
require_relative 'prueba'

class Program
  attr_accessor :championship_name, :much_players
  def initialize
    @players = []
    @teams = []
    confirmar = true
    @matchplayer = 0
    continuar = 0
    continuar1 = 0
    while continuar < 1
      continuar = 0
      continuar1 = 0
      inst_form = Form.new('Ingrese la informacion solicitada:', championship_name: 'Nombre de Campeonato')
      inst_form.ask_for(:championship_name)
      @championship_name = inst_form.get_data[0]
      if @championship_name.length == 0
        p "|ERROR| NAME EMPTY"
      else
        inst_form = Form.new('Ingrese la informacion solicitada:',much_player: 'Cantidad de jugadores (5,7 o 11)')
        inst_form.ask_for(:much_player)
        @option = inst_form.get_data[0]
        case @option.to_i
        when 1
          @matchplayer = 5
        when 2   
          @matchplayer = 7
        when 3
          @matchplayer = 11
        else
          p "Opcion incorrecta"
          continuar1 = 1
        end
        continuar = 1 - continuar1
      end
    end
  end
  def cls
    system('cls')
  end
    
  def add_player
    cls
  	inst_player = Player.new
    p "##############__INGRESAR JUGADOR__##################"
  	inst_form = Form.new('Ingrese a informacion solicitada:', player_name: 'Nombre de jugador', ci: 'cedula' )
		inst_form.ask_for(:player_name, :ci)
    inst_player.name_player = inst_form.get_data[0]
    inst_player.ci = inst_form.get_data[1]
    inst_player.flag = 0
    if inst_form.get_data[1].length != 8 
      p "La cedula debe tener 8 caracteres"
    elsif inst_player.name_player.length == 0
      p "|ERROR| NAME EMPTY"
    elsif @players.find { |inst| inst.ci == i1.ci }
      p "Ya existe un jugador con esa cedula"
    else
      @players << inst_player
      p "!SAVED!"
    end
  end

	def add_team
      cls
		  inst_team = Team.new
      p "##############__INGRESAR EQUIPO__##################"
  	  inst_form = Form.new('Ingrese a informacion solicitada:', name_team: 'Nombre de equipo')
		  inst_form.ask_for(:name_team)
      inst_team.name_team = inst_form.get_data[0]
    if inst_team.name_team.length == 0 
      p "|ERROR| NAME EMPTY"
    elsif @teams.find { |inst| inst.name_team == inst.name_team }
			p "El nombre de ese equipo ya existe."
    else 
      p "|SAVED|"
      @teams << inst_team
		end
  end

	def add_player_to_team
      cls
		  p "##############__IGRESAR UN JUGADOR A EQUIPO__##################"
		  inst_form = Form.new
    if @teams.empty? 
      p "|ERROR| No hay equipos disponibles."
    else 
		  player =	inst_form.select_from_list("Ingrese el numero de jugador de la lista.", @players)
    if player.flag == 1
        p "|ERROR| #{player.name_player} ya se encuentra en un equipo."
    else
        team = inst_form.select_from_list("Ingrese el numero del equipo a ingresar.", @teams)
        team.players_team << player
        player.flag = 1
      end
    end
  end

  def championship_can_be_played
      cls
    # sizes = @teams.each { |team| p team.players_team.size }
    #p sizes
    if @teams.empty?
      p "No hay equipos para disputar el campeonato"
    elsif @teams.size.even? == false
      p "la cantidad de equipos disponibles no es par."
    #  elsif @teams.each { |team|  team.players_team.size >= @much_players }
      #  p "Hay equipos que tienen menos de la cantidad de los jugadores requeridos"
    end 
  end

  def championship_name
    "#{@championship_name} Championship."
  end
              			
	def display_players
    cls
    p "##############__JUGADORES__##################"
		@players.each { |playerss|  p "#{playerss.name_player} ; #{playerss.ci}" }
	end

	def display_teams
    cls
    p "##############__EQUIPOS__####################"
		@teams.each { |teamss| p "#{teamss.name_team} ; Total de jugadores: #{teamss.players_team.size}" }
	end

  def display_team_players
    cls
    p "##############__VER JUGADORES DE EQUIPO__####################"
    f1 = Form.new
    team = f1.select_from_list("¿De que equipo desea ver los jugadores?", @teams)
    team.players_team.each { |player| p "NOMBRE: #{player.name_player} CEDULA: #{player.ci}"}
  end
end