globals
//globals from Globals:
constant boolean LIBRARY_Globals=true
region MapRegion
trigger UnitSpellEffect
trigger UnitEnterMap
player array Players
player MarshalPlayer
unit rUnit
group rGroup
player rPlayer
group tempGroup
location tempLoc
//endglobals from Globals

trigger l__library_init

//JASSHelper struct globals:

endglobals


//library Globals:

    //public:  //Глобальные переменные
    function Globals___CreateNUnits takes player whichPlayer,integer unitId,integer count,real x,real y,real face returns nothing
        local integer index
        set index=0
        loop
        exitwhen ( index >= count )
            call CreateUnit(whichPlayer, unitId, x, y, face)
        set index=index + 1
        endloop
    endfunction
    function Globals___GroupUnitsSetOwner takes group whichGroup,player newOwner returns nothing
        local group g=CreateGroup()
        local unit u
        call GroupAddGroup(whichGroup, g)
        set u=FirstOfGroup(g)
        loop
        exitwhen ( u == null )
            call SetUnitOwner(u, newOwner, true)
            call GroupRemoveUnit(g, u)
            set u=FirstOfGroup(g)
        endloop
        call DestroyGroup(g)
        set g=null
    endfunction
    function Globals___GetUnitsOnMapOfPlayer takes player whichPlayer returns group
        local unit u
        set rGroup=CreateGroup()
        call GroupClear(tempGroup)
        call GroupEnumUnitsInRect(tempGroup, bj_mapInitialPlayableArea, null)
        set u=FirstOfGroup(tempGroup)
        loop
        exitwhen ( u == null )
            if ( GetOwningPlayer(u) != whichPlayer ) then
                call GroupAddUnit(rGroup, u)
            endif
            call GroupRemoveUnit(tempGroup, u)
            set u=FirstOfGroup(tempGroup)
        endloop
        return rGroup
    endfunction
    function Globals___DisplayTimedTextToPlayers takes string message returns nothing
        local integer index
        set index=0
        loop
        exitwhen ( index >= bj_MAX_PLAYERS )
            call DisplayTextToPlayer(Player(index), 0, 0, message)
        set index=index + 1
        endloop
    endfunction
    function Globals___onInit takes nothing returns nothing
        local integer index
        set UnitSpellEffect=CreateTrigger()
        set tempGroup=CreateGroup()
        set tempLoc=Location(0, 0)
        set index=0 //Запихиваю плэеров в массив, чтобы не вызывать нативку
        loop
        exitwhen ( index >= bj_MAX_PLAYER_SLOTS )
            set Players[index]=Player(index)
            call TriggerRegisterPlayerUnitEvent(UnitSpellEffect, Players[index], EVENT_PLAYER_UNIT_SPELL_EFFECT, null) //Объявление глобальных событий
        set index=index + 1
        endloop
        set MapRegion=CreateRegion()
        call RegionAddRect(MapRegion, bj_mapInitialPlayableArea)
        call TriggerRegisterEnterRegion(UnitEnterMap, MapRegion, null)
    endfunction

//library Globals ends
function main takes nothing returns nothing

call ExecuteFunc("Globals___onInit")

endfunction



//Struct method generated initializers/callers:

