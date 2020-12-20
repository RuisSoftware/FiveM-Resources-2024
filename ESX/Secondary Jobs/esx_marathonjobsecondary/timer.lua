--
-- github.com/IndianaBonesUrMom/
-- Simple Fivem Stopwatch with ms precision
-- I personally use this for multiple esx scripts, such as esx_rallyjob, esx_runner, esx_bicycle and esx_sickness
--

FiveWatch = {}

FiveWatch.__index = FiveWatch

function FiveWatch.new(name)
	local self = setmetatable({}, FiveWatch)
	self.name = name
	self.startTimes = {}
	self.endTimes = {}
	return self
end

FiveWatch.GetName = function(self, key) return self.name end 

FiveWatch.StartTimer = function(self, key) self.startTimes[key] = GetGameTimer() return self.startTimes[key] end

FiveWatch.GetStartTime = function(self, key) if self.startTimes[key] ~= nil then return self.startTimes[key] end return -1 end

FiveWatch.GetTime = function(self, key) if self.startTimes[key] ~= nil then return GetGameTimer() - self.startTimes[key] end return -1 end

FiveWatch.SaveTime = function(self, key) if self.startTimes[key] ~= nil then self.endTimes[key] = GetGameTimer() - self.startTimes[key] return self.endTimes[key] end return -1 end

FiveWatch.RemoveTime = function(self, key) self.endTimes[key] = nil self.startTimes[key] = nil end
	
FiveWatch.GetSavedTime = function(self, key) if self.endTimes[key] ~= nil then return self.endTimes[key] end return -1 end

--
-- Documentation 
-- 
-- 1. local MyWatch = FiveWatch.new('Name of my watch')
--   
--    ::Creates a new 'instance' of FiveWatch. -> returns self
--    ::Name is optional and serves no purpose at all. Just there for the lulz
--
-- 2. MyWatch.StartTimer('pizzatimer')
--
--    repeat HeatOven() until chicken == nuggets
--    
--    MyWatch.StartTimer('eggtimer')
--    
--    ::Saves the starting time of pizzatimer and eggtimer. 
--    
-- 3. local ChickenCoockTime = MyWatch.GetStartTime('pizzatimer') - MyWatch.GetStartTime('eggtimer')
--
--    ::GetStartTime returns the GameTimer value and thus Chicken.CoockTime is the time ti too
--    
---   to be continued....