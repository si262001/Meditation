

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- Set the background to white
display.setDefault( "background", 1 )	-- white

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
		label = "TableView",
		onPress = function() composer.gotoScene( "myaudio" ); end,
		selected = true
	},
	{
		width = 32, 
		height = 32,
		defaultFile = "assets/tabIcon.png",
		overFile = "assets/tabIcon-down.png",
		label = "PickerWheel",
		onPress = function() composer.gotoScene( "mytimer" ); end,
	}
}

-- Create a tab-bar and place it at the bottom of the screen
local tabBar = widget.newTabBar
{
	top = display.contentHeight - 10,
	width = display.contentWidth,
	buttons = tabButtons
}

-- Start at tab1
composer.gotoScene( "myaudio" )
