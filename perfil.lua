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
      background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    sceneGroup:insert( background )

    local photoAvatar = nil
    local fondo = nil
    local p = false
    local filemeta = nil
   -- phase = event.phase
    userObjId = nil
    widget = require( "widget" )
    --textF1 = nil
    fileObjId = nil
    --carga = nil
    --fondo = nil 
    --button1 = nil
    --photo = nil
    --img1 = nil
    --textoGuardar = nil

    function onSelected2(event)
        path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
        local fh, reason = io.open( path, "r" )
        if fh then
            p = false
            photoAvatar:removeSelf()
            photoAvatar = nil
            photoAvatar = display.newImageRect(path, 150, 80)
            photoAvatar.x=display.contentCenterX*0.5
            photoAvatar.y=display.contentCenterY*0.5
            photoAvatar.x=_W*0.5
            photoAvatar.y=_H*0.2
            sceneGroup:insert(photoAvatar)
        end
    end

    local function onSelected( event )
    path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
        if fh then
            p = false
            photoAvatar:removeSelf()
            photoAvatar = nil
            photoAvatar = display.newImageRect(path, 150, 80)
            photoAvatar.x=_W*0.5
            photoAvatar.y=_H*0.2
            sceneGroup:insert(photoAvatar)
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

    local function onGetMe( event )
        if event.code == parse.EXPIRED then
            print( "Session expired.  Log in.")
        else
        print(event.response.objectId)
        textF1.text = event.response.nombre
        userObjId = event.response.objectId
        end
    end

    parse:getMe( onGetMe )

    local function menuImg(event)
        if (event.phase == "ended") then
            alert = native.showAlert( "Seleccionar imagen", "",{ "Tomar foto", "Abrir galeria" }, onComplete )
        
        end
    end

    local opcionesTexto = {
        text ="Nombre de usuario", 
        font = native.systemFont, 
        fontSize =20,
        x=  _W*0.5,
        y=  _H*0.5
    }


    texto1 = display.newText(opcionesTexto)
    texto1:setFillColor(0,0,0)

    textF1 = native.newTextField( _W*0.5,_H*0.6 , 300, 40 )
    --textF1.align = "center"
    textF1:setTextColor( 0, 0, 0 )
    sceneGroup:insert(texto1)

    local opcionesTexto = {
        text ="Nueva contraseña", 
        font = native.systemFont, 
        fontSize =20,
        x=  _W*0.5,
        y=  _H*0.7
    }
    texto2 = display.newText(opcionesTexto)
    texto2:setFillColor(0,0,0)
    textF2 = native.newTextField( _W*0.5,_H*0.8 , 300, 40 )
    --textF2.align = "center"
    textF2:setTextColor( 0, 0, 0 )
    --textF2.isSecure = true
    sceneGroup:insert(texto2)

    

    path = system.pathForFile( "avatar.jpg", system.TemporaryDirectory)
    local fh, reason = io.open( path, "r" )
    if fh then
        photoAvatar = display.newImageRect(path, 150, 80)
        photoAvatar.x=_W*0.5
        photoAvatar.y=_H*0.2
        photoAvatar:addEventListener( "touch", menuImg )
        sceneGroup:insert(photoAvatar)
        else
            photoAvatar = display.newImageRect( "avatar.png", 180, 180 )
            photoAvatar.x = _W*0.5
            photoAvatar.y = _H*0.23
            photoAvatar:addEventListener( "touch", menuImg )
            sceneGroup:insert(photoAvatar)
            p = true

    end

    local function guardar( ... )
       
        
-- Function to handle button events
    local function handleButtonEvent( event )

        if ( "ended" == event.phase ) then
            button1:removeEventListener("touch")
            textF2.isVisible = false
            textF1.isVisible = false
            if photoAvatar then
                photoAvatar:removeEventListener( "touch", menuImg )
            end

        local function actualizar( )
            local function onUpdateUser( event )
             if not event.error then
                print( event.response.updatedAt )
             end
            end

            local dataTable = { ["nombre"] = textF1.text, ["password"] = textF2.text }
            --local dataTable = { ["nombre"] = "Bossuet", ["password"] = "123" }

            parse:updateUser( userObjId, dataTable, onUpdateUser )
        end
        actualizar()
--------------------------------------
        
        if(p == false)then
            filemeta = {["filename"] = "avatar.jpg", ["baseDir"] = system.TemporaryDirectory}
        else
            filemeta = {["filename"] = "avatar.png", ["baseDir"] = system.ResourceDirectory}
        end
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
            fondo = nil
            textoGuardar:removeSelf()
            button1:addEventListener("touch")
            textF2.isVisible = true
            textF1.isVisible = true
            button1.isVisible = true
          if photoAvatar then
                photoAvatar:addEventListener( "touch", menuImg )
            end
      end
    end
    parse:uploadFile(filemeta, onFileUploaded)
    
    fondo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    fondo:setFillColor(1,1,1)
    fondo.alpha=0.8
    sceneGroup:insert(fondo)

    button1.isVisible = false



    local opcionesTexto2 = {
        text ="Guardando...", 
        font = native.systemFont, 
        fontSize =40,
        x=  _W*0.5,
        y=  _H*0.5
    }

    textoGuardar = display.newText(opcionesTexto2)
    textoGuardar:setTextColor( 0, 0, 0 )
    sceneGroup:insert(textoGuardar)
    
--------------------

        end
    end
    button1 = widget.newButton
    {
    label = "button",
    onEvent = handleButtonEvent,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    }

-- Center the button
    button1.x = _W*0.5
    button1.y = _H*0.92

-- Change the button's label text
    button1:setLabel( "Guardar cambios")
    end

    guardar()

--[[
    local function regresar( event )
        if ( "ended" == event.phase ) then
        composer.removeScene("perfil")
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
    }

-- Center the button
    button2.x = _W*0.5
    button2.y = _H*0.99

-- Change the button's label text
    button2:setLabel( "Regresar")
    sceneGroup:insert(button2)
    --]]
    -------------------------------------

    function onKeyEvent(event)
    if ( event.keyName == "back" and event.phase == "up") then
        composer.removeScene("perfil")
        composer.gotoScene("menuSesion")
        return true
    end
    return false
    end

    Runtime:addEventListener( "key", onKeyEvent )

    ------------------^boton guardar
    
end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   


    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
       
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    
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
    
    background:removeSelf()
    --img:removeSelf()
    --photo:removeSelf()
    texto1:removeSelf()
    texto2:removeSelf()
    --fondo:removeSelf()
    --textoGuardar:removeSelf()

    if(photoAvatar~= nil)then
        photoAvatar:removeSelf()
    end
    
    button1:removeSelf()
    --button2:removeSelf()
    textF1:removeSelf()
    textF2:removeSelf()
    --button2 = nil
    --]]

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene

