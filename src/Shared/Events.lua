-- Events: Manages the different events in the game.

local Events = {}
Events.RegisteredEvents = {}

function Events:RegisterEvent(event)
    table.insert(self.RegisteredEvents, event)
end

function Events:GetRandomEvent()
    if #self.RegisteredEvents > 0 then
        local randomIndex = math.random(1, #self.RegisteredEvents)
        return self.RegisteredEvents[randomIndex]
    end
    return nil
end

return Events
