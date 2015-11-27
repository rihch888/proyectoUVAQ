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

local function onNotification( event )
	local alert = native.showAlert( "remote notification", json.encode( event.data ), { "OK" } )
end

local function onRegistrationSuccess( event )
	print( "Registered on Pushwoosh" )
--local alert =	native.showAlert( "remote notification", "registrado", { "OK" } )
end

local function onRegistrationFail( event )
local na =	native.showAlert( "Notification Registration Failed", "An Error Contacting the Server has Occurred. Please try again later from the application settings.", { "OK" } )                  
end


---------------
local function notificationListener( event )
--local alert2 =	native.showAlert( "remote notification", "entro", { "OK" } )

    if ( event.type == "remote" or event.type == "local" ) then
        --handle the push or local notification
        --local alert2 =	native.showAlert( "remote notification", event.alert, { "OK" } )
        local options = {
    alert = event.name,
    badge = 0,
    sound = "alarm.caf",
    custom = { foo = "bar" }
}
        local notification1 = notifications.scheduleNotification( 2, options )
    elseif ( event.type == "remoteRegistration" ) then

        local deviceToken = event.token
        local deviceType = 1  --default to iOS

        if ( system.getInfo("platformName") == "Android" ) then
            deviceType = 3
        end

        print( "Setting up with PushWoosh", event.token )
        local PW_APPLICATION = "A36B5-DA656"  --use your app ID in PushWoosh
        local PW_URL = "https://cp.pushwoosh.com/json/1.3/registerDevice"

        local function networkListener( event )
            if ( event.isError ) then
                --error occurred
                native.showAlert( "Notification Registration Failed", "An Error Contacting the Server has Occurred.", { "OK" } )
        else
            --registration successful!
                print( "PushWoosh registration successful", system.getInfo("deviceID") )
            end
        end    

        local commands_json =
        {
            ["request"] = {
                ["application"] = PW_APPLICATION,
                ["push_token"] = deviceToken,
                ["language"] = system.getPreference( "ui", "language" ),  --OR: system.getPreference( "ui", "language" ),
                ["hwid"] = system.getInfo("deviceID"),
                ["timezone"] = -3600,  --offset in seconds
                ["device_type"] = deviceType
            }
        }

        local post_body = json.encode( commands_json )

        local headers = {}
        headers["Content-Type"] = "application/json"
        headers["Accept-Language"] = "en-US"

        local params = {}
        params.headers = headers
        params.body = post_body

        network.request ( PW_URL, "POST", networkListener, params )
    end
end

-- The notification Runtime listener should be handled from within "main.lua"
Runtime:addEventListener( "notification", notificationListener )

-----------



Runtime:addEventListener( "pushwoosh-notification", onNotification )
Runtime:addEventListener( "pushwoosh-registration-success", onRegistrationSuccess )
Runtime:addEventListener( "pushwoosh-registration-fail", onRegistrationFail )

local launchArgs = ...

pushwoosh.registerForPushNotifications( "A36B5-DA656", launchArgs )


composer.gotoScene( "menuInicio" )
_W = display.contentWidth
_H = display.contentHeight
--parse.showStatus = true

