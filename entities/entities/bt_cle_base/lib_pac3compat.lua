local meta = {}

function meta:SetData(data)
	self.mdlData = data
	print('data set')
end

local tempindex
local function part_draw(part, parent)
	print(part.self.Class or tempindex)
end

local function parse_part_data(part, parent)
	parent = part_draw(part, parent)
	for key, part in pairs(part.children) do
		tempindex = tempindex + 1
		parse_part_data(part, parent)
	end	
end

function meta:SetUpModels()
	if CLIENT then
		if self.mdlData then			
			tempindex = 1	
			for key, part in pairs(self.mdlData) do
				parse_part_data(part, NULL)
			end	
		else
			-- no data
			return
		end
	end
end

function meta:GetPos(vec)
	return self.mdlPos
end
function meta:GetAngles(ang)
	return self.mdlAng
end
function meta:SetPos(vec)
	self.mdlPos = vec
end
function meta:SetAngles(ang)
	self.mdlAng = ang
end

function meta:GetPartPos(uid)
end
function meta:GetPartAng(uid)
end
function meta:SetPartPos(uid)
end
function meta:SetPartAng(uid)
end
meta.__index = meta
function CreatePropModel()
	local data = {}
	data.mdlPos = Vector(0, 0, 0)
	data.mdlAng = Angle(0, 0, 0)
	data = setmetatable(data, meta)
	return data
end