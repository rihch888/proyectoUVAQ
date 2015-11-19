display.setStatusBar( display.HiddenStatusBar )
local composer = require "composer"
local parse = require( "mod_parse" )
parse:init({ 
  appId = "IBEd9JQGfKtJHTCPzXddQsVT6aQUn8Q0LOe8wR5i", 
  apiKey = "lyhtF5oj1K6Ui0I9EVPDwr7CJ1e5mLGdIHn2HKiI"
})
composer.gotoScene( "menuInicio" )
_W = display.contentWidth
_H = display.contentHeight