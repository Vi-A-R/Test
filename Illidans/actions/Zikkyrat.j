scope ZikkyratAct initializer onInit

    globals 
        group Zikkyrats
        unit ZikkyratTarget
        unit ZikkyratCreatedUnit
    endglobals


    function ZikkyratCheckTarget takes unit whichUnit returns boolean
        if (IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE)) then
            return false
        endif
        if (GetUnitTypeId(whichUnit) == 'hbot') then
            return false
        endif
        if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
            return false
        endif
        if (IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL)) then
            return false
        endif
        if (IsUnitType(whichUnit, UNIT_TYPE_SUMMONED)) then
            return false
        endif
        if (IsUnitType(whichUnit, UNIT_TYPE_PEON)) then
            return false
        endif
        if (GetUnitAbilityLevel(whichUnit, 'A01Z') != 0) then
            return false
        endif
        if (GetUnitAbilityLevel(whichUnit, 'A01I') != 0) then
            return false
        endif
        if (GetUnitState(whichUnit, UNIT_STATE_LIFE) <= 0) then
            return false
        endif
        if (not IsUnitEnemy(whichUnit, MarshalPlayer)) then
            return false
        endif
        return true
    endfunction

    function ZikkyratFilterGroup takes nothing returns nothing
        set tUnit = GetEnumUnit()
        if (ZikkyratCheckTarget(tUnit)) then
            call GroupRemoveUnit(tGroup, tUnit)
        endif
    endfunction

    function OnZikkyratSpellEffect takes nothing returns nothing 
        set tUnit = GetTriggerUnit()
        //оператор "!" равносилен not
        if(GetUnitTypeId(tUnit) != 'uzig') then
            return //Прекращаем выполнение действия, если тип юнита не 'uzig'
        endif

        set tGroup = CreateGroup()
        call GroupEnumUnitsInRect(tGroup, bj_mapInitialPlayableArea, null)
        call ForGroup(tGroup, function ZikkyratFilterGroup)
        set ZikkyratTarget = GroupPickRandomUnit(tGroup)

        call UnitDamageTarget(tUnit, ZikkyratTarget, 1500.00, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
        set ZikkyratCreatedUnit = CreateUnit(MarshalPlayer, GetUnitTypeId(ZikkyratTarget), GetUnitX(ZikkyratTarget), GetUnitY(ZikkyratTarget), GetUnitFacing(ZikkyratTarget))
        call UnitAddType(ZikkyratCreatedUnit, UNIT_TYPE_SUMMONED)
        call SetUnitVertexColor(ZikkyratCreatedUnit, 0, 0, 0, PercentTo255(50.00))
        call UnitAddAbility(ZikkyratCreatedUnit, 'ACrn')

        call RemoveUnit(ZikkyratTarget)
        call DestroyGroup(tGroup)
    endfunction

    //Вызываешь это, когда пикается нужная фракция
    function OnUndeadPicked takes nothing returns nothing
        call TriggerAddAction(UnitSpellEffect, function OnZikkyratSpellEffect)
    endfunction

    private function onInit takes nothing returns nothing
        
    endfunction
endscope

