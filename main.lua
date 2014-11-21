
-- row  r 92 g 167 b 186
-- bg  r 3 g 101 b 100
-- segment r 205 g 179 b 128
-- tab r 3 g 54 b 73
-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
local RGB = 255;
-- Set the background to white
display.setDefault( "background", 3/RGB , 101/RGB , 100/RGB )	-- white

-- Require the widget & composer libraries
local widget = require( "widget" )
local composer = require( "composer" )

local halfW = display.contentCenterX
local halfH = display.contentCenterY

local titleGradient = {
	type = 'gradient',
	color1 = { 189/255, 203/255, 220/255, 255/255 }, 
	color2 = { 89/255, 116/255, 152/255, 255/255 },
	direction = "down"
}



-- Create buttons table for the tab bar
local tabButtons = 
{
	{
		width = 32, 
		height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "Audio",
		onPress = function() 
				local options =
				{
				    effect = "fromTop",
				    time = 400
				}
				composer.gotoScene( "myaudio",options ); 
			end,
		selected = true
	},
	{
		width = 32, 
		height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "Timer",
		onPress = function() 
				local options =
				{
				    effect = "fromTop",
				    time = 400
				}
				composer.gotoScene( "mytimer",options );
			end
	}
}

-- Create a tab-bar and place it at the bottom of the screen
local tabBar = widget.newTabBar
{
	top = display.contentHeight - 8,
	width = display.contentWidth,
	buttons = tabButtons,
	backgroundFile = "assets/tabbar.png",
	tabSelectedLeftFile = "assets/tabbar_select.png",
	tabSelectedRightFile = "assets/tabbar_select.png",
	tabSelectedMiddleFile = "assets/tabbar_select.png",
	tabSelectedFrameWidth = 50,
	tabSelectedFrameHeight = 120,


}

-- Start at tab1
composer.gotoScene( "myaudio" )
