Config = {
    Locations = {
        {
            Name = "Valentine",
            RobText = 'Press [~e~G~q~] to break into the Valentine safe',
            Coordinates = { x = 233.43, y = 991.45, z = 189.48 },
            Items = {
                "goldbar",
                "diamond",
            },
        },
        {
            Name = "Rhodes",
            RobText = 'Press [~e~G~q~] to break into the Rhodes safe',
            Coordinates = { x = -310.31, y = 775.43, z = 118.80 },
            Items = {
                "goldbar",
                "diamond",
            },
        },
        -- Add more locations as needed
    },
    
    -- Timer and zone size
    ZoneSize = 2.0, -- Sizes of the zones
    LockpickTime = 30000, -- in milliseconds
    PoliceAlert = 5000, -- in ms
    Cooldown = 120000, -- Cooldown between robberies

    -- Blips
    BlipRhodes = false, -- Default set to false, if you change from true to false server will need a restart to clear the blip
    BlipValentine = false, -- Default set to false, if you change from true to false server will need a restart to clear the blip

    NPCType = "CS_johnmarston", -- Type/model of the NPC
    NPCLocation = { x = 1589.78, y = -1838.80, z = 51.50 }, -- Coordinates of the NPC's location
}


