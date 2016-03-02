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
    local myRectangle = display.newRect( centrox, 245, 400, 700 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )
    local textlog = display.newText("Eventos", centrox, 40, native.systemFontBold, 40)
    textlog:setFillColor( 1, 1, 1 )
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
                local nombreEvento = display.newText("No tienes eventos", centrox, 130, native.systemFontBold, 30)
                    nombreEvento:setFillColor( 1, 1, 1 )
                    screenGroup:insert( nombreEvento )

            else
                eventoId = event.response.evento
                local participo = event.response.participo
                print(eventoId)
                local function onGetObjects( event )
                  if not event.error then
                    local cont = 0
                    --print( event.results[1].nombre )
                    local nombreEvento = display.newText(event.results[1].nombre, centrox, 85, native.systemFontBold, 30)
                    nombreEvento:setFillColor( 1, 1, 1 )
                    screenGroup:insert( nombreEvento )
                    local imagen = display.newImageRect("calendar1.png", 150, 150)
                    imagen.x = display.contentCenterX
                    imagen.y = display.contentCenterY-105
                    screenGroup:insert( imagen )
                    local stringFeIni=string.gsub(event.results[1].fecha_inicio.iso, "T", " Hora: ")
                    stringFeIni=string.gsub(stringFeIni, ".00.000Z", "")
                    print(stringFeIni)
                    local stringFeFin=string.gsub(event.results[1].fecha_fin.iso, "T", " Hora: ")
                    stringFeFin=string.gsub(stringFeFin, ".00.000Z", "")
                    --print(stringFeFin)
                    --print( date.year, date.month, date.day )  -- Print year and month
                    --print( date.hour, date.min ) 
                    local fechaIniTxt = display.newText("Inicio Evento:", centrox-45, 270, native.systemFontBold, 20)
                    fechaIniTxt:setFillColor( 1, 1, 1 )
                    screenGroup:insert( fechaIniTxt )
                    local fechaIni = display.newText(stringFeIni, centrox, 290, native.systemFontBold, 20)
                    fechaIni:setFillColor( 1, 1, 1 )
                    screenGroup:insert( fechaIni )
                    local fechaFinTxt = display.newText("Fin Evento:", centrox-55, 320, native.systemFontBold, 20)
                    fechaFinTxt:setFillColor( 1, 1, 1 )
                    screenGroup:insert( fechaFinTxt )
                    local fechaFin = display.newText(stringFeFin, centrox, 340, native.systemFontBold, 20)
                    fechaFin:setFillColor( 1, 1, 1 )
                    screenGroup:insert( fechaFin )
                    print(string.len(date.month))
                    local mes
                    local dia
                    if string.len(date.month)==1 then
                        mes="0"..date.month
                    else
                        mes=date.month
                    end
                    if string.len(date.day)==1 then
                        dia="0"..date.day
                    else
                        dia=date.day
                    end
                    print(stringFeIni)
                    print(date.year.."(-)"..mes.."(-)"..dia)
                    print(string.find(stringFeIni, date.year.."(-)"..mes.."(-)"..dia))
                    if string.find(stringFeIni, date.year.."(-)"..mes.."(-)"..dia)~=nil then
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
                        local mydata = require( "mydata" )
                            print(mydata.participo)
                            print(participo)
                            if(mydata.participo~=nil or participo~=false) then
                                
                                local function onComplete( event )
                           if event.action == "clicked" then
                                local i = event.index
                                if i == 1 then
                                  
                                end
                            end
                          end

                        local alert = native.showAlert( "Alerta!", "Ya has participado en este evento", { "OK" }, onComplete )
                            else
                            composer.removeScene( "seleccionCategoriaEvento")
                            composer.gotoScene("seleccionCategoriaEvento")
                        end
                            
                        end
                    end
                    local comenzar = widget.newButton
                    {
                        left = 70,
                        top = 370,
                        id = "button1",
                        label = "Comenzar",
                        onEvent = comen,
                        shape="roundedRect",
                        width = 180,
                        height = 40,
                        cornerRadius = 3,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
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
                        top = 420,
                        id = "button1",
                        label = "Puntuaciones",
                        onEvent = puntu,
                        shape="roundedRect",
                        width = 180,
                        height = 40,
                        cornerRadius = 3,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                    }
                    screenGroup:insert( puntuacion )

                    else
                        print("no estas a tiempo del evento")
                        local participantes = display.newText("Participantes: "..event.results[1].inscritos, centrox, 390, native.systemFontBold, 20)
                        participantes:setFillColor( 1, 1, 1 )
                        screenGroup:insert( participantes )
                        local capacidad = display.newText("Capacidad: "..event.results[1].capacidad, centrox, 420, native.systemFontBold, 20)
                        capacidad:setFillColor( 1, 1, 1 )
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
    local function regresar( event )
        if ( "ended" == event.phase ) then

        composer.removeScene("eventos")
        composer.gotoScene("menuSesion")
        end
    end

    button2 = widget.newButton
    {
    label = "button2",
    onEvent = regresar,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    font = native.systemFontBold
    }

-- Center the button
    button2.x = _W*0.5
    button2.y = 490

-- Change the button's label text
    button2:setLabel( "Volver")
    screenGroup:insert(button2)

    
    
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
