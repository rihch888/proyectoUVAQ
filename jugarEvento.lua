local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local scene = composer.newScene()
--
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
local puntuacionreal = 0
function scene:create( event )
local screenGroup = self.view

local fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
fondo.isVisible=false
local esperarImg = true

local loading = {}

--local mostrarBotones = {}
--local mostrarPregunta = {}
local mostrar  = {}



local res1
local res2
local res3




centrox = display.contentCenterX
centroy = display.contentCenterY
local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
background:setFillColor(1, 1, 1)
screenGroup:insert( background )

local myRectangle = display.newRect( centrox, 505, 400, 280 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )

local clock = display.newImageRect("clock3.png", 45, 45)
clock.x = centrox-(centrox*0.6)
clock.y=60
screenGroup:insert( clock )

local mydata = require( "mydata" )
print("VIDAS: "..mydata.lives)
if mydata.lives >= 1 then
    heart1 = display.newImageRect("heart.png", 25, 25)
    heart1.x = centrox*0.67
    heart1.y=60
    screenGroup:insert( heart1 )
end
if mydata.lives >= 2 then
    heart2 = display.newImageRect("heart.png", 25, 25)
    heart2.x = centrox*0.81
    heart2.y=60
    screenGroup:insert( heart2 )
end
if mydata.lives >= 3 then
    heart3 = display.newImageRect("heart.png", 25, 25)
    heart3.x = centrox*0.96
    heart3.y=60
    screenGroup:insert( heart3 )
end
if mydata.lives >= 4 then
    heart4 = display.newImageRect("heart.png", 25, 25)
    heart4.x = centrox*1.09
    heart4.y=60
    screenGroup:insert( heart4 )
end
if mydata.lives == 5 then
    heart5 = display.newImageRect("heart.png", 25, 25)
    heart5.x = centrox*1.23
    heart5.y=60
    screenGroup:insert( heart5 )
end

local roundedRect = display.newRoundedRect( centrox+(centrox/1.5), 60, 70, 32, 12 )
roundedRect.strokeWidth = 5
roundedRect:setFillColor( 1, 1, 1 )
roundedRect:setStrokeColor( 0, 0.7, 0 )
screenGroup:insert( roundedRect )

local acierto = display.newImageRect("paloma.png", 30, 30)
acierto.x = centrox+(centrox/1.7)
acierto.y=60
screenGroup:insert( acierto )

--local puntuacion = display.newText("Aciertos:", centrox+(centrox/1.8), 60, native.systemFont, 20)
--puntuacion:setFillColor(0, 0, 0)
local mydata = require( "mydata" )
--screenGroup:insert( puntuacion )
local puntuacionNum = display.newText(mydata.score, centrox+(centrox/1.3), 60, native.systemFont, 20)
puntuacionNum:setFillColor(0, 0, 0)
screenGroup:insert( puntuacionNum )
botonAudioActivo=false
function exit(event) 
    if event.phase == "ended" then
        local mydata = require( "mydata" )
        mydata.lives=5
        local function onGetMe( event )
            if event.code == parse.EXPIRED then
                --expiró la sesion
            else
                local user_object_id=event.response.objectId
                local participo = event.response.participo
                local eventoId=event.response.evento
                if mydata.score~=0 then
                    parse:createObject("Score", {["score"] = mydata.score, ["evento"] = eventoId}, function(e) 
                        if not e.error then
                            local score_object_id = e.response.objectId
                            parse:linkObject("Score", score_object_id, "player", parse.USER_CLASS, user_object_id, function(e)
                                if not e.error then
                                    print("score!")
                                    --mydata.participo=1
                                    local dataTable = { ["participo"] = true }
                                    parse:updateUser( user_object_id, dataTable, onUpdateUser )
                                    composer.removeScene( "scoreEvento")
                                    composer.gotoScene("scoreEvento")
                                    local function onUpdateUser( event )
                                     if not event.error then
                                        print( event.response.updatedAt )
                                     end
                                    end
                                    

                                 end
                            end)
                        end
                    end)
                end
                print("score!")
                puntuacionreal=0
                puntuacionNum.text=0
                --composer.gotoScene("score")
            end
        end
        parse:getMe( onGetMe )
        
    end
