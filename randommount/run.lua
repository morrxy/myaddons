/run local s1,sg,ss={},{},{};local st={};local sms={ 30174,64731,98718,75207 };local sm={ 118089 };local function IsSeaMount(cs) for _,value in ipairs(sms) do if value == cs then return true;end;end;return false;end;local function ism(cs) for _,value in ipairs(sm) do if value == cs then return true;end;end;return false;end;for i=1,GetNumCompanions("MOUNT") do local _,name,spellID,_,_,typeID=GetCompanionInfo("MOUNT",i);if typeID == 7 or typeID == 15 or typeID == 23 or typeID == 31 then s1[#s1 + 1]={ slot=i,name=name,};end;if typeID == 12 or IsSeaMount(spellID) then ss[#ss + 1]={ slot=i,name=name,};end;if typeID == 23 or typeID == 29 or typeID == 31 then sg[#sg + 1]={ slot=i,name=name,};end;if ism(spellID) then st[#st + 1]={ slot=i,name=name,};end;end;if IsMounted() == nil then local slotID;if IsFlyableArea() then slotID=s1[random(#s1)].slot;else if IsSwimming() and #st > 0 then slotID=st[random(#st)].slot;else slotID=sg[random(#sg)].slot;end;end;CallCompanion("MOUNT",slotID);else Dismount();end;