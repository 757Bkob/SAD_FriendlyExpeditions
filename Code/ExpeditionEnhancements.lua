
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
	obj:add_tame_reward(self.SpawnClass,self.Name)
end

function GiveExpeditionTameRewardToSurvivor:GetError()
	if not self.SpawnClass then
		return "Select a valid tameable creature"
	end
end

function ExpeditionBalloon:add_tame_reward(spawn_class, custom_name)
	local to_add  = {class = spawn_class, name = custom_name or ""}
	if not self.tamelist then
		self.tamelist = {}
	end
	table.insert(self.tamelist, to_add)
	print(self.tamelist)
end

function Building:SpawnAround(class,friendly,name)
    local spawn_def = SpawnDefs['spawn_nearby']
	local def = class and g_Classes[class]
	local instance = {}
	instance.SpawnClass = class
	instance.location = self
	instance.name = name or def.DisplayName
	if friendly and IsKindOf(def,'UnitAnimal') then
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

local drop_res = ExpeditionBalloon.DropExpeditionResources

-- At this point in the code, we still know who the passenger is
function ExpeditionBalloon:DropExpeditionResources()
	drop_res()
	if #self.exp_tame_rewards then
		for _,tame in ipairs(self.exp_tame_rewards) do
			print("Trying to spawn a tamed "..tame.class.."!")
			self:SpawnAround(tame.class,true,self.passengers[1],tame.name)
		end
	end
	self.exp_tame_rewards = {}
end