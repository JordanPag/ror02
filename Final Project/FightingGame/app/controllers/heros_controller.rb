def hit(attacker, receiver, hp)
  if attacker[0] == nil
    damage = attacker.atk.to_f * (1 - (receiver[3].to_f)/600)
  else
    damage = attacker[2].to_f * (1 - (receiver.defense.to_f)/600)
  end
  damage = damage.round
  if hp - damage < 0
    return 0
  else
    return hp - damage
  end
end

class HerosController < ApplicationController
  before_action :set_hero, only: [:show, :edit, :update, :destroy]

  # GET /heros
  # GET /heros.json
  def index
    @heros = Hero.all
  end

  # GET /heros/1
  # GET /heros/1.json
  def show
  end

  # GET /heros/new
  def new
    @hero = Hero.new
    @hero.user_id = current_user.id
  end

  # GET /heros/1/edit
  def edit
  end

  # POST /heros
  # POST /heros.json
  def create
    params.permit!
    @hero = Hero.new(params[:hero])
    respond_to do |format|
      if @hero.save
        @hero.hp += 100
        if @hero.kind == "Elf"
          @hero.speed += 12
        elsif @hero.kind == "Human"
          @hero.atk += 3
          @hero.defense += 3
          @hero.hp += 15
          @hero.speed += 3
        elsif @hero.kind == "Troll"
          @hero.defense += 12
        elsif @hero.kind == "Giant"
          @hero.hp += 60
        elsif @hero.kind == "Barbarian"
          @hero.atk += 12
        end
        if @hero.save(validate: false)
          format.html { redirect_to "/", notice: 'Hero was successfully created.' }
          format.json { render :show, status: :created, location: @hero }
        end
      else
        format.html { render :new }
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heros/1
  # PATCH/PUT /heros/1.json
  def update
    params.permit!
    respond_to do |format|
      if @hero.update(params[:hero])
        @hero.hp += 100
        if @hero.kind == "Elf"
          @hero.speed += 12
        elsif @hero.kind == "Human"
          @hero.atk += 3
          @hero.defense += 3
          @hero.hp += 15
          @hero.speed += 3
        elsif @hero.kind == "Troll"
          @hero.defense += 12
        elsif @hero.kind == "Giant"
          @hero.hp += 60
        elsif @hero.kind == "Barbarian"
          @hero.atk += 12
        end
        if @hero.save(validate: false)
          format.html { redirect_to "/", notice: 'Hero was successfully updated.' }
          format.json { render :show, status: :ok, location: @hero }
        end
      else
        format.html { render :edit }
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heros/1
  # DELETE /heros/1.json
  def destroy
    @hero.destroy
    respond_to do |format|
      format.html { redirect_to "/", notice: 'Hero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /battle
  def battle
    @enemynum = rand(3)
  end

  # POST /battle
  def attack
    params.permit!
    @enemynum = params[:enemynum].to_i
    enemies = [["Bat", 100, 150, 50, 90, "https://i.pinimg.com/originals/b6/2b/d6/b62bd653a5ea86726d1b28b9cfc9916d.gif"],
    ["Zombie", 200, 50, 140, 10, "https://vignette.wikia.nocookie.net/plantsvszombies/images/a/af/Bbzzzzz.png/revision/latest?cb=20150924172130"],
    ["Ghost", 150, 100, 0, 150, "https://i.pinimg.com/originals/9d/e6/a7/9de6a7134d2a314489866b2561299488.png"]]
    enemy = enemies[@enemynum]
    hero = current_user.heros[0]
    enemyhp = enemy[1]
    herohp = hero.hp
    # Enemy attrs: "Name", hp, atk, def, speed, "url"
    if hero.speed > enemy[4]
      enemyhp = hit(hero, enemy, enemyhp)
      render plain: "Hero attacks first and enemy hp will be #{enemy[3]/600}"
    else
      herohp = hit(enemy, hero, herohp)
      render plain: "#{enemy[0]} attacks first and hero hp will be #{herohp}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hero_params
      params.require(:hero).permit(:name, :atk, :hp, :def, :speed, :type, :user_id)
    end
end
