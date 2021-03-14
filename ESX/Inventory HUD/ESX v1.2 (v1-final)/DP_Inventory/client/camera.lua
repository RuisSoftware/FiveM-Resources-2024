function CreateSkinCam()
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    local playerPed = PlayerPedId()

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)

    isCameraActive = true
    SetCamRot(cam, 0.0, 0.0, 270.0, true)
    SetEntityHeading(playerPed, 0.0)
end

function DeleteSkinCam()
    isCameraActive = false
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    cam = nil
end

function loadCamera(camOffset, zoomOffset)
    CreateSkinCam()

    DisableControlAction(2, 30, true)
    DisableControlAction(2, 31, true)
    DisableControlAction(2, 32, true)
    DisableControlAction(2, 33, true)
    DisableControlAction(2, 34, true)
    DisableControlAction(2, 35, true)
    DisableControlAction(0, 25, true) -- Input Aim
    DisableControlAction(0, 24, true) -- Input Attack

    local angle = 90
    
    if isCameraActive then
        if angle > 360 then
            angle = angle - 360
        elseif angle < 0 then
            angle = angle + 360
        end

        heading = angle + 0.0
    end

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }


    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }


    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end

    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }

    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }

    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

    SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
    PointCamAtCoord(cam, posToLook.x - 6.5, posToLook.y, coords.z + camOffset)

end