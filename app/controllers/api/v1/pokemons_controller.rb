class Api::V1::PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :update, :destroy]

  MAX_PER_PAGE = 10

  # GET /pokemons
  def index
    @pokemons = Pokemon.limit(limit_per_page).offset(params[:offset])

    render json: @pokemons
  end

  # GET /pokemons/1
  def show
    render json: @pokemon
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: :created
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
  end

  private
    def limit_per_page
      [
        params.fetch(:per_page, MAX_PER_PAGE).to_i,
        MAX_PER_PAGE
      ].min
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :type1, :type2, :total, :hp, :attack, :defense, :spatk, :spdef, :speed, :generation, :legendary)
    end
end
