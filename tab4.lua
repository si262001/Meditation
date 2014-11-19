--*********************************************************************************************
--
-- ====================================================================
-- Corona SDK "Widget" Sample Code
-- ====================================================================
--
-- File: main.lua
--
-- Version 2.0
--
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
--
-- Published changes made to this software and associated documentation and module files (the
-- "Software") may be used and distributed by Corona Labs, Inc. without notification. Modifications
-- made to this software and associated documentation and module files may or may not become
-- part of an official software release. All modifications made to the software will be
-- licensed under these same terms and conditions.
--
-- Supports Graphics 2.0
--*********************************************************************************************

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

-- Our scene
function scene:create( event )
	local sceneGroup = self.view
	
	-- Display a background
	local background = display.newImage( "assets/background.png", display.contentCenterX, display.contentCenterY, true )
	sceneGroup:insert( background )
	
	-- Status text box
	local statusBox = display.newRect( 70, 290, 210, 120 )
	statusBox.anchorX = 0
	statusBox.anchorY = 0
	statusBox:setFillColor( 0, 0, 0 )
	statusBox.alpha = 0.4
	sceneGroup:insert( statusBox )
	
	-- Status text
	local statusText = display.newText( "Interact with a widget to begin!", 80, 300, 200, 0, native.systemFont, 20 )
	statusText.anchorX = 0
	statusText.anchorY = 0
	statusText.x = statusBox.x + 5
	statusText.y = statusBox.y + 5
	sceneGroup:insert( statusText )
	
	---------------------------------------------------------------------------------------------
	-- widget.newSegmentedControl()
	---------------------------------------------------------------------------------------------
	
	-- The listener for our segmented control
	local function segmentedControlListener( event )
		local target = event.target
		
		-- Update the status box text
		statusText.text = "Segmented Control\nSegment Pressed: " .. target.segmentLabel
		
	end
	
	-- Create a default segmented control (using widget.setTheme)
	local segmentedControl = widget.newSegmentedControl
	{
	    left = 10,
	    top = 60,
	    segments = { "The", "Corona", "SDK", "Widget", "Demo!" },
	    defaultSegment = 1,
	    onPress = segmentedControlListener,
	}
	sceneGroup:insert( segmentedControl )
	
	---------------------------------------------------------------------------------------------
	-- widget.newSlider()
	---------------------------------------------------------------------------------------------
	
	-- The listener for our slider's
	local function sliderListener( event )
		-- Update the status box text
		statusText.text = event.target.id .. "\nCurrent Percent:\n" .. event.value .. "%"
		
	end
	
	-- Create a horizontal slider
	local horizontalSlider = widget.newSlider
	{
		left = 150,
		top = 232,
		width = 150,
		id = "Horizontal Slider",
		listener = sliderListener,
	}
	sceneGroup:insert( horizontalSlider )
	
	-- Create a vertical slider
	local verticalSlider = widget.newSlider
	{
		left = 10,
		top = 270,
		height = 150,
		id = "Vertical Slider",
		orientation = "vertical",
		listener = sliderListener,
	}
	sceneGroup:insert( verticalSlider )
	
	---------------------------------------------------------------------------------------------
	-- widget.newSpinner()
	---------------------------------------------------------------------------------------------
	
	-- Create a spinner widget
	local spinner = widget.newSpinner
	{
		left = 274,
		top = 55,
	}
	sceneGroup:insert( spinner )
	
	-- Start the spinner animating
	spinner:start()
	
	---------------------------------------------------------------------------------------------
	-- widget.newStepper()
	---------------------------------------------------------------------------------------------
	
	-- Create some text for the stepper
	local currentValue = display.newText( "Value: 00", 165, 105, native.systemFont, 20 )
	currentValue.anchorX = 0
	currentValue.anchorY = 0
	currentValue:setFillColor( 0 )
	sceneGroup:insert( currentValue )
	
	-- The listener for our stepper
	local function stepperListener( event )
		local phase = event.phase

		-- Update the text to reflect the stepper's current value
		currentValue.text = "Value: " .. string.format( "%02d", event.value )
	end
	
	-- Create a stepper
	local newStepper = widget.newStepper
	{
	    left = 50,
	    top = 105,
	    initialValue = 0,
	    minimumValue = 0,
	    maximumValue = 50,
	    onPress = stepperListener,
	}
	sceneGroup:insert( newStepper )
	
	---------------------------------------------------------------------------------------------
	-- widget.newProgressView()
	---------------------------------------------------------------------------------------------
	
	local newProgressView = widget.newProgressView
	{
		left = 20,
		top = 240,
		width = 100,
		isAnimated = true,
	}
	sceneGroup:insert( newProgressView )
	
	-- Set the progress to 100%
	newProgressView:setProgress( 1.0 )
	
	---------------------------------------------------------------------------------------------
	-- widget.newSwitch()
	---------------------------------------------------------------------------------------------
	
	-- The listener for our radio switch
	local function radioSwitchListener( event )
		-- Update the status box text
		statusText.text = "Radio Switch\nIs on?: " .. tostring( event.target.isOn )
		
	end
		
	-- Create some text to label the radio button with
	local radioButtonText = display.newText( "Use?", 40, 150, native.systemFont, 16 )
	radioButtonText.anchorX = 0
	radioButtonText.anchorY = 0
	radioButtonText:setFillColor( 0 )
	sceneGroup:insert( radioButtonText )
		
	-- Create a default radio button (using widget.setTheme)
	local radioButton = widget.newSwitch
	{
	    left = 25,
	    top = 180,
	    style = "radio",
	    id = "Radio Button",
	    initialSwitchState = true,
	    onPress = radioSwitchListener,
	}
	sceneGroup:insert( radioButton )
	
	local otherRadioButton = widget.newSwitch
	{
	    left = 55,
	    top = 180,
	    style = "radio",
	    id = "Radio Button2",
	    initialSwitchState = false,
	    onPress = radioSwitchListener,
	}
	sceneGroup:insert( otherRadioButton )
	
	-- Create some text to label the checkbox with
	local checkboxText = display.newText( "Sound?", 110, 150, native.systemFont, 16 )
	checkboxText.anchorX = 0
	checkboxText.anchorY = 0
	checkboxText:setFillColor( 0 )
	sceneGroup:insert( checkboxText )
	
	-- The listener for our checkbox switch
	local function checkboxSwitchListener( event )
		-- Update the status box text
		statusText.text = "Checkbox Switch\nIs on?: " .. tostring( event.target.isOn )
		
	end
	
	-- Create a default checkbox button (using widget.setTheme)
	local checkboxButton = widget.newSwitch
	{
	    left = 120,
	    top = 180,
	    style = "checkbox",
	    id = "Checkbox button",
	    onPress = checkboxSwitchListener,
	}
	sceneGroup:insert( checkboxButton )

	-- Create some text to label the on/off switch with
	local switchText = display.newText( "Music?", 200, 150, native.systemFont, 16 )
	switchText.anchorX = 0
	switchText.anchorY = 0
	switchText:setFillColor( 0 )
	sceneGroup:insert( switchText )

	-- The listener for our on/off switch
	local function onOffSwitchListener( event )
		-- Update the status box text
		statusText.text = "On/Off Switch\nIs on?: " .. tostring( event.target.isOn )
		
	end

	-- Create a default on/off switch (using widget.setTheme)
	local onOffSwitch = widget.newSwitch
	{
	    left = 190,
	    top = 180,
	    initialSwitchState = true,
	    onPress = onOffSwitchListener,
	    onRelease = onOffSwitchListener,
	}
	sceneGroup:insert( onOffSwitch )	
end

scene:addEventListener( "create" )

return scene
