local storyboard = require( "storyboard" )
local gv = require("global")
gv.height = display.contentHeight
gv.width = display.contentWidth
gv.skinlist = {}

OP =3 --number of existing skins -1 


--calls the menu screen
local function listener( event )
   storyboard.gotoScene("menu")
 end

	--main Function that is called first, calls the splash screen
local function main()

	storyboard.gotoScene("splash")
	timer.performWithDelay( 1000,listener)
end


function background(g)

--loads background
    local bg = display.newImage("Background-Pattern.png")
    bg.x = gv.width/2 
    bg.y = gv.height/2 + 85
    bg:scale(1,2)
    g:insert(bg)

end

function writeMoney(first)

	local path = system.pathForFile("money.txt",system.DocumentsDirectory)
  	local file = io.open(path, "w+")

	if (first==true)then --first time playing
		 file:write("15 \n") --user starts off with 15 gold 
		 for i=0,OP-1 do
		 	file:write("1\n") --all skins are not owned 1 is not owned, 0 is owned
	 	end
	 	file:write("0\n")
	else
		 file:write(gv.gold.."\n") --writes new gold amount
		 for i=0,OP do
		 	file:write(gv.owned[i].."\n") --writes witch skins are bought
		 end	
	end
	io.close(file)
end

function loadMoney()

	local path = system.pathForFile("money.txt",system.DocumentsDirectory)
  	local file = io.open(path, "r")
  	
  	gv.owned = {}
  	gv.gold = file:read("*n")
  	
  	for i = 0,OP do
  		gv.owned[i] = file:read("*n")
	end
	
	gv.gold = 300

end

--method made for bryce
function totalTutTime()

local path = system.pathForFile("progress.txt",system.DocumentsDirectory)
  local file = io.open(path, "r")
  local a
  local sum = 0
  
  for line in file:lines() do
   a = line
   sum = sum + tonumber(a)
  end
  
  return sum
end
main()
