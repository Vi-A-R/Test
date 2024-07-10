cd "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper"
start /wait jasshelper.exe --warcity --nooptimize  "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\common.j" "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\blizzard.j" "D:\Test-main\Illidans\main.zn" "D:\Test-main\Illidans\debug\out.j"
start /wait jasshelper.exe --zinconly --nooptimize  "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\common.j" "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\blizzard.j" "D:\Test-main\Illidans\debug\out.j" "D:\Test-main\Illidans\debug\out.j"

(
	echo function main takes nothing returns nothing
	echo endfunction
) >> D:\Test-main\Illidans\debug\out.j

start /wait jasshelper.exe --scriptonly --nooptimize  "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\common.j" "D:\WC3 tools\JNGP\Jass New Gen Pack Rebuild\jasshelper\blizzard.j" "D:\Test-main\Illidans\debug\out.j" "D:\Test-main\Illidans\debug\finalout.j"
