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
    background = display.newRect( display.contentCenterX, display.contentCenterY,display.contentWidth , display.contentHeight)
	background:setFillColor(1, 1, 1)
	sceneGroup:insert( background )
	imagens2 = display.newImageRect( "ruleta.png", 200, 200 )    
	imagens2.x = display.contentCenterX
	imagens2.y = display.contentCenterY+100 
	sceneGroup:insert( imagens2 )
	textGirar = display.newText("Toca para girar!", display.contentCenterX, 100, native.systemFont, 40)
	textGirar:setFillColor(0,0,0)
	sceneGroup:insert( textGirar )
	flecha = display.newImageRect("flecha.png", 55, 70)
	flecha.x = display.contentCenterX
	flecha.y = display.contentCenterY-20
	sceneGroup:insert( flecha )
	--pant
	pant = display.newRect( display.contentCenterX, display.contentCenterY,display.contentWidth , display.contentHeight)
	pant:setFillColor(0, 0, 0, 0.8)
	sceneGroup:insert( pant )
	pant.isVisible=false
	--textcategoria
	textcategoria = display.newText("", display.contentCenterX, 80, native.systemFont, 40)
	sceneGroup:insert( textcategoria )
	--sprite
		local options =
			    {
	        --required parameters
	        width = 150,
	        height = 150,
	        numFrames = 4,
	    }
   		local imageSheet = graphics.newImageSheet( "twitter-sprite.png", options )
   		local sequenceData =  
	    {
	        {
	            name="fly",
	            start=1,
	            count=4,
	            time=250,
	            loopCount = 0,    -- 0 – Infinite, >0  
	            loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	        }
	    } 
	    sprite =  display.newSprite( imageSheet, sequenceData )
	    sceneGroup:insert( sprite )
	    sprite:setSequence( "fly" )
	    sprite:play()
	    sprite.x=display.contentCenterX
	    sprite.y=display.contentCenterY
	    sprite.isVisible=false

		--jugar
		local function juega(event)
	    	if event.phase == "ended" then
	    		composer.removeScene( "jugarEvento")
	    		composer.gotoScene("jugarEvento")
	    	end
	    end

	    jugar = widget.newButton
        {
            left = 70,
            top = 480,
            label = "Jugar",
            onEvent = juega,
            shape="roundedRect",
            width = 180,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        sceneGroup:insert( jugar )
        jugar.isVisible=false
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
    	Runtime:removeEventListener( "enterFrame", doTurn )
		print(imagens2.rotation)
		presionado = false
        flecha.rotation = -7
		local reverse = 1
		local continua = false
		local function rockRect()
		    if ( reverse == 0 ) then
		        reverse = 1
		        transition.to( flecha, { rotation=-6, time=150, transition=easing.inOutCubic } )
		    else
		        reverse = 0
		        transition.to( flecha, { rotation=6, time=150, transition=easing.inOutCubic } )
		    end
		end

		local categoriaRand = ""


		function doTurn()

			if imagens2.rotation < random2 then
		    	imagens2.rotation = imagens2.rotation + 8
		    	continua=true
		    	presionado=true
		    	--print(imagens2.rotation)
			elseif imagens2.rotation >= random2 and continua == true then
				continua=false
				
				timer.pause( tiempoEspera )
				pant.isVisible=true
				textcategoria.text=categoriaRand
				local mydata = require( "mydata" )
		        mydata.categoria = categoriaRand
		        sprite.isVisible=true
		   		jugar.isVisible=true
			end
		end

		local function girar()
			print("dio tap a ruleta")
			local categorias = {"Arte", "Deportes", "Historia", "Geografía", "Cine", "Entretenimiento", "Música", "Ciencia"}
			if presionado == false then
				random = math.random(8)
				random2 = 1
				if random == 1 then
					random2=350
					categoriaRand=categorias[1]
				end
				if random == 2 then
					random2=450
					categoriaRand=categorias[2]
				end
				if random == 3 then
					random2=550
					categoriaRand=categorias[3]
				end
				if random == 4 then
					random2=650
					categoriaRand=categorias[4]
				end
				if random == 5 then
					random2=750
					categoriaRand=categorias[5]
				end
				if random == 6 then
					random2=750
					categoriaRand=categorias[6]
				end
				if random == 7 then
					random2=850
					categoriaRand=categorias[7]
				end
				if random == 8 then
					random2=950
					categoriaRand=categorias[8]
				end
				print(random)
				print(categoriaRand)

				continua=true

				tiempoEspera=timer.performWithDelay( 100, rockRect, 0 )

				Runtime:addEventListener( "enterFrame", doTurn )
			end
		end
		

		imagens2:addEventListener("tap", girar)

	end

	function scene:hide( event )
		local sceneGroup = self.view
	    local phase = event.phase

	    if ( phase == "will" ) then
	        -- Called when the scene is on screen (but is about to go off screen).
	        -- Insert code here to "pause" the scene.
	        -- Example: stop timers, stop animation, stop audio, etc.

	        sprite:pause()
	        timer.pause( tiempoEspera )
	    	Runtime:removeEventListener( "tap", girar )
	    	Runtime:removeEventListener( "enterFrame", doTurn )
	    	Runtime:removeEventListener( "enterFrame", rockRect )
	    elseif ( phase == "did" ) then
	        -- Called immediately after scene goes off screen.
	    end
	end

	function scene:destroy( event )
	    local sceneGroup = self.view
	    --background:removeSelf()
	    imagens2:removeSelf()
	    flecha:removeSelf()
	    pant:removeSelf()
	    --pant=nil
	    textcategoria:removeSelf()
	    --textcategoria=nil
	    sprite:removeSelf()
	    --sprite=nil
	    jugar:removeSelf()
	    --jugar=nil

	    end

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene