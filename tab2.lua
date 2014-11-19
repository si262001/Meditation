

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

-- Our scene
function scene:create( event )
	local sceneGroup = self.view
	
	-- Display a background
	local background = display.newImage( "assets/background.png", display.contentCenterX, display.contentCenterY, true )
	sceneGroup:insert( background )
	
	-- Our ScrollView listener
	local function scrollListener( event )
		local phase = event.phase
		local direction = event.direction
		
		if "began" == phase then
			--print( "Began" )
		elseif "moved" == phase then
			--print( "Moved" )
		elseif "ended" == phase then
			--print( "Ended" )
		end
		
		-- If the scrollView has reached it's scroll limit
		if event.limitReached then
			if "up" == direction then
				print( "Reached Top Limit" )
			elseif "down" == direction then
				print( "Reached Bottom Limit" )
			elseif "left" == direction then
				print( "Reached Left Limit" )
			elseif "right" == direction then
				print( "Reached Right Limit" )
			end
		end
				
		return true
	end

	-- Create a ScrollView
	local scrollView = widget.newScrollView
	{
		left = 10,
		top = 52,
		width = 300,
		height = 350,
		id = "onBottom",
		hideBackground = true,
		horizontalScrollingDisabled = false,
		verticalScrollingDisabled = false,
		maskFile = "assets/scrollViewMask-350.png",
		listener = scrollListener,
	}
	sceneGroup:insert( scrollView )
	
	-- Insert an image into the scrollView
	local background = display.newImageRect( "assets/scrollimage.jpg", 768, 1024 )
	background.x = background.contentWidth * 0.5
	background.y = background.contentHeight * 0.5

	scrollView:insert( background )

end

scene:addEventListener( "create" )

return scene
