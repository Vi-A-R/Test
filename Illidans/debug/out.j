library Globals {
    //Публичный блок. В нём все переменные и функции доступны
    public {
        //Глобальные переменные
        trigger UnitSpellEffect;
        player Players[];
play
        player MarshalPlayer;

        //Временные переменные (для того, чтобы избегать создания локалок и фиксить утечки)
        unit tUnit;
        group tGroup;
        player tPlayer;
    }

    function onInit() -> nothing {
        integer index;
        UnitSpellEffect = CreateTrigger();
        for (0 <= index < bj_MAX_PLAYER_SLOTS) {
            //Запихиваю плэеров в массив, чтобы не вызывать нативку
            Players[index] = Player(index);

            //Объявление глобальных событий
            TriggerRegisterPlayerUnitEvent(UnitSpellEffect, Players[index], EVENT_PLAYER_UNIT_SPELL_EFFECT, null);
        }
    }
}
library ZikkyratAction requires Globals {

    group Zikkyrats;
    unit ZikkyratTarget;
    unit ZikkyratCreatedUnit;

    function ZikkyratCheckTarget(unit whichUnit) -> boolean {
        if (IsUnitType(whichUnit, UNIT_TYPE_STRUCTURE))
            return false;
        if (GetUnitTypeId(whichUnit) == 'hbot')
            return false;
        if (IsUnitType(whichUnit, UNIT_TYPE_HERO))
            return false;
        if (IsUnitType(whichUnit, UNIT_TYPE_MECHANICAL))
            return false;
        if (IsUnitType(whichUnit, UNIT_TYPE_SUMMONED))
            return false;
        if (IsUnitType(whichUnit, UNIT_TYPE_PEON))
            return false;
        if (GetUnitAbilityLevel(whichUnit, 'A01Z') != 0)
            return false;
        if (GetUnitAbilityLevel(whichUnit, 'A01I') != 0)
            return false;
        if (GetUnitState(whichUnit, UNIT_STATE_LIFE) <= 0)
            return false;
        if (!IsUnitEnemy(whichUnit, MarshalPlayer))
            return false;
        return true;
    }

    function ZikkyratFilterGroup() -> nothing {
        tUnit = GetEnumUnit();
        if (ZikkyratCheckTarget(tUnit))
            GroupRemoveUnit(tGroup, tUnit);
    }

    function OnZikkyratSpellEffect() -> nothing {
        tUnit = GetTriggerUnit();
        //оператор "!" равносилен not
        if(GetUnitTypeId(tUnit) != 'uzig')
            return; //Прекращаем выполнение действия, если тип юнита не 'uzig'

        tGroup = CreateGroup();
        GroupEnumUnitsInRect(tGroup, bj_mapInitialPlayableArea, null);
        ForGroup(tGroup, function ZikkyratFilterGroup);
        ZikkyratTarget = GroupPickRandomUnit(tGroup);

        UnitDamageTarget(tUnit, ZikkyratTarget, 1500.00, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null);
        ZikkyratCreatedUnit = CreateUnit(MarshalPlayer, GetUnitTypeId(ZikkyratTarget),
                                        GetUnitX(ZikkyratTarget),
                                        GetUnitY(ZikkyratTarget),
                                        GetUnitFacing(ZikkyratTarget));
        UnitAddType(ZikkyratCreatedUnit, UNIT_TYPE_SUMMONED);
        SetUnitVertexColor(ZikkyratCreatedUnit, 0, 0, 0, PercentTo255(50.00));
        UnitAddAbility(ZikkyratCreatedUnit, 'ACrn');

        RemoveUnit(ZikkyratTarget);
        DestroyGroup(tGroup);
    }

    //Вызываешь это, когда пикается нужная фракция
    function OnUndeadPicked() -> nothing {
        TriggerAddAction(UnitSpellEffect, function OnZikkyratSpellEffect);
    }
}

library Main {

    function onInit() -> nothing {
        
    }

}
function main takes nothing returns nothing
endfunction
