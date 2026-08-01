local Library = {}

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

function Library:CreateWindow(config)
    config = config or {}

    local self = setmetatable({}, Window)

    self.Title = config.Title or "Onyx Library"
    self.Size = config.Size or UDim2.new(0,520,0,320)

    return self
end

return Library

