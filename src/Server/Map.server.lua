-- Map: Creates the game map, including the lobby and main event area.

local Map = {}

function Map:Create()
    -- Create the lobby
    local lobby = Instance.new("Part")
    lobby.Name = "Lobby"
    lobby.Size = Vector3.new(100, 1, 100)
    lobby.Position = Vector3.new(0, 0, 0)
    lobby.Anchored = true
    lobby.BrickColor = BrickColor.new("Bright green")
    lobby.Parent = workspace

    -- Create the main map area
    local mainMap = Instance.new("Part")
    mainMap.Name = "MainMap"
    mainMap.Size = Vector3.new(200, 1, 200)
    mainMap.Position = Vector3.new(0, 20, 0)
    mainMap.Anchored = true
    mainMap.BrickColor = BrickColor.new("Earth green")
    mainMap.Parent = workspace

    -- Create a spawn location for the lobby
    local lobbySpawn = Instance.new("SpawnLocation")
    lobbySpawn.Name = "LobbySpawn"
    lobbySpawn.Position = Vector3.new(0, 5, 0)
    lobbySpawn.Anchored = true
    lobbySpawn.Parent = lobby
end

return Map
