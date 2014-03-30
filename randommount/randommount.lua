local slots_flying_mount, slots_ground_mount, slots_water_mount = {}, {}, {}

for i = 1, GetNumCompanions("MOUNT") do
  local _,name,_,_,_,typeID = GetCompanionInfo("MOUNT", i)

  if typeID == 15 or typeID == 31 then -- flying mounts
    slots_flying_mount[#slots_flying_mount + 1] = i
  elseif typeID == 29 then -- ground mounts
    slots_ground_mount[#slots_ground_mount + 1] = i
  elseif typeID == 12 then -- water mounts
    slots_water_mount[#slots_water_mount + 1] = i
  end

end

if IsMounted() == nil then
  local slotID

  if IsFlyableArea() then
    slotID = slots_flying_mount[random(#slots_flying_mount)]
  else
    if IsSwimming() and #slots_water_mount > 0 then
      slotID = slots_water_mount[random(#slots_water_mount)]
    else
      slotID = slots_ground_mount[random(#slots_ground_mount)]
    end
  end

  CallCompanion("MOUNT", slotID)
else
  Dismount()
end

