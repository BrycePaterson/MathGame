local storyboard = require( "storyboard" )



--calls the menu screen
local function listener( event )
   storyboard.gotoScene("menu")
 end



	--main Function that is called first, calls the splash screen
local function main()

	storyboard.gotoScene("splash")
	timer.performWithDelay( 1000,listener)
end

main()
