local composer = require( "composer" )

local scene = composer.newScene()

local parse = require("mod_parse")
parse:init ({
    appId="IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
    apiKey="lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
parse.showStatus = true

_W = display.contentWidth
_H = display.contentHeight

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    local userObjId = nil
    local widget = require( "widget" )
    local textF1
    local fileObjId = nil
    local carga
    local fondo
    local button1
    local photo
    local img1
    local textoGuardar


    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
       
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        function onSelected2(event)
  local path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
      if fh then
        local img = display.newImageRect(path, 150, 80)
        img.x=display.contentCenterX*0.5
        img.y=display.contentCenterY*0.5
        img.x=_W*0.5
        img.y=_H*0.2
      end
end

local function onSelected( event )
    local path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
    if fh then
        local photo = display.newImageRect(path, 150, 80)
        photo.x=_W*0.5
        photo.y=_H*0.2
    end
end

        local function onComplete( event )
   if event.action == "clicked" then
        local i = event.index
        if i == 1 then
  ------------- Do nothing; dialog will simply dismiss
                if media.hasSource( media.Camera ) then
            media.capturePhoto( 
                {
                destination = { baseDir=system.TemporaryDirectory, filename="avatar.jpg"}, 
                listener=onSelected 
                } )
        else
            native.showAlert( "Corona", "This device does not have a camera.", { "OK" } )
        end
-----------------------------------------------
        elseif i == 2 then
            -- Open URL if "Learn More" (second button) was clicked
            --system.openURL( "http://www.coronalabs.com" )

             if media.hasSource( media.PhotoLibrary ) then
        media.selectPhoto(
    {
        mediaSource = media.SavedPhotosAlbum,
        listener = onComplete, 
        destination = { baseDir=system.TemporaryDirectory, filename="avatar.jpg"},
        listener = onSelected2
    })
        else
            native.showAlert( "Corona", "This device does not have a photo library.", { "OK" } )
    end
            -------------------------
        end
    end
end

--[[
 local function onLoginUser( event )
            if not event.error then
                userObjId = event.response.objectId
                print( event.response.objectId )
                --check if user is verified
                if event.response.emailVerified then
                    --user is verifiedprint(fileObjId)
                end
            end

                   local function onGetUser( event )
  if not event.error then
    textF1.text = event.response.nombre
  end
end

parse:getUser( userObjId, onGetUser )
         
    end
        parse:loginUser( { ["username"] = "bozz-9@hotmail.com", ["password"] = "1234" }, onLoginUser )
]]
local function onGetMe( event )
  if event.code == parse.EXPIRED then
    print( "Session expired.  Log in.")
  else
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC")
    print( "Hello", event.response.username )
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC")
    textF1.text = event.response.nombre
  end
end

parse:getMe( onGetMe )

-- Show alert with two buttons
    local function menuImg(event)
        if (event.phase == "ended") then
            local alert = native.showAlert( "Seleccionar imagen", "",{ "Tomar foto", "Abrir galeria" }, onComplete )
        
        end
    end
 
   

    local opcionesTexto = {
        text ="Nombre de usuario", 
        font = native.systemFont, 
        fontSize =20,
        x=  _W*0.5,
        y=  _H*0.5
    }


    local texto1 = display.newText(opcionesTexto)
    texto1:setFillColor(0,0,0)

    textF1 = native.newTextField( _W*0.5,_H*0.6 , 300, 40 )
    --textF1.align = "center"
    textF1:setTextColor( 0, 0, 0 )
    

   
     local opcionesTexto = {
        text ="Nueva contraseña", 
        font = native.systemFont, 
        fontSize =20,
        x=  _W*0.5,
        y=  _H*0.7
    }
    local texto2 = display.newText(opcionesTexto)
    texto2:setFillColor(0,0,0)
    local textF2 = native.newTextField( _W*0.5,_H*0.8 , 300, 40 )
    --textF2.align = "center"
    textF2:setTextColor( 0, 0, 0 )
    --textF2.isSecure = true


    

    local path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
    if fh then
        photo = display.newImageRect(path, 150, 80)
        photo.x=_W*0.5
        photo.y=_H*0.2
        photo:addEventListener( "touch", menuImg )
        else
<<<<<<< HEAD
            img1 = display.newImageRect( "img_perfil.png", 180, 180 )
=======
            
>>>>>>> 95932ec192281cb38298b3e66a301f020f47bc46
            img1.x = _W*0.5
            img1.y = _H*0.23
            img1:addEventListener( "touch", menuImg )
    end
    
    local function guardar( ... )
       

-- Function to handle button events
    local function handleButtonEvent( event )

        if ( "ended" == event.phase ) then
            print( "Button was pressed and released" )
            button1:removeEventListener("touch")
            textF2.isVisible = false
            textF1.isVisible = false
            if img1 then
                img1:removeEventListener( "touch", menuImg )
            end
            
            if photo then
                photo:removeEventListener( "touch", menuImg )
            end
        local function actualizar( )
            local function onUpdateUser( event )
             if not event.error then
                print( event.response.updatedAt )
             end
            end

            local dataTable = { ["nombre"] = textF1.text, ["password"] = textF2.text }
             --local dataTable = { ["nombre"] = "bossuet", ["password"] = "1234" }
             
            --local dataTable = { ["nombre"] = "bossuet", ["password"] = "1234"}
            parse:updateUser( userObjId, dataTable, onUpdateUser )
        end
        actualizar()
--------------------------------------
        local filemeta = {["filename"] = "avatar.jpg", ["baseDir"] = system.TemporaryDirectory}
        --local filemeta = {["filename"] = "subir.jpg", ["baseDir"] = system.ResourceDirectory}
    local function onFileUploaded(event)
      if not event.error then
        

        print("<<<<<<<<<<<<<<<")
        fileObjId = event.response.name
        print(">>>>>>>>>>>>>>>")

        local function onFileLinked( event )
          if not event.error then
          end
        end
        parse:linkFile(parse.USER, userObjId, "avatar", fileObjId, onFileLinked)
            --carga:removeSelf()
            fondo:removeSelf()
            textoGuardar:removeSelf()
            button1:addEventListener("touch")
            textF2.isVisible = true
            textF1.isVisible = true
          if img1 then
                img1:addEventListener( "touch", menuImg )
            elseif photo then
                photo:addEventListener( "touch", menuImg )
            end
        --print("[][][][][][][][][][][][]")
          --  print("----Funciona------")
            --print("[][][][][][][][][][][][]")
    
      end
    end
    parse:uploadFile(filemeta, onFileUploaded)
    
    fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    fondo:setFillColor(1,1,1)
    fondo.alpha=0.8
    --carga = display.newImageRect('Icon-72.png', 160, 150)
    --carga.x=_W*0.5
    --carga.y=_H*0.5

    local opcionesTexto2 = {
        text ="Guardando...", 
        font = native.systemFont, 
        fontSize =40,
        x=  _W*0.5,
        y=  _H*0.5
    }

    textoGuardar = display.newText(opcionesTexto2)
    textoGuardar:setTextColor( 0, 0, 0 )
    
    --parse:updateUser( userObjId, dataTable1, onFileUploaded )
--------------------

        end
    end

-- Create the widget
    button1 = widget.newButton
    {
    label = "button",
    onEvent = handleButtonEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="roundedRect",
    width = 200,
    height = 40,
    fillColor = { default={ 0, 0, 1, 1 }, over={ 0, 0, 0, 0.4 } },
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 1, 1 } }
    }

-- Center the button
    button1.x = _W*0.5
    button1.y = _H*0.92

-- Change the button's label text
    button1:setLabel( "Guardar cambios")
    end

    guardar()

    



    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

<<<<<<< HEAD
return scene
=======
return scene
>>>>>>> 95932ec192281cb38298b3e66a301f020f47bc46
