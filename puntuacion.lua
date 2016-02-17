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
    local sceneGroup = self.view
    local centrox = display.contentCenterX
    local centroy = display.contentCenterY
    local background = display.newRect( centrox, centroy,display.contentWidth , display.contentHeight)
    background:setFillColor(1, 1, 1)
    sceneGroup:insert( background )
    local text = display.newImageRect("texto.png", 125, 35)
    text.x = centrox-(centrox/13)
    text.y = 50
    sceneGroup:insert( text )
    local logo = display.newImageRect("logo.png", 100, 35)
    logo.x = centrox+(centrox/1.5)
    logo.y = 50
    sceneGroup:insert( logo )
    local imagen = display.newImageRect("ruleta.png", 50, 50)
    imagen.x = centrox-(centrox/1.4)
    imagen.y = 50
    sceneGroup:insert( imagen )
    local labelPuntuacion = display.newText("Puntuación", 160, 100, native.systemFont, 40)
    labelPuntuacion:setFillColor(0)
    sceneGroup:insert(labelPuntuacion)
    local labelnombre = display.newText("Nombre", 55, 140, native.systemFont, 30)
    labelnombre:setFillColor(0)
    sceneGroup:insert(labelnombre)
    local labelscore = display.newText("Score", 260, 140, native.systemFont, 30)
    labelscore:setFillColor(0)
    sceneGroup:insert(labelscore)
    

    local function onGetObjects( event )
        if not event.error then
            local function onRowRender( e )
                local row = e.row
                local rowHeight = row.contentHeight
                local rowWidth = row.contentWidth
                local function onGetUser( ev )
                    if not event.error then
                        local rowTitle = display.newText(row,ev.response.nombre, 0, 0, native.systemFont, 25)
                        rowTitle:setFillColor(0)
                        rowTitle.anchorX=0
                        rowTitle.x=0
                        rowTitle.y=rowHeight*0.5
                        local rowTitle2 = display.newText(row,event.results[row.index].score, 0, 0, native.systemFont, 25)
                        rowTitle2:setFillColor(0)
                        rowTitle2.anchorX=0
                        rowTitle2.x=280
                        rowTitle2.y=rowHeight*0.5
                    end
                end
                parse:getUser( event.results[row.index].player.objectId, onGetUser )
            end

            local tableView = widget.newTableView
            {   
            left = 0,
            top = 160,
            height = 340,
            width = 330,
            onRowRender = onRowRender
            }
            sceneGroup:insert(tableView)

            for i=1, #event.results do
                tableView:insertRow{}
            end

        end
    end
    local query = { 
        ["order"] = "-score"
    --["where"] = { ["player"] = { ["__type"] = "Pointer",
    --["className"] = parse.USER_CLASS, ["objectId"] = user_object_id } } 
    }
    parse:getObjects( "Score", query, onGetObjects )

     local function regresar( event )
        if ( "ended" == event.phase ) then
        button2:removeSelf()
        composer.removeScene("puntuacion")
        composer.gotoScene("menuSesion")
        end
    end

    button2 = widget.newButton
    {
    label = "Regresar",
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
    button2.x = _W*0.5
    button2.y = _H*0.95

function onKeyEvent(event)---NOT WORK
    if ( event.keyName == "back" and event.phase == "up") then
        composer.gotoScene("menuSesion")
        return true
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

    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
 end

function scene:destroy( event )
    local sceneGroup = self.view
   
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
