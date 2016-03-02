local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local widget = require( "widget" )
local facebook = require( "facebook" )
local json = require( "json" )
local scene = composer.newScene()
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
function scene:create( event )
    local screenGroup = self.view
    local centrox = display.contentCenterX
    local centroy = display.contentCenterY
    local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    screenGroup:insert( background )

    --[[local myRectangle = display.newRect( centrox, 60, 400, 170 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )]]
    local myRectangle = display.newRect( centrox, 395, 400, 500 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )

    local imagen = display.newImageRect("upload.png", 210, 170)
    imagen.x = centrox
    imagen.y = 135
    screenGroup:insert( imagen )
    --[[local textperf = display.newText("Perfil de", centrox, 200, native.systemFontBold, 30)
    textperf:setFillColor( 1, 1, 1 )
    screenGroup:insert( textperf )]]

    

    
    local function juega( event )
        if ( "ended" == event.phase ) then
            composer.removeScene( "seleccionCategoria")
            composer.gotoScene("seleccionCategoria")
        end
    end
    
    local jugar = widget.newButton
    {
        left = 70,
        top = 290,
        id = "jugar",
        label = "Jugar",
        onEvent = juega,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( jugar )
    
        local function eve( event )
            if ( "ended" == event.phase ) then
                composer.gotoScene("eventos")
            end
        end

        local eventos = widget.newButton
    {
        left = 70,
        top = 390,
        id = "button1",
        label = "Eventos",
        onEvent = eve,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( eventos )

    local function perf( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene("perfil")
        end
    end
    
    local perfil = widget.newButton
    {
        left = 70,
        top = 340,
        id = "perf",
        label = "Perfil",
        onEvent = perf,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }
    screenGroup:insert( perfil )
    local function ayu( event )
        if ( "ended" == event.phase ) then
            composer.gotoScene("puntuacion")
        end
    end
    
    local punt = widget.newButton
    {
        left = 70,
        top = 440,
        id = "button1",
        label = "Puntuación",
        onEvent = ayu,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }

    screenGroup:insert( punt )

    local function sal( event )
        if ( "ended" == event.phase ) then
            local function onComplete( event )
           if event.action == "clicked" then
                local i = event.index
                if i == 1 then
                  --Parse.USER.logOut();
                  --parse.logOut();
                  --parse:clearSessionToken()
                  composer.gotoScene("menuInicio")
                elseif i == 2 then

                end
            end
        end

        local alert = native.showAlert( "Alerta!", "Seguro que deseas cerrar sesión?", { "Si", "No" }, onComplete )
        end
    end
    
    local salir = widget.newButton
    {
        left = 70,
        top = 490,
        id = "button1",
        label = "Salir",
        onEvent = sal,
        shape="roundedRect",
        width = 180,
        height = 40,
        cornerRadius = 3,
        fillColor = { default={ 0.8, 0, 0, 1 }, over={ 1, 0, 0, 1 }},
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        font = native.systemFontBold
    }

    screenGroup:insert( salir )

     local function onGetMe( event )
       if event.code == parse.EXPIRED then
         local textlog = display.newText("Expiro la session ", centrox, 90, native.systemFont, 30)
         textlog:setFillColor( 0, 0, 0 )
         screenGroup:insert( textlog )
       else
         local textperf2 = display.newText(event.response.nombre, centrox, 235, native.systemFontBold, 30)
         textperf2:setFillColor( 1, 1, 1 )
         screenGroup:insert( textperf2 )
         local textperf3 = display.newText(event.response.email, centrox, 265, native.systemFontBold, 20)
         textperf3:setFillColor( 1, 1, 1 )
         screenGroup:insert( textperf3 )
       end
     end
     parse:getMe( onGetMe )

     local function onKeyEvent( event )
    if ( event.keyName == "back" and event.phase == "up") then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            native.setKeyboardFocus(nil)
        local function onComplete( event )
           if event.action == "clicked" then
                local i = event.index
                if i == 1 then
                  composer.gotoScene("menuInicio")
                elseif i == 2 then

                end
            end
        end

        local alert = native.showAlert( "Alerta!", "Seguro que deseas cerrar sesión?", { "Si", "No" }, onComplete )
            return true
        end
    end
    return false
end
Runtime:addEventListener( "key", onKeyEvent )
     
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

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

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
