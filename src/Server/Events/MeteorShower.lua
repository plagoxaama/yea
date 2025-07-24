-- MeteorShower: An event where meteors fall from the sky.

local MeteorShower = {}
MeteorShower.Name = "Meteor Shower"
MeteorShower.Duration = 60 -- seconds

local METEOR_SPAWN_RATE = 0.5 -- meteors per second
local METEOR_DAMAGE = 50

function MeteorShower:Start()
    print(self.Name .. " event started!")
    self.StartTime = tick()
    self.LastMeteorSpawnTime = 0
end

function MeteorShower:IsFinished()
    if not self.StartTime then
        return false
    end

    local elapsedTime = tick() - self.StartTime
    if elapsedTime >= self.Duration then
        return true
    end

    -- Spawn meteors
    if elapsedTime - self.LastMeteorSpawnTime >= 1 / METEOR_SPAWN_RATE then
        self:SpawnMeteor()
        self.LastMeteorSpawnTime = elapsedTime
    end

    return false
end

function MeteorShower:SpawnMeteor()
    local meteor = Instance.new("Part")
    meteor.Name = "Meteor"
    meteor.Shape = Enum.PartType.Ball
    meteor.Size = Vector3.new(10, 10, 10)
    meteor.BrickColor = BrickColor.new("Black")
    meteor.Material = Enum.Material.Slate
    meteor.Position = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100))
    meteor.Parent = workspace

    -- Add a fire effect
    local fire = Instance.new("Fire")
    fire.Parent = meteor

    -- Damage players on touch
    meteor.Touched:Connect(function(otherPart)
        local character = otherPart.Parent
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:TakeDamage(METEOR_DAMAGE)
        end
    end)

    -- Remove the meteor after a while
    game.Debris:AddItem(meteor, 10)
end

return MeteorShower
