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

    local myRectangle = display.newRect( centrox, 210, 400, 800 )
    myRectangle:setFillColor( 0,0.6,0.7 )
    myRectangle.strokeWidth = 15
    myRectangle:setStrokeColor( 0, 0.45, 0.65 )
    sceneGroup:insert( myRectangle )
    local labelPuntuacion = display.newText("Puntuación", display.contentCenterX, 40, native.systemFontBold, 40)
    labelPuntuacion:setFillColor(1)
    sceneGroup:insert(labelPuntuacion)
    local labelnombre = display.newText("Nombre", 55, 100, native.systemFontBold, 30)
    labelnombre:setFillColor(1)
    sceneGroup:insert(labelnombre)
    local labelscore = display.newText("Score", 260, 100, native.systemFontBold, 30)
    labelscore:setFillColor(1)
    sceneGroup:insert(labelscore)
    

    local function onGetObjects( event )
        if not event.error then
            local function onRowRender( e )
                local row = e.row
                local rowHeight = row.contentHeight
                local rowWidth = row.contentWidth
                local function onGetUser( ev )
                    if not event.error then
                        local rowTitle = display.newText(row,ev.response.nombre, 0, 0, native.systemFontBold, 20)
                        rowTitle:setFillColor(1)
                        rowTitle.anchorX=0
                        rowTitle.x=0
                        rowTitle.y=rowHeight*0.5
                        local rowTitle2 = display.newText(row,event.results[row.index].score, 0, 0, native.systemFontBold, 25)
                        rowTitle2:setFillColor(1)
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
            top = 120,
            height = 340,
            width = 330,
            onRowRender = onRowRender,
            backgroundColor = { 0, 0.6, 0.7 }
            }
            sceneGroup:insert(tableView)

            for i=1, #event.results do
                tableView:insertRow{
                rowColor = { default={0,0.6,0.7}, over={1,0.5,0,0.2} },
                lineColor = { 0, 0.45, 0.65 },
                rowHeight = 56
            }
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
    label = "Volver",
    onEvent = regresar,
    emboss = false,
    --properties for a rounded rectangle button...
    shape="roundedRect",
    width = 180,
    height = 40,
    cornerRadius = 3,
    fillColor = { default={ 0, 0.45, 0.65, 1 }, over={ 0, 0.5, 0.7, 1 } },
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    font = native.systemFontBold
    }
    button2.x = _W*0.5
    button2.y = _H*0.90

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
