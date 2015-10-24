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
	local text = display.newImageRect("texto.png", 125, 35)
	text.x = centrox-(centrox/12)
	text.y = 50
	sceneGroup:insert( text )
	local logo = display.newImageRect("logo.png", 100, 35)
	logo.x = centrox+(centrox/1.5)
	logo.y = 50
	sceneGroup:insert( logo )
	local imagen = display.newImageRect("preguntados.png", 50, 50)
	imagen.x = centrox-(centrox/1.4)
	imagen.y = 50
	sceneGroup:insert( imagen )
	local puntuacion = display.newText("Felicidades", centrox, 150, native.systemFont, 40)
	puntuacion:setFillColor(0, 0, 0)
	sceneGroup:insert( puntuacion )
	local puntuacion2 = display.newText("tu puntuaje es de:", centrox, 210, native.systemFont, 35)
	puntuacion2:setFillColor(0, 0, 0)
	sceneGroup:insert( puntuacion2 )
	local estrella = display.newImageRect("estrella.png",160,160)
	estrella.x = centrox
	estrella.y = 330
	sceneGroup:insert( estrella )

	--local mydata = require( "mydata" )
	puntuacionNumero = display.newText("", centrox, 330, native.systemFont, 60)
	puntuacionNumero:setFillColor(0, 0, 0)
	sceneGroup:insert( puntuacionNumero )
	--mydata.score.text="0"
	

	 local function exit(event) 
	            if event.phase == "ended" then
	            	--puntuacionNumero.text=""
	            	local mydata = require( "mydata" )
	            	mydata.score=0
	                composer.gotoScene("menuSesion")

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
