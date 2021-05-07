class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :type1, :type2, :total, :hp, :attack, :defense, :spatk, :spdef, :speed, :generation, :legendary
end
