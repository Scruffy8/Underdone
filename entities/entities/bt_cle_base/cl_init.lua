include('shared.lua')
include('lib_pac3compat.lua')

function ENT:Initialize()
	self.c_mdl = CreatePropModel()
	self.c_mdl:SetData(self.mdlData)
end
	
function ENT:Draw()
	--self.Entity:DrawModel()
	if self.c_mdl then
		self.c_mdl:SetUpModels()
	end
end

