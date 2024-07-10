cd "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper"
start /wait jasshelper.exe --warcity --nooptimize  "common.j" "blizzard.j" "D:\Test-main\Illidans\main.zn" "D:\Test-main\Illidans\debug\out.j"
start /wait jasshelper.exe --zinconly --nooptimize  "common.j" "blizzard.j" "D:\Test-main\Illidans\debug\out.j" "D:\Test-main\Illidans\debug\out.j"

(
	echo function main takes nothing returns nothing
	echo endfunction
) >> D:\Test-main\Illidans\debug\out.j

start /wait jasshelper.exe --scriptonly  "common.j" "blizzard.j" "D:\Test-main\Illidans\debug\out.j" "D:\Test-main\Illidans\debug\out.j"