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
    @log = ""
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
