
function GetTameableSpawnClasses()
	local spawn_classes
	spawn_classes = spawn_classes or ClassDescendantsList("SpawnObject")
	local tameable_spawn_classes = {false}
	for _,v in ipairs(spawn_classes) do
		if _G[v].Tameable then
			table.insert(tameable_spawn_classes, v)
			--table.insert(tameable_spawn_classes, {value = v, text = _G[v].DisplayName})
		end
	end
	return tameable_spawn_classes
end

function is_inside_of(box,pos)
	if box:Dist2(pos) == 0 then
		return true
	else
		return false
	end
end

DefineClass.GiveExpeditionTameRewardToSurvivor = {
	__parents = { "Effect", },
	__generated_by_class = "EffectDef",

	properties = {
		{ id = "SpawnClass", name = "Spawn class", help = "Tame to spawn.", editor = "choice", default = false, items = function () return GetTameableSpawnClasses() end, },
		{ id = "Name", name = "Tame name", help = "If Expedition will give a special name to this unit", editor = "text", default = false, translate = true, },
	},
	EditorView = Untranslated("Survivor finds and tames a <SpawnClass>"),
	Documentation = "Colony recieves a tamed animal",
	EditorNestedObjCategory = "Preset",
}

function GiveExpeditionTameRewardToSurvivor:__exec(obj, context)
	if not IsValid(obj) then return end
	obj:AddExpeditionTameReward(self.SpawnClass, self.Name)
end

function UnitExpedition:AddExpeditionTameReward(spawn_class,name)
	local balloon = IsValid(self.in_balloon) and self.in_balloon
	if balloon then
		balloon:AddExpeditionTameReward(spawn_class,name,self)
	end
end

function ExpeditionBalloon:AddExpeditionTameReward(spawn_class,name,unit)
	print("Added a tame reward to an expedition!")
	local to_add  = {class = spawn_class, name = name or "",who = unit}
	if not self.exp_tame_rewards then
		self.exp_tame_rewards = {}
	end
	table.insert(self.exp_tame_rewards, to_add)
end

function GiveExpeditionTameRewardToSurvivor:GetError()
	if not self.SpawnClass then
		return "Select a valid tameable creature"
	end
end

function Building:SpawnAround(class,who,name)
	print("Starting to spawn a unit around a building!")
    local spawn_def = SpawnDefs['spawn_nearby']
	local def = class and g_Classes[class]
	local instance = {}
	instance.SpawnClass = class
	instance.location = self
	instance.name = name or def.DisplayName
	if who and IsKindOf(def,'UnitAnimal') then
		instance.PostSpawn = function(self,obj,target,context)
				if not obj.Tameable then
					print("Animal can't be tamed")
					return
				end
				obj:CheatResearch()
				obj:Tame()
				Msg("AnimalTamed", nil, obj, true)
				if instance.name then
					obj.DisplayName = instance.name
				end
			end
	end
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t,{},100)
end




AppendClass.ExpeditionBalloon = {
	properties = {
		{ category = "reward", id = "exp_tame_rewards", name = "Tame Reward Array", default = {} },
	},
}

function ExpeditionBalloon:SpawnAround(class,who,name)
	print("Starting to spawn a unit around a building!")
    local spawn_def = SpawnDefs['spawn_nearby']
	local def = class and g_Classes[class]
	local instance = {}
	instance.SpawnClass = class
	instance.location = self
	instance.name = name or def.DisplayName
	if who and IsKindOf(def,'UnitAnimal') then
		instance.PostSpawn = function(self,obj,target,context)
				if not obj.Tameable then
					print("Animal can't be tamed")
					return
				end
				obj:CheatResearch()
				obj:Tame()
				Msg("AnimalTamed", nil, obj, true)
				if instance.name then
					obj.DisplayName = instance.name
				end
			end
	end
	spawn_def = spawn_def:CreateInstance(instance)
	local t = spawn_def:ResolveTarget()
	spawn_def:ActivateSpawn(t,{},100)
end

-- At this point in the code, we still know who the passenger is
function ExpeditionBalloon:DropExpeditionResources()
	print("Doing the usual expedition dropping of stuff!")
	local params = { jump_from = self , quiet = true}
	local drop = not self.destroyed_on_expedition
	if drop then
		local Resources = Resources
		local decays = self.reward_decays
		local function add_decay(per_item, max_health, amount, decay, res_info)
			if per_item then
				-- each item (1000 of a given resource) decays on its own
				local count = DivRound(amount or 0, const.ResourceScale)
				local decays = {}
				res_info.decay = decays
				for i = count, 1, -1 do
					decays[i] = decay
				end
			else
				res_info.decay = decay
			end
		end
		
		for res, amount in sorted_pairs(self.expedition_rewards) do
			if amount > 0 then
				local decay = decays and decays[res] or 0
				local res_info
				local res_def = Resources[res]
				local max_health = res_def.MaxHealth
				if max_health == 0 -- 0 is considered indestructible
				or decay < max_health then -- no need to spawn the resource at all if all has decayed
					if decay > 0 then
						res_info = {res = res, amount = amount}
						add_decay(res_def.PerItemHealth, max_health, amount, decay, res_info)
					end
					local amount_placed, used_piles = ProduceResource(nil, self, res, amount, res_info, params)
					AttachDeliveryObjectsToPiles(used_piles, nil, "ExpeditionRewardsDelivery")
				end
			end
		end
	end
	self.expedition_rewards = nil
	self.reward_decays = nil
	-- also drop any resources, which were brought as supplies for the expedition
	local pad = self.landing_pad
	for res, amount in sorted_pairs(pad.res_amounts) do
		if amount > 0 then
			pad:SubtractRes(res, amount)
			if drop then
				local amount_placed, used_piles = PlaceResourcePile(self, res, amount, nil, params)
				AttachDeliveryObjectsToPiles(used_piles, nil, "ExpeditionRewardsDelivery")
			end
		end
	end
	print("Giving tame rewards!")
	if #self.exp_tame_rewards then
		print("We have at least one tamed unit to spawn!")
		for _,tame in ipairs(self.exp_tame_rewards) do
			print("Trying to spawn a tamed "..tame.class.."!")
			self:SpawnAround(tame.class,tame.who,tame.name)
		end
	end
	self.exp_tame_rewards = {}
	print("Done with tame rewards!")
end