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
    local imagen = display.newImageRect("preguntados.png", 50, 50)
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
    
    local function onGetMe( event )
    local evento = event.response.evento
    local cont=0;
    local cont2=0;
        local function onGetObjects( event )
            if not event.error then
                local function onRowRender( e )
                    local row = e.row
                    local rowHeight = row.contentHeight
                    local rowWidth = row.contentWidth
                    local function onGetUser( ev )
                        if not ev.error then
                            local rowTitle = display.newText(row,ev.response.nombre, 0, 0, native.systemFont, 25)
                            rowTitle:setFillColor(0)
                            rowTitle.anchorX=0
                            rowTitle.x=50
                            rowTitle.y=rowHeight*0.5
                            local rowTitle2 = display.newText(row,event.results[row.index].score, 0, 0, native.systemFont, 25)
                            rowTitle2:setFillColor(0)
                            rowTitle2.anchorX=0
                            rowTitle2.x=280
                            rowTitle2.y=rowHeight*0.5

                            local function onAvatar(event)
                                local avatar = event.response.filename
                                local avatarbr = event.response.baseDirectory
                                local photoAvatar = display.newImageRect( row,avatar, avatarbr,50, 50 )
                                --photoAvatar:scale( 0.5, 0.5 )
                                photoAvatar.x=15--modificar hasta que quede en su lugar
                                photoAvatar.y=rowHeight*0.5
                                cont=cont+50
                                --avatar.width=50
                                --avatar.height=50
                            end
                            if ev.response.avatar~=nil then
                                local url = ev.response.avatar.url
                                --display.loadRemoteImage(url,"GET", onAvatar, "av"..row.index..".jpg")
                                network.download( url, "GET", onAvatar, "av"..row.index..".jpg" )
                            else
                                local photoAvatar = display.newImageRect( row, "avatar.png", 50, 50 )
                                photoAvatar.x=15
                                photoAvatar.y=rowHeight*0.5
                                cont=cont+50
                            end
                        end
                    end
                    parse:getUser( event.results[row.index].player.objectId, onGetUser )
                end

                local tableView = widget.newTableView
                {   
                left = 0,
                top = 160,
                height = 450,
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
            ["order"] = "-score",
        --["where"] = { ["player"] = { ["__type"] = "Pointer",
        --["className"] = parse.USER_CLASS, ["objectId"] = user_object_id } } 
        ["where"] = {["evento"] = evento}
        }
        parse:getObjects( "Score", query, onGetObjects )
    end
    parse:getMe( onGetMe )

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
    background:removeSelf()
    background=nil
    text:removeSelf()
    text=nil
    logo:removeSelf()
    logo=nil
    imagen:removeSelf()
    imagen=nil
    labelPuntuacion:removeSelf()
    labelPuntuacion=nil
    labelnombre:removeSelf()
    labelnombre=nil
    labelscore:removeSelf()
    labelscore=nil
    tableView:removeSelf()
    tableView=nil
    rowtitle:removeSelf()
    rowTitle=nil
    rowtitle2:removeSelf()
    rowTitle2=nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