end

        bexit = widget.newButton
        {
            left = 160,
            top = 530,
            id = "bexit",
            label = "Salir",
            onEvent = exit,
            shape="roundedRect",
            width = 100,
            height = 35,
            cornerRadius = 3,
            fillColor = { default={ 1, 0, 0, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
            font = native.systemFontBold
        }
        screenGroup:insert( bexit )
------------------------------------
function siguiente (event)
    if ( "ended" == event.phase ) then
        composer.removeScene( "seleccionCategoriaEvento")
        composer.gotoScene("seleccionCategoriaEvento")
    end
end
-------------------------------------
--local queryTable = { }
--parse:getObjects( "preguntas", queryTable, onGetObjects )

 



local myRoundedRect = display.newRoundedRect( centrox, 120, 200, 40, 12 )
myRoundedRect.strokeWidth = 10
myRoundedRect:setFillColor( 1, 1 ,1 )
myRoundedRect:setStrokeColor( 0, 0.5, 0.7 )
screenGroup:insert( myRoundedRect )


local mydata = require( "mydata" )
local categoria = mydata.categoria
local nombreCategoria = display.newText(categoria, centrox, 120, native.systemFontBold, 18)
nombreCategoria:setFillColor(0,0,0)
screenGroup:insert( nombreCategoria )

 function boton1(event) 
            if event.phase == "ended" then
            
                --print("Res1 "..res1.." correcta "..correcta)
                displayTime.isVisible=false
                --progressView:removeSelf()
                Runtime:removeEventListener("enterFrame", checkTime)
                if res1 == correcta then
                    local mydata = require( "mydata" )
                    mydata.score = mydata.score+1
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    palomita = display.newImageRect("paloma.png",60,60)
                    palomita.x = centrox
                    palomita.y = 200
                    screenGroup:insert( palomita )
                    correcto = display.newText("Correcto", centrox, 130, native.systemFont, 38)
                    screenGroup:insert( correcto )
                    continuar = widget.newButton
                    {
                    left = 85,
                    top = 270,
                    label = "Continuar",
                    onEvent = siguiente,
                    shape="roundedRect",
                    width = 150,
                    height = 40,
                    cornerRadius = 10,
                    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    font = native.systemFontBold
                    }
                    screenGroup:insert( continuar )
                else
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    local mydata = require( "mydata" )
                    mydata.lives=mydata.lives-1 
                    if mydata.lives == 0 then
                        local mydata = require( "mydata" )
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )
                        acaba2 = display.newText("Oportunidades", centrox, 100, native.systemFont, 38)
                        screenGroup:insert( acaba2 )
                        acaba3 = display.newText("Agotadas!", centrox, 150, native.systemFont, 38)
                        screenGroup:insert( acaba3 )
                        sad = display.newImageRect("sad.png",150,150)
                        sad.x = centrox
                        sad.y = 270
                        screenGroup:insert( sad )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 370,
                        label = "Continuar",
                        onEvent = exit,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    else
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )                 
                        tache = display.newImageRect("tache.png",60,60)
                        tache.x = centrox
                        tache.y = 200
                        screenGroup:insert( tache )
                        incorrecto = display.newText("Incorrecto", centrox, 130, native.systemFont, 38)
                        screenGroup:insert( incorrecto )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 270,
                        label = "Continuar",
                        onEvent = siguiente,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    end
                end
            end
        end

       

        function boton2(event) 
            if event.phase == "ended" then

                Runtime:removeEventListener("enterFrame", checkTime)
                if res2 == correcta then
                    local mydata = require( "mydata" )
                    mydata.score = mydata.score+1
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    palomita = display.newImageRect("paloma.png",60,60)
                    palomita.x = centrox
                    palomita.y = 200
                    screenGroup:insert( palomita )
                    correcto = display.newText("Correcto", centrox, 130, native.systemFont, 38)
                    screenGroup:insert( correcto )
                    continuar = widget.newButton
                    {
                    left = 85,
                    top = 270,
                    label = "Continuar",
                    onEvent = siguiente,
                    shape="roundedRect",
                    width = 150,
                    height = 40,
                    cornerRadius = 10,
                    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    font = native.systemFontBold
                    }
                    screenGroup:insert( continuar )
                else
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    local mydata = require( "mydata" )
                    mydata.lives=mydata.lives-1 
                    if mydata.lives == 0 then
                        local mydata = require( "mydata" )
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )
                        acaba2 = display.newText("Oportunidades", centrox, 100, native.systemFont, 38)
                        screenGroup:insert( acaba2 )
                        acaba3 = display.newText("Agotadas!", centrox, 150, native.systemFont, 38)
                        screenGroup:insert( acaba3 )
                        sad = display.newImageRect("sad.png",150,150)
                        sad.x = centrox
                        sad.y = 270
                        screenGroup:insert( sad )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 370,
                        label = "Continuar",
                        onEvent = exit,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    else
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )
                        tache = display.newImageRect("tache.png",60,60)
                        tache.x = centrox
                        tache.y = 200
                        screenGroup:insert( tache )
                        incorrecto = display.newText("Incorrecto", centrox, 130, native.systemFont, 38)
                        screenGroup:insert( incorrecto )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 270,
                        label = "Continuar",
                        onEvent = siguiente,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    end
                end
            end
        end




        function boton3(event) 
            if event.phase == "ended" then
                
                Runtime:removeEventListener("enterFrame", checkTime)
                if res3 == correcta then
                    local mydata = require( "mydata" )
                    mydata.score = mydata.score+1
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    palomita = display.newImageRect("paloma.png",60,60)
                    palomita.x = centrox
                    palomita.y = 200
                    screenGroup:insert( palomita )
                    correcto = display.newText("Correcto", centrox, 130, native.systemFont, 38)
                    screenGroup:insert( correcto )
                    continuar = widget.newButton
                    {
                    left = 85,
                    top = 270,
                    label = "Continuar",
                    onEvent = siguiente,
                    shape="roundedRect",
                    width = 150,
                    height = 40,
                    cornerRadius = 10,
                    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    font = native.systemFontBold
                    }
                    screenGroup:insert( continuar )
                else
                    b1:setEnabled( false )
                    b2:setEnabled( false )
                    b3:setEnabled( false )
                    bexit:setEnabled( false )
                    if botonAudioActivo == true then
                        play:removeEventListener("tap", playAudio)
                    end
                    local mydata = require( "mydata" )
                    mydata.lives=mydata.lives-1
                    if mydata.lives == 0 then
                        local mydata = require( "mydata" )
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )
                        aacaba2 = display.newText("Oportunidades", centrox, 100, native.systemFont, 38)
                        screenGroup:insert( acaba2 )
                        acaba3 = display.newText("Agotadas!", centrox, 150, native.systemFont, 38)
                        screenGroup:insert( acaba3 )
                        sad = display.newImageRect("sad.png",150,150)
                        sad.x = centrox
                        sad.y = 270
                        screenGroup:insert( sad )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 370,
                        label = "Continuar",
                        onEvent = exit,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    else
                        pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                        pant:setFillColor(0, 0, 0, 0.9)
                        screenGroup:insert( pant )     
                        tache = display.newImageRect("tache.png",60,60)
                        tache.x = centrox
                        tache.y = 200
                        screenGroup:insert( tache )
                        incorrecto = display.newText("Incorrecto", centrox, 130, native.systemFont, 38)
                        screenGroup:insert( incorrecto )
                        continuar = widget.newButton
                        {
                        left = 85,
                        top = 270,
                        label = "Continuar",
                        onEvent = siguiente,
                        shape="roundedRect",
                        width = 150,
                        height = 40,
                        cornerRadius = 10,
                        fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                        font = native.systemFontBold
                        }
                        screenGroup:insert( continuar )
                    end
                end
            end
        end

