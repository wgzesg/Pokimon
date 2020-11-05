<<-DOC
This module defines a constant hashmap of the type counter relation among the pokimons
DOC
module TypeRelation
    Counters = {
        "normal" => ["fighting"],
        "fighting" => ["flying", "psychic", "fairy"],
        "flying" => ["rock", "electric", "ice"],
        "poison" => ["ground", "psychic"],
        "ground" => ["water", "grass", "ice"],
        "rock" =>  ["fighting", "ground", "steel", "water", "grass"],
        "bug" => ["flying", "rock", "fire"],
        "ghost" => ["ghost", "dark"],
        "steel" => ["fighting", "ground", "fire"],
        "fire" => ["ground", "rock", "water"],
        "water" => ["grass", "electric"],
        "grass" => ["flying", "poison", "bug", "fire", "ice"],
        "electric" => ["ground"],
        "psychic" => ["bug", "ghost", "dark"],
        "ice" => ["fighting", "rock", "steel", "fire"],
        "dragon" => ["ice", "dragon", "fairy"],
        "fairy" => ["poison", "steel"],
        "dark" => ["fighting", "bug", "fairy"]
    }
end