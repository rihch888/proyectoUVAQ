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
    parse.showStatus = true
    centrox = display.contentCenterX
    centroy = display.contentCenterY

    local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    screenGroup:insert( background )

    local myRectangle = display.newRect( centrox, 400, 500, 500 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    screenGroup:insert( myRectangle )
    local textlog = display.newText("Iniciar Sesión", _W*0.5, _H*0.35, native.systemFontBold, 30)
    textlog:setFillColor( 1, 1, 1 )
    screenGroup:insert( textlog )

    local userObjId = nil
    --local e_mail = "a@gmail.com"
    local response = nil

    local function irMenuSesion( event )
      

  
      local function onUpdateUser( event )
        composer.gotoScene("menuSesion")
      end
    ------------------------
    local function onGetMe( event )
        if event.code == parse.EXPIRED then
            local alert = native.showAlert( "Error!","Vuelve a iniciar sesion", { "OK" }, onComplete )
        else

        --facebook.login( "671856566284765", listener, {"publish_actions"}  )
        --statusMessage.textObject.text = response.name

        userObjId = event.response.objectId
        local dataTable = { ["nombre"] = response.name}
        parse:updateUser( userObjId, dataTable, onUpdateUser )
        end
    end
    parse:getMe( onGetMe )
    --------------------------
    
    end

    
     local function iniciarSesion (event)
        
        facebook.logout()
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
                          pass.text=""
                        end
                    end
                  end
                local alert = native.showAlert( "Error!", "Correo electrónico o contraseña incorrectos", { "OK" }, onComplete )
                end
            end
            parse:loginUser( { ["username"] = email.text, ["password"] = pass.text }, onLoginUser )
            --parse:loginUser( { ["username"] = "bozz-9@hotmail.com", ["password"] = "123" }, onLoginUser )
        end
    end

    local function entrarFace( event )
        
     if(event.phase=="ended")then
      local sessionToken, sessionExpiry
 
local function doParseLogin( fb_user_id, fb_session_token, fb_session_expiry )
 
 
  local authData = {
    ["facebook"] = {
      ["id"] = tostring( fb_user_id ),
      ["access_token"] = tostring( fb_session_token ),
      ["expiration_date"] = parse:timestampToISODate( fb_session_expiry )
    }
  }
  

 
 
  local function onLoginUser( event )
    --print( event.response.objectId )
    userObjId = event.response.objectId
    if event.status == 201 then
      irMenuSesion()
    else
      --print( event.response.authData.facebook.id )
      --local user = event.response.objectId
      --local alert = native.showAlert( "aleta!","funciona", { "OK" }, irMenuSesion )
      irMenuSesion()
    end
  end
  parse:loginUser( { authData = authData }, onLoginUser )
-----
end
---------
 
local function doFacebookLogin()
 
  local function facebookListener( event )
    if event.type == "session" then
      if event.phase == "login" then
        sessionToken = event.token
        sessionExpiry = event.expiration

 
        if sessionToken then
          facebook.request( "me" )
        end
      end
    elseif event.type == "request" then
      response = event.response
      if not event.isError then
        response = json.decode( event.response )
        
        --local response = json.decode( event.response )
        --e_mail = response.email

 
        if response.id then
          local fb_user_id = response.id
          --all set, lets create/login Parse User
          doParseLogin( fb_user_id, sessionToken, sessionExpiry )
        end
      else
         native.showAlert( "Ooops!", "There was a problem connecting to Facebook.  Check your Internet connection and try again...", { "Ok" } )
      end
    end
  end
 
  facebook.login( 
    "671856566284765",
    facebookListener, 
    { "publish_actions","email"} 
  )
 
end
 
doFacebookLogin()
     end
    
        ------fin entrarFace---------
    end

--[[     local loginFace = widget.newButton
{
    id = "loginFace",
    label = "Conectate con Facebook",
    onEvent = entrarFace,
    shape="roundedRect",
    width = 220,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
loginFace.x = _W*0.5
loginFace.y = _H*0.2
screenGroup:insert( loginFace )]]

-------------------------------------------------------------------------------
local face = display.newImageRect( "facebook3.png", 250, 50 )
face.x = display.contentCenterX
face.y = _H*0.13
screenGroup:insert( face )
face:addEventListener("touch", entrarFace)
-------------------------------------------------------------------------------
    
    local login = widget.newButton
{
    id = "button1",
    label = "Iniciar sesión",
    onEvent = iniciarSesion,
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    font = native.systemFontBold
}
login.x = _W*0.5
login.y = _H*0.67
screenGroup:insert( login )

local function irAtras (event)
  composer.gotoScene("menuInicio")
end

local atras = widget.newButton
{
    id = "button1",
    label = "Volver",
    onEvent = irAtras,
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    font = native.systemFontBold
}
atras.x = _W*0.5
atras.y = _H*0.76
screenGroup:insert( atras )

    --[[local opcionesTexto2 = {
        text ="O accede con tu cuenta", 
        font = native.systemFont, 
        fontSize =18,
        x=  _W*0.5,
        y=  _H*0.44
    }

    textoOpcion = display.newText(opcionesTexto2)
    textoOpcion:setTextColor( 0,0,0 )
    screenGroup:insert(textoOpcion)]]

local function onKeyEvent( event )
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            native.setKeyboardFocus(nil)
            composer.gotoScene("menuInicio")
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
        email = native.newTextField(_W*0.5,_H*0.47, 180, 40 )
        email.inputType = "email"
        email.placeholder = "Email"
        pass = native.newTextField( _W*0.5,_H*0.57, 180, 40 )
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
