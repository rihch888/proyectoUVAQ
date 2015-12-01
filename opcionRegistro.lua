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
    --
    local textreg = display.newText("Registro", centrox, 35, native.systemFont, 30)
    textreg:setFillColor( 0, 0, 0 )
    screenGroup:insert( textreg )

    --------------------->>>
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

    -------------------->>>

    local function onUpdateUser(  )
      composer.gotoScene("menuSesion")
    end

    local function registroFace( event )
         
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
    end

local function registroCorreo( event )
  if(event.phase == "ended")then
  composer.gotoScene("registro")
  end
  
end

local loginFace = widget.newButton
{
    id = "loginFace",
    label = "Conectate con Facebook",
    onEvent = registroFace,
    shape="roundedRect",
    width = 220,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
loginFace.x = _W*0.5
loginFace.y = _H*0.4
screenGroup:insert( loginFace )

local registrar = widget.newButton
{
    id = "button1",
    label = "Regístrate con tu dirección \nde correo electrónico",
    onEvent = registroCorreo,
    shape="roundedRect",
    width = _W*0.8,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
}
registrar.x= _W*0.5
registrar.y = _H*0.6
screenGroup:insert( registrar )

--[[
local function onKeyEvent( event )
    if (event.phase == "up" and event.keyName == "back") then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            native.setKeyboardFocus(nil)
           
            return true
        end
    end
    return false
end
--]]
--[[
local function onKeyEvent(event)
    if ( event.phase == "up" and event.keyName == "back") then
        composer.removeScene("opcionRegistro")
        composer.gotoScene("menuInicio")
        return true
    end
    return false
    end
Runtime:addEventListener( "key", onKeyEvent )
--]]
local function atras( event )
  composer.gotoScene("menuInicio")
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

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Example: start timers, begin animation, play audio, etc.
       
    end
end

function scene:hide( event )
     local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
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