require_relative "Poki"
require_relative "TypeRelation"
class MonsController < ApplicationController
  include HTTParty
  include TypeRelation
  base_uri 'https://pokeapi.co/api/v2/'
  before_action :set_mon, only: [:show, :edit, :update, :destroy]

  # GET /mons
  # GET /mons.json
  def index
    # Logger, which will be used to display combat log in frontend
    @logList = []
    @mons = Mon.all
    @monsList = []

    # Generate 8 pokimons
    8.times do
      @monsList << getMons(rand(1...151)) 
    end

    puts TypeRelation::Counters["sss"]
    puts "it's in" if TypeRelation::Counters["rock"].include? "water"

    @fst = 0
    @second = 1

    # Loop through 7 combats to get final winner
    7.times do
      contest(@fst, @second)
      @fst = nextAlive(@second)
      @second = nextAlive(@fst)
    end

    @winner = nextAlive(0)
    @logList << "winner is #{@winner}"
  end

  def getMons(num)
    content = JSON.parse(self.class.get("/pokemon/#{num}").body)
    Poki.new(content["name"], 
      content["stats"][0]["base_stat"], 
      content["stats"][1]["base_stat"],  
      content["stats"][2]["base_stat"], 
      content["stats"][3]["base_stat"],  
      content["stats"][4]["base_stat"], 
      content["stats"][5]["base_stat"], 
      content["types"][0]["type"]["name"],
      content["sprites"]["other"]["official-artwork"]["front_default"]
    )
  end

  <<-DOC
  Find the next pokimon that is not defeated starting from index `start`
  If from `start` to the end of @monList there is no pokimon alive, 
  it wraps around to the start.
  DOC
  def nextAlive(start)
    i = start + 1
    i = i % 8
    7.times do
      return i if @monsList[i].isAlive == true
        i += 1
        i = i % 8
    end
  end

  <<-DOC 
  Simulates a combat. Each combat consists of multiple move 
  where each party deal damage to the opponent. The combat
  starts with the Pokimon with higher speed attact first and 
  ends with one party's health reaches 0 after a move. The winner will 
  restore to full health to prepare for next battle.

  @param first index of the first pokimon
  @param second index of the second pokimon
  DOC
  def contest(first, second)
    @logList << "-------------------------------------------"
    @logList << @monsList[first].name + " fights against " + @monsList[second].name

    faster = @monsList[first].speed > @monsList[second].speed ? first: second
    slower = @monsList[first].speed > @monsList[second].speed ? second: first
    @logList << @monsList[faster].name + " goes before " + @monsList[slower].name

    while @monsList[faster].isAlive and @monsList[slower].isAlive
      @logList << "#{@monsList[first].name}-> #{@monsList[first].currentHp} -----  
        #{@monsList[second].currentHp} <-#{@monsList[second].name}"  
      makeMove(faster, slower)
        temp = faster
        faster = slower
        slower = temp
    end
    @logList << "-------------------------------------------"
    #restore health
    @monsList[faster].currentHp = @monsList[faster].hp
    @monsList[slower].currentHp = @monsList[slower].hp
  end

  <<-DOC 
  Simulates a move. Each move consists of an attacker deal damage 
  to a defender. The damage is calculated based on the attacter's 
  attact and defenders defence. After each move, it will check if
  the defender is dead. Then it will update the status of two party 
  accordingly.

  @param attacker attacker's index 
  @param defender defender's index
  DOC
  def makeMove(attacker, defender)
    # assign multiplier based type counter relation
    multiplier = 1.5
    if TypeRelation::Counters[@monsList[defender].type].include? @monsList[attacker].type
      multiplier = 2
      @logList << @monsList[defender].name + " appears vulnerable in front of #{@monsList[attacker].name}"
    end

    dmg = (@monsList[attacker].attact * multiplier - @monsList[defender].defence) / 2 
    if dmg <= 0
      dmg = 1;
    end
    @monsList[defender].currentHp -= dmg
    @logList << @monsList[attacker].name + " dealt #{dmg} damage to #{@monsList[defender].name}"

    if @monsList[defender].currentHp < 0
      @monsList[defender].isAlive = false 
      @logList << @monsList[defender].name + " is defeated"
      @logList << @monsList[attacker].name + " wins"
    end
  end



  # GET /mons/1
  # GET /mons/1.json
  def show
  end

  # GET /mons/new
  def new
    @mon = Mon.new
  end

  # GET /mons/1/edit
  def edit
  end

  # POST /mons
  # POST /mons.json
  def create
    @mon = Mon.new(mon_params)

    respond_to do |format|
      if @mon.save
        format.html { redirect_to @mon, notice: 'Mon was successfully created.' }
        format.json { render :show, status: :created, location: @mon }
      else
        format.html { render :new }
        format.json { render json: @mon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mons/1
  # PATCH/PUT /mons/1.json
  def update
    respond_to do |format|
      if @mon.update(mon_params)
        format.html { redirect_to @mon, notice: 'Mon was successfully updated.' }
        format.json { render :show, status: :ok, location: @mon }
      else
        format.html { render :edit }
        format.json { render json: @mon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mons/1
  # DELETE /mons/1.json
  def destroy
    @mon.destroy
    respond_to do |format|
      format.html { redirect_to mons_url, notice: 'Mon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mon
    @mon = Mon.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mon_params
    params.require(:mon).permit(:name, :abilities)
  end

end