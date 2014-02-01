local storyboard = require( "storyboard" )


local function listener( event )
   storyboard.gotoScene("menu")
 end



	
local function main()

	storyboard.gotoScene("splash")
	timer.performWithDelay( 1000,listener)
end

main()
