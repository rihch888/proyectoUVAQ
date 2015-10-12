local composer = require( "composer" )
local widget = require( "widget" )
local parse = require( "mod_parse" )
local widget = require( "widget" )
local scene = composer.newScene()
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
local puntuacionreal = 0
function scene:create( event )
local screenGroup = self.view
centrox = display.contentCenterX
centroy = display.contentCenterY
local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
background:setFillColor(1, 1, 1)
screenGroup:insert( background )
local text = display.newImageRect("texto.png", 125, 35)
text.x = centrox-(centrox/12)
text.y = 30
screenGroup:insert( text )
local logo = display.newImageRect("logo.png", 100, 35)
logo.x = centrox+(centrox/1.5)
logo.y = 30
screenGroup:insert( logo )
imagens = display.newImageRect("preguntados.png", 50, 50)
imagens.x = centrox-(centrox/1.4)
imagens.y = 30
screenGroup:insert( imagens )
--
local estrella = display.newImageRect("estrella.png",60,60)
estrella.x = centrox-(centrox/2)
estrella.y = 80
screenGroup:insert( estrella )
local puntuacion = display.newText("Aciertos:", centrox+(centrox/4), 80, native.systemFont, 20)
puntuacion:setFillColor(0, 0, 0)
screenGroup:insert( puntuacion )
local puntuacionNum = display.newText("0", centrox+(centrox/1.8), 80, native.systemFont, 20)
puntuacionNum:setFillColor(0, 0, 0)
screenGroup:insert( puntuacionNum )
--[[progressView = widget.newProgressView
{
    left = 50,
    top = 100,
    width = 220,
    height = 50,
    isAnimated = false
}
screenGroup:insert( progressView )
--]]

