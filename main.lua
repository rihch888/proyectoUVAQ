display.setStatusBar( display.HiddenStatusBar )
local composer = require "composer"
local parse = require( "mod_parse" )
local pushwoosh = require( "pushwoosh" )
local json = require "json"
local notifications = require( "plugin_notifications" )
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})

--system.cancelNotification()
local launchArgs = ...
 
local function onComplete( event )
    composer.gotoScene( "menuInicio" )
end

if launchArgs and launchArgs.notification then
    --native.showAlert( "launchArgs", json.encode( launchArgs.notification  ), { "OK" } )
    launchArgs.notification.type = "remote" -- will always be this.
    launchArgs.notification.name = "notification" -- will always be this.
    --launchArgs.notification.alert = "whatever message you sent with pushwoosh" -- you probably want to display this.
    launchArgs.notification.applicationState = "inactive"  -- it will always be this.
    native.showAlert( "launchArgs", json.encode( launchArgs.notification.alert ), { "OK" }, onComplete )
end



local function registerWithPushWoosh (token) 
    -- Register device with PushWoosh. PushWoosh account and setup required.
    
    local DeviceID = token
    local PW_APPLICATION = "A36B5-DA656"    --use your app id in pushwoosh
    local PW_URL = "https://cp.pushwoosh.com/json/1.3/registerDevice"
 
    local function networkListener( event )
            if ( event.isError ) then --error occurred notify user
                native.showAlert( "Notification Registration Failed", "An Error Contacting the Server has Occurred", { "OK" } )
            else
                --Registration worked
            end
    end     
 
    local commands_json = {
         ["request"] = {
            ["application"] = PW_APPLICATION,
            ["push_token"] = DeviceID,
            ["language"] = system.getPreference("ui", "language"),
            ["hwid"] = system.getInfo("deviceID"),
            ["timezone"] = 3600, -- offset in seconds
            ["device_type"] = 3 -- 1 – iphone, 2 – blackberry, 3 – android, 4 – nokia, 5 – WP7, 7 – mac
        }
    }
 
    local jsonvar = {}
    jsonvar = json.encode(commands_json)
 
    local post = jsonvar
    local headers = {}
    headers["Content-Type"] = "application/json"
    headers["Accept-Language"] = "en-US"
    local params = {}
    params.headers = headers
    params.body = post
    network.request ( PW_URL, "POST", networkListener, params )
end
 
 


local function onNotification( event )
    if (event.type=="remote") then
        --event.type = "remote" -- will always be remote if you received a push notification, local if its a local notification or remoteRegistration  if it's a registration event (which you are currently handling)
        --event.name = "notification" -- will always be this.
        --event.alert = "whatever message you sent with pushwoosh" -- you probably want to display this.
        --event.applicationState = "active"  -- it will active (I think) if your app is in the foreground, or inactive if you were backgrounded.
        -- put code here to handle your push notification
        native.showAlert( "Preguntas UVAQ",json.encode( event.data ), { "OK" } )
    elseif( event.type == "remoteRegistration")then
       --registerWithPushWoosh(event.token)
    end
end

Runtime:addEventListener( "notification", onNotification )
 

pushwoosh.registerForPushNotifications( "A36B5-DA656", launchArgs )
--Runtime:hideErrorAlerts()
--notifications.cancelNotification()

composer.gotoScene( "menuInicio" )
_W = display.contentWidth
_H = display.contentHeight
--parse.showStatus = true


