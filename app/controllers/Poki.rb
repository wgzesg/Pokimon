<<-DOC
This class help holds a model of simplified pokimon by storing only relevant information from 
what Pokimon Api returns.
DOC
class Poki

    attr_reader :name, :hp, :attact, :defence, :spAttact, :spDefence, :speed, :sprite, :type
    attr_accessor :isAlive, :currentHp

    @name
    @hp
    @attact
    @defence
    @spAttact
    @spDefence
    @speed
    @sprite
    @isAlive
    @currentHp
    @type

    def initialize(name, hp, attact, defence, spAttact, spDefence, speed, type, sprite)
        @name = name
        @hp = hp
        @attact = attact
        @spAttact = spAttact
        @defence = defence
        @spDefence = spDefence
        @speed = speed
        @sprite = sprite
        @isAlive = true
        @currentHp = hp
        @type = type
    end

end