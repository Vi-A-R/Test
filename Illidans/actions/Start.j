scope StartAct initializer onInit

    private function RemoveUnitCB takes nothing returns nothing
        call RemoveUnit( GetEnumUnit() )
    endfunction

    private function Trig_Start_Func002Func013002 takes nothing returns nothing
        local unit enumUnit = GetEnumUnit()
        if( IsUnitType( enumUnit, UNIT_TYPE_STRUCTURE) ) then
            call SetUnitOwner( enumUnit, udg_MarshalPlayer, true )
        endif
        set enumUnit = null
    endfunction

    private function Trig_Start_Func003Func008002 takes nothing returns nothing
        call SetPlayerTechResearchedSwap( 'Recb', 1, GetEnumPlayer() )
    endfunction

    private function Trig_Start_Actions takes nothing returns nothing
        if ( GetUnitTypeId(GetTriggerUnit()) == 'e00B' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_iIlidanPlayer = GetOwningPlayer(GetTriggerUnit())

            call SetPlayerTechMaxAllowed(udg_iIlidanPlayer, 'n005', 1 )
            call SetPlayerTechMaxAllowed(udg_iIlidanPlayer, 'ntt1', 4 )
            call SetPlayerTechMaxAllowed(udg_iIlidanPlayer, 'n00U', 3 )
            
            call SetPlayerAllianceStateBJ( udg_iIlidanPlayer, Player(9), bj_ALLIANCE_ALLIED_VISION )
            call SetPlayerAllianceStateBJ( Player(9), udg_iIlidanPlayer, bj_ALLIANCE_ALLIED_VISION )

            call DisplayTimedTextToPlayers( GetPlayerName(udg_iIlidanPlayer) + ": Выбрал Иллидана" )
            call SetPlayerName( udg_iIlidanPlayer, ( GetPlayerName(udg_iIlidanPlayer) + " (Иллидан)" ) )

            call ForceRemovePlayer( udg_PickPlayers, GetOwningPlayer( GetTriggerUnit( ) ) )
            call ForceAddPlayer( udg_PlayPlayers, udg_iIlidanPlayer )

            call ForGroup( GetUnitsOnMapOfPlayer( udg_iIlidanPlayer ), function RemoveUnitCB )

            call GroupClear( tempGroup )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_Nagi_arma, null )
            call GroupUnitsSetOwner( tempGroup, udg_iIlidanPlayer )

            call SetUnitOwner( gg_unit_nntt_0009, udg_iIlidanPlayer, true )

            set udg_iIlidan = CreateUnit( udg_iIlidanPlayer, 'E002', GetRectCenterX( gg_rct_Nagi_arma ), GetRectCenterY( gg_rct_Nagi_arma ), bj_UNIT_FACING )
            call UnitAddItemById( udg_iIlidan, 'ckng' )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_nntt_0094 ), GetUnitY( gg_unit_nntt_0094 ) )
            call PanCameraToTimedLocForPlayer( udg_iIlidanPlayer, tempLoc, 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e001' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_MarshalPlayer = GetOwningPlayer(GetTriggerUnit())
            set udg_NameAlik = GetPlayerName( udg_MarshalPlayer )

            call SetPlayerTechMaxAllowed(udg_MarshalPlayer, 'h001', 1 )
            call SetPlayerTechMaxAllowed(udg_MarshalPlayer, 'h00T', 5 )

            call SetPlayerAllianceStateBJ( udg_MarshalPlayer, Player(8), bj_ALLIANCE_ALLIED_VISION )
            call SetPlayerAllianceStateBJ( Player(8), udg_MarshalPlayer, bj_ALLIANCE_ALLIED_VISION )

            call DisplayTimedTextToPlayers( udg_NameAlik + " играет за людей" )
            call SetPlayerName( udg_MarshalPlayer, udg_NameAlik + " (Люди)" )
            
            call ForceRemovePlayer(udg_PickPlayers, udg_MarshalPlayer)
            call ForceAddPlayer(udg_PlayPlayers, udg_MarshalPlayer)

            call ForGroup( GetUnitsOnMapOfPlayer( udg_MarshalPlayer ), function RemoveUnitCB )

            call ForGroup( GetUnitsOnMapOfPlayer( Player(8) ), function Trig_Start_Func002Func013002 )

            call GroupClear( tempGroup )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_DopBaza, null )
            call GroupUnitsSetOwner( tempGroup, udg_MarshalPlayer )

            call SelectUnitForPlayerSingle( gg_unit_halt_0454, udg_MarshalPlayer )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_htow_0453 ), GetUnitY( gg_unit_htow_0453 ) )
            call PanCameraToTimedLocForPlayer( udg_MarshalPlayer, tempLoc, 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e00A' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_MevPlayer = GetOwningPlayer(GetTriggerUnit())

            call SetPlayerTechMaxAllowed(udg_MevPlayer, 'ensh', 1 )
            call SetPlayerTechMaxAllowed(udg_MevPlayer, 'e005', 1 )
            call SetPlayerTechMaxAllowed(udg_MevPlayer, 'ewsp', 15 )

            call DisplayTimedTextToPlayers( GetPlayerName( udg_MevPlayer ) + " играет за Мэв" )
            call SetPlayerName( udg_MevPlayer, GetPlayerName( udg_MevPlayer ) + " (Мэв)" )

            call ForForce( bj_FORCE_ALL_PLAYERS, function Trig_Start_Func003Func008002 )
            call ForceRemovePlayer(udg_PickPlayers, udg_MevPlayer)
            call ForceAddPlayer(udg_PlayPlayers, udg_MevPlayer)

            call ForGroup( GetUnitsOnMapOfPlayer( udg_MevPlayer ), function RemoveUnitCB )

            call GroupClear( tempGroup )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_NightElf, null )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_NightElf2, null )
            call GroupUnitsSetOwner( tempGroup, udg_MevPlayer )

            set udg_Mev = CreateUnit( udg_MevPlayer, 'E004', GetRectCenterX( gg_rct_Drevo ), GetRectCenterY( gg_rct_Drevo ), bj_UNIT_FACING )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_etoe_0735 ), GetUnitY( gg_unit_etoe_0735 ) )
            call PanCameraToTimedLocForPlayer( udg_MevPlayer, tempLoc, 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e003' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_KelPlayer = GetOwningPlayer(GetTriggerUnit())

            call SetPlayerTechMaxAllowed(udg_KelPlayer, 'hbew', 1 )
            call SetPlayerTechMaxAllowed(udg_KelPlayer, 'h00Q', 4 )

            call DisplayTimedTextToPlayers( GetPlayerName( udg_KelPlayer ) + " играет за Высших эльфов" )
            call SetPlayerName( udg_KelPlayer, GetPlayerName( udg_KelPlayer ) + " (Высшие эльфы)" )
            
            call ForceRemovePlayer( udg_PickPlayers, udg_KelPlayer )
            call ForceAddPlayer(udg_PlayPlayers, udg_KelPlayer)

            call ForGroup( GetUnitsOnMapOfPlayer( udg_KelPlayer ), function RemoveUnitCB )

            call GroupClear( tempGroup )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_Keli, null )
            call GroupUnitsSetOwner( tempGroup, udg_KelPlayer )

            call CreateNUnits( udg_KelPlayer, 'nhef', 5, GetRectCenterX( gg_rct_Kel_resp ), GetRectCenterY( gg_rct_Kel_resp ), bj_UNIT_FACING )

            set udg_Kel = CreateUnit( udg_KelPlayer, 'Hkal', GetRectCenterX( gg_rct_Kel_resp ), GetRectCenterY( gg_rct_Kel_resp ), bj_UNIT_FACING )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_h003_0419 ), GetUnitY( gg_unit_h003_0419 ) )
            call PanCameraToTimedLocForPlayer( udg_KelPlayer, tempLoc, 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e00D' ) then
            set udg_DemonPlayer = GetOwningPlayer(GetTriggerUnit())

            call SetPlayerTechMaxAllowed(udg_DemonPlayer, 'ntt1', 4 )

            call ShowUnit( GetTriggerUnit(), false )

            call DisplayTimedTextToPlayers( GetPlayerName( udg_DemonPlayer ) + " играет за Вторженцов" )
            call SetPlayerName( udg_DemonPlayer, GetPlayerName(udg_DemonPlayer) + " (Вторженцы)" )

            call ForceRemovePlayer(udg_PickPlayers, udg_DemonPlayer)
            call ForceAddPlayer(udg_PlayPlayers, udg_DemonPlayer)

            call ForGroup( GetUnitsOnMapOfPlayer( udg_DemonPlayer ), function RemoveUnitCB )

            call SetUnitOwner( gg_unit_ncp3_0317, udg_DemonPlayer, true )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_ncp3_0317 ), GetUnitY( gg_unit_ncp3_0317 ) )
            call PanCameraToTimedLocForPlayer( udg_DemonPlayer, tempLoc, 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e00T' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_SatyrPlayer = GetOwningPlayer(GetTriggerUnit())

            call SetPlayerTechMaxAllowed(udg_SatyrPlayer, 'n010', 3 )
            call SetPlayerTechMaxAllowed(udg_SatyrPlayer, 'n017', 20 )

            call DisplayTimedTextToPlayers( GetPlayerName( udg_SatyrPlayer ) + " играет за Сатиров" )
            call SetPlayerName( udg_SatyrPlayer, GetPlayerName( udg_SatyrPlayer ) + " (Сатиры)" )
            
            call ForceRemovePlayer( udg_PickPlayers, udg_SatyrPlayer )
            call ForceAddPlayer(udg_PlayPlayers, udg_SatyrPlayer)

            call ForGroup( GetUnitsOnMapOfPlayer( udg_SatyrPlayer ), function RemoveUnitCB )

            call GroupClear( tempGroup )
            call GroupEnumUnitsInRect( tempGroup, gg_rct_SatyrStart, null )
            call GroupUnitsSetOwner( tempGroup, udg_SatyrPlayer )

            set udg_SatyrHero = gg_unit_U000_1860

            call MoveLocation( tempLoc, GetUnitX( gg_unit_e00H_1859 ), GetUnitY( gg_unit_e00H_1859 ) )
            call PanCameraToTimedLocForPlayer( udg_SatyrPlayer, GetUnitLoc(gg_unit_e00H_1859), 0 )
        endif

        if ( GetUnitTypeId(GetTriggerUnit()) == 'e00R' ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_DiciyPlayer = GetOwningPlayer(GetTriggerUnit())

            call ForceRemovePlayer(udg_PickPlayers, udg_DiciyPlayer)
            call ForceAddPlayer(udg_PlayPlayers, udg_DiciyPlayer)

            call DisplayTimedTextToPlayers( GetPlayerName( udg_DiciyPlayer ) + ": Выбрал Дополнительные рассы" )

            call ForGroup( GetUnitsOnMapOfPlayer( udg_DiciyPlayer ), function RemoveUnitCB )

            call SetUnitOwner( gg_unit_n01B_1300, udg_DiciyPlayer, true )
            call SelectUnitForPlayerSingle( gg_unit_n01B_1300, udg_DiciyPlayer )

            call MoveLocation( tempLoc, GetUnitX( gg_unit_n01B_1300 ), GetUnitY( gg_unit_n01B_1300 ) )
            call PanCameraToTimedLocForPlayer( udg_DiciyPlayer, tempLoc, 0 )
        endif

        if (  GetUnitTypeId(GetTriggerUnit()) == 'e00P'  ) then
            call ShowUnit( GetTriggerUnit(), false )

            set udg_KorolGorPlayer = GetOwningPlayer( GetTriggerUnit( ) )

            call ForceRemovePlayer( udg_PickPlayers, GetOwningPlayer( GetTriggerUnit( ) ) )
            call ForceAddPlayer( udg_PlayPlayers, udg_KorolGorPlayer )

            call ForGroup( GetUnitsOnMapOfPlayer( udg_KorolGorPlayer ), function RemoveUnitCB )

            call ConditionalTriggerExecute( gg_trg_Pick_Gnom )
        endif
    endfunction

    private function onInit takes nothing returns nothing
    endfunction

endscope

    