local function exit(event) 
    if event.phase == "ended" then
        local mydata = require( "mydata" )
        mydata.score = puntuacionreal
        
        local function onGetMe( event )
            if event.code == parse.EXPIRED then
                --expiró la sesion
            else
                local user_object_id=event.response.objectId
                if mydata.score~=0 then
                    parse:createObject("Score", {["score"] = mydata.score}, function(e) 
                        if not e.error then
                            local score_object_id = e.response.objectId
                            parse:linkObject("Score", score_object_id, "player", parse.USER_CLASS, user_object_id, function(e)
                                if not e.error then
                                    print("score!")
                                    puntuacionreal=0
                                    puntuacionNum.text=0
                                    composer.gotoScene("score")
                                 end
                            end)
                        end
                    end)
                end
                print("score!")
                puntuacionreal=0
                puntuacionNum.text=0
                composer.gotoScene("score")
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
            label = "Terminar",
            onEvent = exit,
            shape="roundedRect",
            width = 100,
            height = 35,
            cornerRadius = 3,
            fillColor = { default={ 1, 0, 0, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( bexit )

local function siguiente (event)
    if ( "ended" == event.phase ) then
        if correcto ~= nil then
            correcto:removeSelf()
            correcto=nil
        end
        if incorrecto ~= nil then
            incorrecto:removeSelf()
            incorrecto=nil
        end
        pant:removeSelf()
        pant=nil
        if palomita ~= nil then
            palomita:removeSelf()
            palomita=nil
        end
        continuar:removeSelf()
        continuar=nil
        if tache ~= nil then
            tache:removeSelf()
            tache=nil
        end
        if b1 ~= nil then
            b1:removeSelf()
            b1=nil
        end
        if b2 ~= nil then
            b2:removeSelf()
            b2=nil
        end
        if b3 ~= nil then
            b3:removeSelf()
            b3=nil
        end
        pregunta:removeSelf()
        pregunta=nil
        -----------------------------------------
        local function onGetObjects( event )
    if not event.error then
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
     
        print("Random1: "..rand1.." Random2: "..rand2.." Random3: "..rand3)
        local res1, res2, res3
        if rand1 == 1 then
            res1 = event.results[num].respuesta1
        elseif rand1 == 2 then
            res1 = event.results[num].respuesta2
        elseif rand1 == 3 then
            res1 = event.results[num].respuesta3
        end
     
        if rand2 == 1 then
            res2 = event.results[num].respuesta1
        elseif rand2 == 2 then
            res2 = event.results[num].respuesta2
        elseif rand2 == 3 then
            res2 = event.results[num].respuesta3
        end
     
        if rand3 == 1 then
            res3 = event.results[num].respuesta1
        elseif rand3 == 2 then
            res3 = event.results[num].respuesta2
        elseif rand3 == 3 then
            res3 = event.results[num].respuesta3
        end
     
        local correcta = event.results[num].correcta

        if event.results[num].archivo~=nil then
            pregunta = display.newText(event.results[num].pregunta, centrox, 185, native.systemFont, 18)
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
                imagen.y=centroy
                imagen.width=175
                imagen.height=150
                screenGroup:insert( imagen )
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
                local function playAudio()
                    audio.play( sound )
                    --media.playSound( "audio.wav", system.TemporaryDirectory )
                end
                play:addEventListener("tap", playAudio)
            end
        else
            pregunta = display.newText(event.results[num].pregunta, centrox, 260, native.systemFont, 18)
            pregunta:setFillColor(0,0,0)
            screenGroup:insert(pregunta)
        end


        local function boton1(event) 
            if event.phase == "ended" then
            if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                --print("Res1 "..res1.." correcta "..correcta)
                displayTime.isVisible=false
                --progressView:removeSelf()
                Runtime:removeEventListener("enterFrame", checkTime)
                if res1 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end

        b1 = widget.newButton
        {
            left = 60,
            top = 380,
            id = "button1",
            label = res1,
            onEvent = boton1,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b1 )

        local function boton2(event) 
            if event.phase == "ended" then
            if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                Runtime:removeEventListener("enterFrame", checkTime)
                if res2 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end


        b2 = widget.newButton
        {
            left = 60,
            top = 430,
            id = "button2",
            label = res2,
            onEvent = boton2,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b2 )
 

        local function boton3(event) 
            if event.phase == "ended" then
            if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                Runtime:removeEventListener("enterFrame", checkTime)
                if res3 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end

        b3 = widget.newButton
        {
            left = 60,
            top = 480,
            id = "button1",
            label = res3,
            onEvent = boton3,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b3 )
    end
end
local queryTable = { }
parse:getObjects( "preguntas", queryTable, onGetObjects )

    end

end



local myRoundedRect = display.newRoundedRect( centrox, 140, 200, 40, 12 )
myRoundedRect.strokeWidth = 10
myRoundedRect:setFillColor( 1 )
myRoundedRect:setStrokeColor( 0, 0.5, 0.7 )
screenGroup:insert( myRoundedRect )

local function onGetMe( event )
    if event.code == parse.EXPIRED then
        local textlog = display.newText("Expiro la session ", centrox, 140, native.systemFont, 30)
        textlog:setFillColor( 0, 0, 0 )
        screenGroup:insert( textlog )
    else
        local nombre = display.newText(event.response.nombre, centrox, 140, native.systemFont, 18)
        nombre:setFillColor(0,0,0)
        screenGroup:insert( nombre )    
    end
end
parse:getMe( onGetMe )
--[[local nombre = display.newText("Ricardo Hinojosa", centrox, 140, native.systemFont, 18)
        nombre:setFillColor(0,0,0)]]


local function onGetObjects( event )
    if not event.error then
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
     
        print("Random1: "..rand1.." Random2: "..rand2.." Random3: "..rand3)
        local res1, res2, res3
        if rand1 == 1 then
            res1 = event.results[num].respuesta1
        elseif rand1 == 2 then
            res1 = event.results[num].respuesta2
        elseif rand1 == 3 then
            res1 = event.results[num].respuesta3
        end
     
        if rand2 == 1 then
            res2 = event.results[num].respuesta1
        elseif rand2 == 2 then
            res2 = event.results[num].respuesta2
        elseif rand2 == 3 then
            res2 = event.results[num].respuesta3
        end
     
        if rand3 == 1 then
            res3 = event.results[num].respuesta1
        elseif rand3 == 2 then
            res3 = event.results[num].respuesta2
        elseif rand3 == 3 then
            res3 = event.results[num].respuesta3
        end
     
        local correcta = event.results[num].correcta

        if event.results[num].archivo~=nil then
            pregunta = display.newText(event.results[num].pregunta, centrox, 185, native.systemFont, 18)
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
                imagen.y=centroy
                imagen.width=175
                imagen.height=150
                screenGroup:insert( imagen )
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
                local function playAudio()
                    audio.play( sound )
                    --media.playSound( "audio.wav", system.TemporaryDirectory )
                end
                play:addEventListener("tap", playAudio)
            end
        else
            pregunta = display.newText(event.results[num].pregunta, centrox, 260, native.systemFont, 18)
            pregunta:setFillColor(0,0,0)
            screenGroup:insert(pregunta)
        end

        local function boton1(event) 
            if event.phase == "ended" then
            if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                --print("Res1 "..res1.." correcta "..correcta)
                displayTime.isVisible=false
                --progressView:removeSelf()
                Runtime:removeEventListener("enterFrame", checkTime)
                if res1 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end

        b1 = widget.newButton
        {
            left = 60,
            top = 380,
            id = "button1",
            label = res1,
            onEvent = boton1,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b1 )

        local function boton2(event) 
            if event.phase == "ended" then
            if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                Runtime:removeEventListener("enterFrame", checkTime)
                if res2 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end


        b2 = widget.newButton
        {
            left = 60,
            top = 430,
            id = "button2",
            label = res2,
            onEvent = boton2,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b2 )


        local function boton3(event) 
            if event.phase == "ended" then
                if play~=nil then
                play:removeSelf()
                play=nil
            end
            if imagen~=nil then
                imagen:removeSelf()
                imagen=nil
            end
                Runtime:removeEventListener("enterFrame", checkTime)
                if res3 == correcta then
                    puntuacionreal=puntuacionreal+1
                    puntuacionNum.text=puntuacionreal
                    pant = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
                    pant:setFillColor(0, 0, 0, 0.9)
                    screenGroup:insert( pant )
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
                    }
                    screenGroup:insert( continuar )
                end
            end
        end

        b3 = widget.newButton
        {
            left = 60,
            top = 480,
            id = "button1",
            label = res3,
            onEvent = boton3,
            shape="roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 3,
            fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
            labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
        }
        screenGroup:insert( b3 )
    end
end
local queryTable = { }
parse:getObjects( "preguntas", queryTable, onGetObjects )
    
function onKeyEvent(event)
    if ( event.keyName == "back" and event.phase == "up") then
        composer.gotoScene("menuSesion")
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
        local levelTime = 15
        displayTime = display.newText(levelTime, centrox-(centrox/2), 82, native.systemFont, 20)
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
                acabo = true
                displayTime.isVisible=false
            end
        end
        Runtime:addEventListener("enterFrame", checkTime)
        ---------------------
        imagens.rotation = -360
        local reverse = 1
        local function rockRect()
            if ( reverse == 0 ) then
                reverse = 1
                transition.to( imagens, { rotation=-360, time=1000, transition=easing.inOutCubic } )
            else
                reverse = 0
                transition.to( imagens, { rotation=360, time=1000, transition=easing.inOutCubic } )
            end
        end
        tiempoEspera=timer.performWithDelay( 900, rockRect, 0 )
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
    background=nil
    text:removeSelf()
    text=nil
    logo:removeSelf()
    logo=nil
    imagens:removeSelf()
    imagens=nil
    estrella:removeSelf()
    estrella=nil
    puntuacion:removeSelf()
    puntuacion=nil
    --progressView:removeSelf()
    --progressView=nil
    myRoundedRect:removeSelf()
    myRoundedRect=nil
    nombre:removeSelf()
    nombre=nil
    pregunta:removeSelf()
    pregunta=nil
    if correcto ~= nil then
    correcto:removeSelf()
    correcto=nil
    end
    if incorrecto ~= nil then
    incorrecto:removeSelf()
    incorrecto=nil
    end
    b1:removeSelf()
    b1=nil
    b2:removeSelf()
    b2=nil
    b3:removeSelf()
    b3=nil
    pant:removeSelf()
    pant=nil
    palomita:removeSelf()
    palomita=nil
    continuar:removeSelf()
    continuar=nil
    tache:removeSelf()
    tache=nil
    bexit:removeSelf()
    bexit=nil
    puntuacionNum:removeSelf()
    puntuacionNum=nil
    imagen:removeSelf()
    imagen=nil
    play:removeSelf()
    play=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene