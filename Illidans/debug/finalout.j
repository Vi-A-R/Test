globals
//globals from Globals:
constant boolean LIBRARY_Globals=true
trigger UnitSpellEffect
player array Players
player MarshalPlayer
unit tUnit
group tGroup
player tPlayer
//endglobals from Globals
//globals from Main:
constant boolean LIBRARY_Main=true
//endglobals from Main
//globals from ZikkyratAction:
constant boolean LIBRARY_ZikkyratAction=true
group ZikkyratAction___Zikkyrats
unit ZikkyratAction___ZikkyratTarget
unit ZikkyratAction___ZikkyratCreatedUnit
//endglobals from ZikkyratAction

trigger l__library_init

//JASSHelper struct globals:

endglobals


//library Globals:

    //public:  //Глобальные переменные
    function Globals___onInit takes nothing returns nothing
        local integer index
        set UnitSpellEffect=CreateTrigger()
        set index=0 //Запихиваю плэеров в массив, чтобы не вызывать нативку
        loop
        exitwhen ( index >= bj_MAX_PLAYER_SLOTS )
            set Players[index]=Player(index)
            call TriggerRegisterPlayerUnitEvent(UnitSpellEffect, Players[index], EVENT_PLAYER_UNIT_SPELL_EFFECT, null) //Объявление глобальных событий
        set index=index + 1
        endloop
    endfunction

//library Globals ends
//library Main:

    function Main__onInit takes nothing returns nothing
    endfunction

//library Main ends
//library ZikkyratAction:
    function ZikkyratAction___ZikkyratCheckTarget takes unit whichUnit returns boolean
        if ( IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE) ) then
            return false
        endif
        if ( GetUnitTypeId(whichUnit) == 'hbot' ) then
            return false
        endif
        if ( IsUnitType(whichUnit, UNIT_TYPE_HERO) ) then
            return false
        endif
        if ( IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL) ) then
            return false
        endif
        if ( IsUnitType(whichUnit, UNIT_TYPE_SUMMONED) ) then
            return false
        endif
        if ( IsUnitType(whichUnit, UNIT_TYPE_PEON) ) then
            return false
        endif
        if ( GetUnitAbilityLevel(whichUnit, 'A01Z') != 0 ) then
            return false
        endif
        if ( GetUnitAbilityLevel(whichUnit, 'A01I') != 0 ) then
            return false
        endif
        if ( GetUnitState(whichUnit, UNIT_STATE_LIFE) <= 0 ) then
            return false
        endif
        if ( not ( IsUnitEnemy(whichUnit, MarshalPlayer) ) ) then
            return false
        endif
        return true
    endfunction
    function ZikkyratAction___ZikkyratFilterGroup takes nothing returns nothing
        set tUnit=GetEnumUnit()
        if ( ZikkyratAction___ZikkyratCheckTarget(tUnit) ) then
            call GroupRemoveUnit(tGroup, tUnit)
        endif
    endfunction
    function ZikkyratAction___OnZikkyratSpellEffect takes nothing returns nothing
        set tUnit=GetTriggerUnit() //оператор "!" равносилен not
        if ( GetUnitTypeId(tUnit) != 'uzig' ) then //Прекращаем выполнение действия, если тип юнита не 'uzig'
            return
        endif
        set tGroup=CreateGroup()
        call GroupEnumUnitsInRect(tGroup, bj_mapInitialPlayableArea, null)
        call ForGroup(tGroup, function ZikkyratAction___ZikkyratFilterGroup)
        set ZikkyratAction___ZikkyratTarget=GroupPickRandomUnit(tGroup)
        call UnitDamageTarget(tUnit, ZikkyratAction___ZikkyratTarget, 1500.00, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
        set ZikkyratAction___ZikkyratCreatedUnit=CreateUnit(MarshalPlayer, GetUnitTypeId(ZikkyratAction___ZikkyratTarget), GetUnitX(ZikkyratAction___ZikkyratTarget), GetUnitY(ZikkyratAction___ZikkyratTarget), GetUnitFacing(ZikkyratAction___ZikkyratTarget))
        call UnitAddType(ZikkyratAction___ZikkyratCreatedUnit, UNIT_TYPE_SUMMONED)
        call SetUnitVertexColor(ZikkyratAction___ZikkyratCreatedUnit, 0, 0, 0, PercentTo255(50.00))
        call UnitAddAbility(ZikkyratAction___ZikkyratCreatedUnit, 'ACrn')
        call RemoveUnit(ZikkyratAction___ZikkyratTarget)
        call DestroyGroup(tGroup)
    endfunction
    function ZikkyratAction___OnUndeadPicked takes nothing returns nothing
        call TriggerAddAction(UnitSpellEffect, function ZikkyratAction___OnZikkyratSpellEffect)
    endfunction

//library ZikkyratAction ends
function main takes nothing returns nothing

call ExecuteFunc("Globals___onInit")
call ExecuteFunc("Main__onInit")

endfunction



//Struct method generated initializers/callers:

