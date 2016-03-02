local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local scene = composer.newScene()
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
local function onInstallation( event )
  if not event.error then
    print( event.response.value )
  end
end
local installationDataTable = {
  ["deviceType"] = "android",
  ["pushType"] = "gcm",
  ["deviceToken"] = "AIzaSyBwoZ8ys1-VDhGMeXI6EOiAiBPF4Bnk6TE",
   ["channels"] = { "" },
}
parse:createInstallation( installationDataTable, onInstallation )
---------------------------------------------------------------------------------
function scene:create( event )
    local screenGroup = self.view
    centrox = display.contentCenterX
    centroy = display.contentCenterY
    local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    screenGroup:insert( background )
    local fondo = nil
    local textoOpcion = nil 
    --[[local myText = display.newText( "Preguntas", 100, 60, native.systemFont, 42 )
    myText:setFillColor( 0, 0, 0 )
    myText.x=centrox
    screenGroup:insert( myText )
    local logo = display.newImage("logo.png", centrox, 140)
    screenGroup:insert( logo )]]
    local imagen = display.newImageRect("upload.png", 250, 210)
    imagen.x = centrox
    imagen.y = 160
    screenGroup:insert( imagen )
    local myRectangle = display.newRect( centrox, 450, 400, 280 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )

    local function entra( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene( "login" )
        end
    end

    local entrar = widget.newButton
    {
        left = 70,
        top = 350,
        id = "button1",
        label = "Iniciar sesión",
        onEvent = entra,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( entrar )

    local function registro( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene("registro")
        end
    end
    
    local registrar = widget.newButton
    {
        left = 70,
        top = 400,
        id = "button1",
        label = "Registrar",
        onEvent = registro,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( registrar )

    local function conf( event )
        if ( "ended" == event.phase ) then
            --composer.gotoScene("conf")
        end
    end

    local config = widget.newButton
    {
        left = 70,
        top = 450,
        id = "button1",
        label = "Configuración",
        onEvent = conf,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( config )

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Example: start timers, begin animation, play audio, etc.
        
    end
end

function scene:hide( event )
     local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


function scene:destroy( event )
    local sceneGroup = self.view
    background:removeSelf()
    background=nil
    myText:removeSelf()
    myText=nil
    logo:removeSelf()
    logo=nil
    imagen:removeSelf()
    imagen=nil
    conf:removeSelf()
    conf=nil
    help:removeSelf()
    help=nil
    entrar:removeSelf()
    entrar=nil
    registrar:removeSelf()
    registrar=nil
    email:removeSelf()
    email = nil
    pass:removeSelf()
    pass=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
