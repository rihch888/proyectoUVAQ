local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local widget = require( "widget" )
local scene = composer.newScene()
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})

function scene:create( event )
    local sceneGroup = self.view
    local centrox = display.contentCenterX
	local centroy = display.contentCenterY
	local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
	background:setFillColor(1, 1, 1)
	sceneGroup:insert( background )

	local myRectangle = display.newRect( centrox, 210, 400, 800 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    sceneGroup:insert( myRectangle )
	local puntuacion = display.newText("Felicidades", centrox, 150, native.systemFontBold, 40)
	puntuacion:setFillColor(1, 1, 1)
	sceneGroup:insert( puntuacion )
	local puntuacion2 = display.newText("tu puntuación es de:", centrox, 210, native.systemFontBold, 30)
	puntuacion2:setFillColor(1, 1, 1)
	sceneGroup:insert( puntuacion2 )
	local estrella = display.newImageRect("star2.png",160,160)
	estrella.x = centrox
	estrella.y = 330
	sceneGroup:insert( estrella )

	--local mydata = require( "mydata" )
	puntuacionNumero = display.newText("", centrox, 330, native.systemFontBold, 60)
	puntuacionNumero:setFillColor(1, 1, 1)
	sceneGroup:insert( puntuacionNumero )
	--mydata.score.text="0"
	

	 local function exit(event) 
	            if event.phase == "ended" then
	            	--puntuacionNumero.text=""
	            	local mydata = require( "mydata" )
	            	mydata.score=0
	            	mydata.participo=1
	            	print("mydata.participo 1: "..mydata.participo)
	                composer.gotoScene("eventos")
	            end
	        end
	    local bexit = widget.newButton
	    {
	        left = 110,
	        top = 440,
	        id = "button1",
	        label = "Continuar",
	        onEvent = exit,
	        shape="roundedRect",
	        width = 100,
	        height = 40,
	        cornerRadius = 3,
	        fillColor = { default={ 0, 0.45, 0.65, 1  }, over={ 0, 0.5, 0.7, 1 } },
	        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
	        font = native.systemFontBold
	    }
	    sceneGroup:insert( bexit )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then	
    	local mydata = require( "mydata" )
    	puntuacionNumero.text=mydata.score
    end
end

function scene:hide( event )
     local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Example: stop timers, stop animation, stop audio, etc.
        timer.cancel(tiempoEspera)
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    background:removeSelf()
    background=nil
    text:removeSelf()
    text=nil
    logo:removeSelf()
    logo=nil
    imagen:removeSelf()
    imagen=nil
    estrella:removeSelf()
    estrella=nil
    puntuacion:removeSelf()
    puntuacion=nil
    puntuacion2:removeSelf()
    puntuacion2=nil
    puntuacionNumero:removeSelf()
    puntuacionNumero=nil
    bexit:removeSelf()
    bexit=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
