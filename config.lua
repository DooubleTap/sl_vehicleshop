-- Updated Config File
Config = {}

-- Showroom vehicle configurations
Config.ShowroomVehicles = {
    { -- I use nk cars so this is designed speficically for the vstr but it works the same for every other cars
        model = 'nkvstr', 
        coords = vector4(844.28, -1334.42, 25.13, 245.4), -- Display coordinates (x, y, z, heading)
        price = 5000, -- Vehicle price
        job = { name = 'police', grade = 2 }, -- Job restriction: police rank 3 and above
        customizations = {
            colours = { primary = 1, secondary = 0 }, -- Black
            livery = 0,
            tint = 2, -- Green tint
            upgrades = {
                engine = 3,
                brakes = 2,
                suspension = 2,
                turbo = 1,
                transmission = 3
            },
            -- Some vehicles do not have extras, some have less, some have move: 0 = enabled, 1 = disabled.
            extras = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 1, [6] = 1, [7] = 1, [8] = 1, [9] = 0,  }
        }
    },
    {
        model = 'police6',
        coords = vector4(844.06, -1340.38, 25.13, 243.17), 
        price = 5000, 
        job = { name = 'police', grade = 2 }, 
        customizations = {
            colours = { primary = 1, secondary = 0 }, 
            livery = 0,
            tint = 2, 
            upgrades = {
                engine = 3,
                brakes = 2,
                suspension = 2,
                turbo = 1,
                transmission = 3
            },
            extras = { [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 1, [6] = 1, [7] = 1, [8] = 1, [9] = 0,  }
        }
    } --if you add more, this last line does not contains a comma, but the others ones before the last should.
}