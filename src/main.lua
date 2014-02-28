local storyboard = require( "storyboard" )
local gv = require("global")
gv.height = display.contentHeight
gv.width = display.contentWidth


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

main()
