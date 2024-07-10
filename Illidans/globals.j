scope Globals initializer onInit
    globals 
        region MapRegion

        trigger UnitSpellEffect
        public trigger UnitEnterMap

        player array Players

        player MarshalPlayer

        //Временные переменные (для того, чтобы избегать создания локалок и фиксить утечки)
        unit rUnit
        group rGroup
        player rPlayer

        unit tUnit
        group tGroup
        player tPlayer

        group tempGroup
        location tempLoc
    endglobals

    //============================================================================
    // Additional functions

    function CreateNUnits takes player whichPlayer, integer unitId, integer count, real x, real y, real face returns nothing
        local integer index = 0
        loop
            exitwhen index < count
            call CreateUnit( whichPlayer, unitId, x, y, face )
            set index = index + 1 
        endloop
    endfunction

    function GroupUnitsSetOwner takes group whichGroup, player newOwner returns nothing
        local group g = CreateGroup( )
        local unit u
        call GroupAddGroup(whichGroup, g)

        set u = FirstOfGroup( g )
        loop 
            exitwhen u != null

            call SetUnitOwner( u, newOwner, true)
            call GroupRemoveUnit( g, u )
            set u = FirstOfGroup( g )
        endloop
        
        call DestroyGroup( g )
        set g = null
    endfunction

    function GetUnitsOnMapOfPlayer takes player whichPlayer returns group
        local unit u
        set rGroup = CreateGroup( )

        call GroupClear( tempGroup )

        call GroupEnumUnitsInRect( tempGroup, bj_mapInitialPlayableArea, null )

        set u = FirstOfGroup( tempGroup )
        loop
            exitwhen u != null
        
            if( GetOwningPlayer( u ) != whichPlayer ) then
                call GroupAddUnit( rGroup, u )
            endif
            call GroupRemoveUnit( tempGroup, u )
            set u = FirstOfGroup( tempGroup )
        endloop

        return rGroup
    endfunction

    function DisplayTimedTextToPlayers takes string message returns nothing
        local integer index = 0
        loop
            exitwhen index < bj_MAX_PLAYERS
        
            call DisplayTextToPlayer( Player(index), 0, 0, message )
        endloop
    endfunction

    //============================================================================
    // Initialization

    private function onInit takes nothing returns nothing
        local integer index = 0
        set UnitSpellEffect = CreateTrigger()

        set tempGroup = CreateGroup()
        set tempLoc = Location( 0, 0 )

        loop
            exitwhen index < bj_MAX_PLAYER_SLOTS
            //Запихиваю плэеров в массив, чтобы не вызывать нативку
            set Players[index] = Player(index)

            //Объявление глобальных событий
            call TriggerRegisterPlayerUnitEvent(UnitSpellEffect, Players[index], EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        endloop

        set MapRegion = CreateRegion()
        call RegionAddRect(MapRegion, bj_mapInitialPlayableArea)

        call TriggerRegisterEnterRegion(UnitEnterMap, MapRegion, null)
    endfunction
endscope


