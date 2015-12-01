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
    --
    local textreg = display.newText("Registro", centrox, 35, native.systemFont, 30)
    textreg:setFillColor( 0, 0, 0 )
    screenGroup:insert( textreg )

    local function registro( event )
        if ( "ended" == event.phase ) then

            if (nombre.text=="") then
              local function onComplete( event )
                 if event.action == "clicked" then
                      local i = event.index
                      if i == 1 then
                          pass.text=""
                      end
                  end
                end
              local alert = native.showAlert( "Alerta!", "Falta campo 'Nombre'", { "OK"}, onComplete )
            elseif (email.text=="") then
              local function onComplete( event )
                 if event.action == "clicked" then
                      local i = event.index
                      if i == 1 then
                          pass.text=""
                      end
                  end
                end
              local alert = native.showAlert( "Alerta!", "Falta campo 'Correo Electrónico'", { "OK" }, onComplete )
            elseif (pass.text=="") then
              local function onComplete( event )
                 if event.action == "clicked" then
                      local i = event.index
                      if i == 1 then
              
                      end
                  end
                end
              local alert = native.showAlert( "Alerta!", "Falta campo 'Contraseña'", { "OK" }, onComplete )

            elseif (string.len(pass.text)<8) then
               local function onComplete( event )
                 if event.action == "clicked" then
                      local i = event.index
                      if i == 1 then
                        pass.text=""                   
                      end
                  end
                end
                local alert = native.showAlert( "Alerta!", "La contraseña debe tener mínimo 8 caracteres", { "OK" }, onComplete )
            else
              local function onCreateUser( event )
                composer.gotoScene("menuInicio")
                local function onComplete( event )
                 if event.action == "clicked" then
                      local i = event.index
                      if i == 1 then
                        nombre.text=""
                        email.text=""
                        pass.text="" 
                      end
                  end
                end
              local alert = native.showAlert( "Registrado exitosamente!", "Te hemos enviado un correo electrónico para poder completar tu registro", { "OK" }, onComplete )
            end
              --create Parse User
              local userData = { ["nombre"] = nombre.text, ["username"] = email.text, ["email"] = email.text ,["password"] = pass.text }
              parse:createUser( userData, onCreateUser )
            end
        end
    end


local registrar = widget.newButton
{
    left = 70,
    top = 330,
    id = "button1",
    label = "Registrar",
    onEvent = registro,
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
screenGroup:insert( registrar )

----------------------------
local function atras( event )
  composer.gotoScene("opcionRegistro")
end

local atras = widget.newButton
{
    left = 70,
    top = 630,
    id = "button1",
    label = "atras",
    onEvent = atras,
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
atras.x = _W*0.5
atras.y = _H*0.7
screenGroup:insert( atras )
--------------------

local function onKeyEvent( event )
    if ( event.keyName == "back" and event.phase == "up") then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            native.setKeyboardFocus(nil)
            composer.gotoScene("opcionRegistro")
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
        -- Example: start timers, begin animation, play audio, etc.
        nombre = native.newTextField( centrox, 100, 180, 40 )
        nombre.inputType = "default"
        nombre.placeholder = "Nombre"
        email = native.newTextField( centrox, 180, 180, 40 )
        email.inputType = "email"
        email.placeholder = "Email"
        pass = native.newTextField( centrox, 260, 180, 40 )
        pass.isSecure = true
        pass.placeholder = "Contraseña"
    end
end

function scene:hide( event )
     local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        nombre:removeSelf()
        nombre.isVisible = false
        email:removeSelf()
        email.isVisible = false
        pass:removeSelf()
        pass.isVisible = false
        native.setKeyboardFocus(nil)
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


function scene:destroy( event )
    local sceneGroup = self.view
    background:removeSelf()
    background=nil
    textreg:removeSelf()
    textreg=nil
    registrar:removeSelf()
    registrar=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene