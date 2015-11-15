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
    local textlog = display.newText("Login", centrox, 100, native.systemFont, 30)
    textlog:setFillColor( 0, 0, 0 )
    screenGroup:insert( textlog )
    
    local function entrar (event)
        if ( "ended" == event.phase ) then
            
           local function onLoginUser( event )
                if not event.error then
                    if event.response.emailVerified then
                        native.setKeyboardFocus(nil)
                        composer.gotoScene("menuSesion")
                    else
                        
                        local function onComplete( event )
                           if event.action == "clicked" then
                                local i = event.index
                                if i == 1 then
                                  email.text=""
                                  pass.text=""
                                end
                            end
                          end
                        local alert = native.showAlert( "Error!", "No se ha verificado el correo electrónico", { "OK" }, onComplete )
                    end
                else
                    
                  local function onComplete( event )
                   if event.action == "clicked" then
                        local i = event.index
                        if i == 1 then
                          email.text=""
                          pass.text=""
                        end
                    end
                  end
                local alert = native.showAlert( "Error!", "Correo electrónico o contraseña incorrectos", { "OK" }, onComplete )
                end
            end
            parse:loginUser( { ["username"] = email.text, ["password"] = pass.text }, onLoginUser )
        end
    end
    
    local login = widget.newButton
{
    left = 70,
    top = 330,
    id = "button1",
    label = "Iniciar sesión",
    onEvent = entrar,
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
screenGroup:insert( login )

local function onKeyEvent( event )
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            native.setKeyboardFocus(nil)
            --composer.gotoScene("menuInicio")
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
        -- Example: stop timers, stop animation, stop audio, etc.
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
    textlog:removeSelf()
    textlog=nil
    login:removeSelf()
    login=nil
    if error1 ~= nil then
        error1:removeSelf()
        error1=nil
    end
    if error2 ~= nil then
        error2:removeSelf()
        error2=nil
    end

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