function mostrarBotones( )
        print(">>>entro en mostrarBotones<<<")

         b1 = widget.newButton
        {
            left = 60,
            top = 380,
            id = "button1",
            --label = res1,
            onEvent = boton1,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
            font = native.systemFontBold
        }
        screenGroup:insert( b1 )

        ----------------------------------------------------------------------------
        local line = res1

            local tam=string.len(line)
            --print(tam)
            if tam>17 then
                local nextChar = string.sub(line, 18, 18) 
                local nextString = string.sub(line, 18)
                if nextChar == " " then
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b1:setLabel(newLine)

                else
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "-\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b1:setLabel(newLine)
                end
            else
                print("menor o igual a 17")
                b1:setLabel(line)
            end
        ----------------------------------------------------------------------------

        b2 = widget.newButton
        {
            left = 60,
            top = 430,
            id = "button2",
            --label = res2,
            onEvent = boton2,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
            font = native.systemFontBold
        }
        screenGroup:insert( b2 )

        ----------------------------------------------------------------------------
        local line = res2

            local tam=string.len(line)
            --print(tam)
            if tam>17 then
                local nextChar = string.sub(line, 18, 18) 
                local nextString = string.sub(line, 18)
                if nextChar == " " then
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b2:setLabel(newLine)

                else
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "-\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b2:setLabel(newLine)
                end
            else
                print("menor o igual a 17")
                b2:setLabel(line)
            end
        ----------------------------------------------------------------------------

         b3 = widget.newButton
        {
            left = 60,
            top = 480,
            id = "button1",
            --label = res3,
            onEvent = boton3,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
            font = native.systemFontBold
        }
        screenGroup:insert( b3 )

                ----------------------------------------------------------------------------
        local line = res3

            local tam=string.len(line)
            --print(tam)
            if tam>17 then
                local nextChar = string.sub(line, 18, 18) 
                local nextString = string.sub(line, 18)
                if nextChar == " " then
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b3:setLabel(newLine)

                else
                    local longNextString = string.len(nextString)
                    local space = "              "
                    space = string.sub(space, longNextString)
                    local newNextString = "-\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    b3:setLabel(newLine)
                end
            else
                print("menor o igual a 17")
                b3:setLabel(line)
            end
        ----------------------------------------------------------------------------

end

local function mostrarPregunta(event)
    fondo:removeSelf()
    fondo = nil
    textoGuardar:removeSelf()
    mostrarBotones()
    Runtime:addEventListener("enterFrame",checkTime)
end

function mostrar(event)
    print("!!!!!!!!!!!!!")
    mostrarBotones()
    Runtime:addEventListener("enterFrame",checkTime)
end

function loading(event)
    Runtime:removeEventListener("enterFrame", checkTime)
     --fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
     fondo.isVisible=true
                fondo:setFillColor(0,0.6,0.7)
                --fondo.alpha=0.8
                screenGroup:insert(fondo)
                

                local opcionesTexto2 = {
                    text ="Cargando...", 
                    font = native.systemFontBold, 
                    fontSize =40,
                    x=  _W*0.5,
                    y=  _H*0.45
                }

                textoGuardar = display.newText(opcionesTexto2)
                textoGuardar:setTextColor( 1, 1, 1 )
                screenGroup:insert(textoGuardar)
                
end



loading()

--local res1
--local res2
--local res3

local function onGetObjects( event )
    if not event.error then

        local mydata = require( "mydata" )
        print("-------------------------")
        print("Score: "..mydata.score)
        print("-------------------------")
        print( #event.results )
        local num = math.random(#event.results)
        print(num)
        print(event.results[num].pregunta)
        local rand1 = math.random(3)
        local rand2 = math.random(3)
        local rand3 = math.random(3)
        while rand1==rand2 or rand2==rand3 or rand1 == rand3 do
            rand1 = math.random(3)
            rand2 = math.random(3)
            rand3 = math.random(3)
        end
        botonAudioActivo=false
     
        print("Random1: "..rand1.." Random2: "..rand2.." Random3: "..rand3)
        --local res1, res2, res3
        if rand1 == 1 then
            res1 = event.results[num].respuesta1
            print(event.results[num].respuesta1.." <<<<<<<<")
        elseif rand1 == 2 then
            res1 = event.results[num].respuesta2
        elseif rand1 == 3 then
            res1 = event.results[num].respuesta3
        end
     
        if rand2 == 1 then
            res2 = event.results[num].respuesta1
             print(event.results[num].respuesta1.." ++++++++++")
        elseif rand2 == 2 then
            res2 = event.results[num].respuesta2
        elseif rand2 == 3 then
            res2 = event.results[num].respuesta3
        end
     
        if rand3 == 1 then
            res3 = event.results[num].respuesta1
             print(event.results[num].respuesta1.." ==========")
        elseif rand3 == 2 then
            res3 = event.results[num].respuesta2
        elseif rand3 == 3 then
            res3 = event.results[num].respuesta3
        end
     
        correcta = event.results[num].correcta

        if event.results[num].archivo~=nil then
            -----------------------------------------------------------------
            local line = event.results[num].pregunta

            local tam=string.len(line)
            --print(tam)
            if tam>22 then
                local nextChar = string.sub(line, 23, 23) 
                local nextString = string.sub(line, 23)
                if nextChar == " " then
                    local longNextString = string.len(nextString)
                    local space = "                  "
                    space = string.sub(space, longNextString)
                    local newNextString = "\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    pregunta = display.newText(newLine, centrox, 180, native.systemFont, 18)
                    
                    --código para centrar el texto de aba
                    --ejemplo arqui pregunta
                else
                    local longNextString = string.len(nextString)
                    local space = "                  "
                    space = string.sub(space, longNextString)
                    local newNextString = "-\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    pregunta = display.newText(newLine, centrox, 180, native.systemFont, 18)
                end
            else
                print("menor o igual a 17")
                pregunta = display.newText(line, centrox, 180, native.systemFont, 18)
            end
            -----------------------------------------------------------------

            --pregunta = display.newText(event.results[num].pregunta, centrox, 185, native.systemFont, 18)
            pregunta:setFillColor(0,0,0)
            screenGroup:insert(pregunta)
            local url = event.results[num].archivo.url
            local name = event.results[num].archivo.name
            function GetFileExtension(url)
                local str = url
                    local temp = ""
                    local result = "." 

                    for i = str:len(), 1, -1 do
                        if str:sub(i,i) ~= "." then
                            temp = temp..str:sub(i,i)
                        else
                        break
                        end
                    end
                    for j = temp:len(), 1, -1 do
                        result = result..temp:sub(j,j)
                    end
                return result
            end
            local ext=GetFileExtension(name)
            local function onImagen(event)
                imagen = event.target
                imagen.x=centrox
                imagen.y=centroy-10
                imagen.width=175
                imagen.height=150
                screenGroup:insert( imagen )
                
                mostrarPregunta()    
                --mostrar()       
                
            end

            if ext==".png" or ext==".jpg" or ext==".jpeg" then
                display.loadRemoteImage(url,"GET", onImagen, name)
              
            elseif ext==".wav" or ext==".mp3" then
                print("sonido: "..num)
                local function networkListener( event )
                    if ( event.phase == "ended" ) then
                        print( "Entra correctamente!!!" )
                        sound = audio.loadSound(event.response.filename, system.TemporaryDirectory )

                        
                    end
                end

                local params = {}
                params.progress = true

                network.download(url,"GET",networkListener,params,name,system.TemporaryDirectory)

                play = display.newImageRect("play.png", 70, 70)
                play.x=centrox
                play.y=centroy
                screenGroup:insert( play )
                botonAudioActivo=true
                --mostrarPregunta()
                function playAudio()
                    audio.play( sound )

                    --media.playSound( "audio.wav", system.TemporaryDirectory )
                end
                play:addEventListener("tap", playAudio)
                
            end
        else
            ----------------------------------------------------------------------
            local line = event.results[num].pregunta

            local tam=string.len(line)
            --print(tam)
            if tam>25 then
                local nextChar = string.sub(line, 26, 26) 
                local nextString = string.sub(line, 26)
                if nextChar == " " then
                    local longNextString = string.len(nextString)
                    local space = "                  "
                    space = string.sub(space, longNextString)
                    local newNextString = "\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    pregunta = display.newText(newLine, centrox, 250, native.systemFont, 23)
                    
                    --código para centrar el texto de aba

                else
                    local longNextString = string.len(nextString)
                    local space = "                  "
                    space = string.sub(space, longNextString)
                    local newNextString = "-\n"..space..nextString-- "\n de Quiroga"
                    local newLine = string.gsub(line, nextString, newNextString)
                    pregunta = display.newText(newLine, centrox, 250, native.systemFont, 23)
                end
            else
                print("menor o igual a 17")
                pregunta = display.newText(line, centrox, 250, native.systemFont, 23)
            end
            ----------------------------------------------------------------------

            --pregunta = display.newText(event.results[num].pregunta, centrox, 260, native.systemFont, 18)
            pregunta:setFillColor(0,0,0)
            screenGroup:insert(pregunta)
            print(">>>pregunta SOLO TEXTO<<<")
            mostrarPregunta()
            --mostrar()

        end
    end
end
local mydata = require( "mydata" )
local categoria = mydata.categoria
local queryTable = { 
    ["where"] = { ["categoria"] = categoria }
}
parse:getObjects( "preguntas", queryTable, onGetObjects )
    
function onKeyEvent(event)
    if ( event.keyName == "back" and event.phase == "up") then
        composer.gotoScene("eventos")
        return true
    end
    return false
end
Runtime:addEventListener( "key", onKeyEvent )
    
end

function scene:show( event )
    local screenGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Example: start timers, begin animation, play audio, etc.
        local startTime = os.time()
        local levelTime = 10-- modificacion
        displayTime = display.newText(levelTime, centrox-(centrox/1.68), 62, native.systemFont, 20)
        displayTime:setFillColor(0, 0, 0)
        screenGroup:insert( displayTime )
        local acabo = false
        function checkTime(event)
            now=0
            if acabo == false then
                now = os.time()
            else
                now =0
            end
            displayTime.text = levelTime - (now - startTime)
            --progressView:setProgress( (now-startTime)/15 )
            if ( now > startTime + levelTime ) then
                b1:setEnabled( false )
                b2:setEnabled( false )
                b3:setEnabled( false )
                bexit:setEnabled( false )
                if botonAudioActivo == true then
                    play:removeEventListener("tap", playAudio)
                end
                local mydata = require( "mydata" )
                mydata.lives=mydata.lives-1 
                if mydata.lives <= 0 then
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
                    acaba2 = display.newText("Oportunidades", centrox, 100, native.systemFont, 38)
                    screenGroup:insert( acaba2 )
                    acaba3 = display.newText("Agotadas!", centrox, 150, native.systemFont, 38)
                    screenGroup:insert( acaba3 )
                    sad = display.newImageRect("sad.png",150,150)
                    sad.x = centrox
                    sad.y = 270
                    screenGroup:insert( sad )
                    continuar = widget.newButton
                    {
                    left = 85,
                    top = 370,
                    label = "Continuar",
                    onEvent = exit,
                    shape="roundedRect",
                    width = 150,
                    height = 40,
                    cornerRadius = 10,
                    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    font = native.systemFontBold
                    }
                    screenGroup:insert( continuar )
                    Runtime:removeEventListener("enterFrame", checkTime)
                else
                    acabo = true
                    displayTime.isVisible=false
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )     
                    reloj = display.newImageRect("time.png",150,150)
                    reloj.x = centrox
                    reloj.y = 250
                    screenGroup:insert( reloj )
                    acaba = display.newText("Tiempo agotado!", centrox, 130, native.systemFont, 38)
                    screenGroup:insert( acaba )
                    continuar = widget.newButton
                    {
                    left = 85,
                    top = 370,
                    label = "Continuar",
                    onEvent = siguiente,
                    shape="roundedRect",
                    width = 150,
                    height = 40,
                    cornerRadius = 10,
                    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
                    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                    font = native.systemFontBold
                    }
                    screenGroup:insert( continuar )
                    Runtime:removeEventListener("enterFrame", checkTime)
                end
            end
        end
        --Runtime:addEventListener("enterFrame", checkTime)
        ---------------------

    end
end

function scene:hide( event )
     local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        timer.cancel(tiempoEspera)
        Runtime:removeEventListener("enterFrame", checkTime)
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


function scene:destroy( event )
    local sceneGroup = self.view
    background:removeSelf()
    
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene