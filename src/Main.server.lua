-- Main: Entry point for the server-side game logic.

local ServerScriptService = game:GetService("ServerScriptService")

-- Create the map
local Map = require(ServerScriptService.Server.Map)
Map:Create()

-- Load the event registry to register all events
require(ServerScriptService.Server.EventRegistry)

-- Start the game manager
local GameManager = require(ServerScriptService.Server.GameManager)
GameManager:Initialize()
GameManager:Start()
