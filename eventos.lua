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
    local screenGroup = self.view
    centrox = display.contentCenterX
    centroy = display.contentCenterY
    local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    screenGroup:insert( background )
    local textlog = display.newText("Eventos", centrox, 60, native.systemFont, 40)
    textlog:setFillColor( 0, 0, 0 )
    screenGroup:insert( textlog )

-------------------------------------------------------------------------------------------
    --local function onLoginUser( event )
    --if not event.error then
        --print( event.response.sessionToken )
        --print(event.response.username)
        local function onGetMe( event )
           if event.code == parse.EXPIRED then
            print("No hay sesion")
           else
            if (event.response.evento==nil) then
                print("No hay eventos")
            else
                print("Si hay eventos")
                eventoId = event.response.evento
                print(eventoId)
                local function onGetObjects( event )
                  if not event.error then
                    print( event.results[1].nombre )
                    local nombreEvento = display.newText(event.results[1].nombre, centrox, 130, native.systemFont, 30)
                    nombreEvento:setFillColor( 0, 0, 0 )
                    screenGroup:insert( nombreEvento )
                    local imagen = display.newImageRect("calendar1.png", 150, 150)
                    imagen.x = display.contentCenterX
                    imagen.y = display.contentCenterY-50
                    screenGroup:insert( imagen )
                    local fechaIniTxt = display.newText("Inicio Evento:", centrox-65, 320, native.systemFont, 20)
                    fechaIniTxt:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaIniTxt )
                    local fechaIni = display.newText(event.results[1].fecha_inicio.iso, centrox, 350, native.systemFont, 20)
                    fechaIni:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaIni )
                    local fechaFinTxt = display.newText("Fin Evento:", centrox-75, 380, native.systemFont, 20)
                    fechaFinTxt:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaFinTxt )
                    local fechaFin = display.newText(event.results[1].fecha_fin.iso, centrox, 410, native.systemFont, 20)
                    fechaFin:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaFin )
                    
                    local function comen( event )
                        if ( "ended" == event.phase ) then
                            --composer.gotoScene("jugarEvento")
                        end
                    end
    
                    local comenzar = widget.newButton
                    {
                        left = 70,
                        top = 440,
                        id = "button1",
                        label = "Comenzar",
                        onEvent = comen,
                        shape="roundedRect",
                        width = 180,
                        height = 40,
                        cornerRadius = 3,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    }
                    screenGroup:insert( comenzar )
                    local function puntu( event )
                        if ( "ended" == event.phase ) then
                            --composer.gotoScene("puntuacionEvento")
                        end
                    end
    
                    local puntuacion = widget.newButton
                    {
                        left = 70,
                        top = 490,
                        id = "button1",
                        label = "Puntuaciones",
                        onEvent = puntu,
                        shape="roundedRect",
                        width = 180,
                        height = 40,
                        cornerRadius = 3,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    }
                    screenGroup:insert( puntuacion )
                  end
                end
                local queryTable = { 
                  ["where"] = { ["objectId"] = eventoId }
                }
                parse:getObjects( "eventos", queryTable, onGetObjects )
            end
        end
     end
     parse:getMe( onGetMe )

    --end
    --end
    --parse:loginUser( { ["username"] = "rihch888@gmail.com", ["password"] = "licuadora" }, onLoginUser )
-------------------------------------------------------------------------------------------


    
    
    function onKeyEvent(event)---NOT WORK
    if ( event.keyName == "back" and event.phase == "up") then
        composer.gotoScene("menuSesion")
        return true
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
    textlog:removeSelf()
    nombreEvento:removeSelf()
    imagen:removeSelf()
    fechaIni:removeSelf()
    fechaFin:removeSelf()
    fechaIniTxt:removeSelf()
    fechaFinTxt:removeSelf()
    comenzar:removeSelf()
    puntuacion:removeSelf()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
