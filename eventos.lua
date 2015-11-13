local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local widget = require( "widget" )
local date = os.date( "*t" )   
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
            if (event.response.evento=="") then
                print("No hay eventos")
                local nombreEvento = display.newText("No tienes eventos", centrox, 130, native.systemFont, 30)
                    nombreEvento:setFillColor( 0, 0, 0 )
                    screenGroup:insert( nombreEvento )
                    local function regre( event )
                        if ( "ended" == event.phase ) then
                            --composer.removeScene( "menuSesion")
                            composer.gotoScene("menuSesion")
                        end
                    end
                    local regresar = widget.newButton
                    {
                        left = 70,
                        top = 170,
                        id = "button1",
                        label = "Regresar",
                        onEvent = regre,
                        shape="roundedRect",
                        width = 180,
                        height = 40,
                        cornerRadius = 3,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    }
                    screenGroup:insert( regresar )
            else
                eventoId = event.response.evento
                local participo = event.response.participo
                print(eventoId)
                local function onGetObjects( event )
                  if not event.error then
                    local cont = 0
                    print( event.results[1].nombre )
                    local nombreEvento = display.newText(event.results[1].nombre, centrox, 130, native.systemFont, 30)
                    nombreEvento:setFillColor( 0, 0, 0 )
                    screenGroup:insert( nombreEvento )
                    local imagen = display.newImageRect("calendar1.png", 150, 150)
                    imagen.x = display.contentCenterX
                    imagen.y = display.contentCenterY-50
                    screenGroup:insert( imagen )
                    local stringFeIni=string.gsub(event.results[1].fecha_inicio.iso, "T", " Hora: ")
                    stringFeIni=string.gsub(stringFeIni, ".00.000Z", "")
                    print(stringFeIni)
                    local stringFeFin=string.gsub(event.results[1].fecha_fin.iso, "T", " Hora: ")
                    stringFeFin=string.gsub(stringFeFin, ".00.000Z", "")
                    print(stringFeFin)
                    print( date.year, date.month, date.day )  -- Print year and month
                    print( date.hour, date.min ) 
                    local fechaIniTxt = display.newText("Inicio Evento:", centrox-65, 320, native.systemFont, 20)
                    fechaIniTxt:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaIniTxt )
                    local fechaIni = display.newText(stringFeIni, centrox, 350, native.systemFont, 20)
                    fechaIni:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaIni )
                    local fechaFinTxt = display.newText("Fin Evento:", centrox-75, 380, native.systemFont, 20)
                    fechaFinTxt:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaFinTxt )
                    local fechaFin = display.newText(stringFeFin, centrox, 410, native.systemFont, 20)
                    fechaFin:setFillColor( 0, 0, 0 )
                    screenGroup:insert( fechaFin )
                    if string.find(stringFeIni, date.year.."(-)"..date.month.."(-)"..date.day.." Hora: ")~=nil then
                        print("estas en fecha")
                        for i=0,23 do
                            if i<=9 then
                                if string.find(stringFeIni, ": 0"..i, -7)~=nil then
                                    if date.hour>=i then
                                        print("mayor/igual que hora inicio")
                                        cont=cont+1
                                    else
                                        print("menor que hora inicio")
                                    end
                                end
                                if string.find(stringFeFin, ": 0"..i, -7)~=nil then
                                    if date.hour<i then
                                        print("menor que hora fin")
                                        cont=cont+1
                                    else
                                        print("mayor/igual que hora fin")
                                    end
                                end
                            else
                                if string.find(stringFeIni, ": "..i, -7)~=nil then
                                    if date.hour>=i then
                                        print("mayor/igual que hora inicio")
                                        cont=cont+1
                                    else
                                        print("menor que hora inicio")
                                    end
                                end
                                if string.find(stringFeFin, ": "..i, -7)~=nil then
                                    if date.hour<i then
                                        print("menor que hora fin")
                                        cont=cont+1
                                    else
                                        print("mayor/igual que hora fin")
                                    end
                                end
                            end
                        end

                        for i=0, 59 do --for para recorrer todos los minutos de la hora
                            if i<=9 then --if para aumentar un '0' a la izquierda a los numeros menores a 10
                                if string.find(stringFeIni, "0"..i, -2)~=nil then --if para buscar los minutos en el string 'stringFeIni'
                                    if date.min >= i then --si los minutos actuales son mayores o iguales a los minutos del evento
                                        print("mayor/igual que minutos inicio")
                                        cont=cont+1
                                    else
                                        print("menor que minutos inicio")
                                    end
                                end
                                if string.find(stringFeFin, "0"..i, -2)~=nil or cont==3 then
                                    if date.min <= i then
                                        print("menor/igual que minutos fin")
                                        cont=cont+1
                                    else
                                        print("mayor que minutos fin")
                                    end
                                end
                            else
                                if string.find(stringFeIni, i, -2)~=nil then --if para buscar los minutos en el string 'stringFeIni'
                                    if date.min >= i then --si los minutos actuales son mayores o iguales a los minutos del evento
                                        print("mayor/igual que minutos inicio")
                                        cont=cont+1
                                    else
                                        print("menor que minutos inicio")
                                    end
                                end
                                if string.find(stringFeFin, i, -2)~=nil or cont==3 then
                                    if date.min <= i then
                                        print("menor/igual que minutos fin")
                                        cont=cont+1
                                    else
                                        print("mayor que minutos fin")
                                    end
                                end
                            end
                        end
                        print("contador: "..cont)
                    end
                    if cont==4 then
                        print("estas en tiempo del evento")
                        local function comen( event )
                        if ( "ended" == event.phase ) then
                            if(participo~=true) then
                                composer.removeScene( "seleccionCategoriaEvento")
                                composer.gotoScene("seleccionCategoriaEvento")
                            else
                                local function onComplete( event )
                           if event.action == "clicked" then
                                local i = event.index
                                if i == 1 then
                                  
                                end
                            end
                          end
                        local alert = native.showAlert( "Alerta!", "Ya has participado en este evento", { "OK" }, onComplete )
                            end
                            
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
                            composer.gotoScene("puntuacionEvento")
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

                    else
                        print("no estas a tiempo del evento")
                        local participantes = display.newText("Participantes: "..event.results[1].inscritos, centrox, 450, native.systemFont, 20)
                        participantes:setFillColor( 0, 0, 0 )
                        screenGroup:insert( participantes )
                        local capacidad = display.newText("Capacidad: "..event.results[1].capacidad, centrox, 480, native.systemFont, 20)
                        capacidad:setFillColor( 0, 0, 0 )
                        screenGroup:insert( capacidad )
                    end
                   
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


--function scene:destroy( event )
--    local sceneGroup = self.view

--end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
