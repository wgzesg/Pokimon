class VisitorsController < ApplicationController
  def index
    PokeApi.get(pokedex: 2).pokemon_entries.first.pokemon_species.get.evolution_chain.get
  end

end
