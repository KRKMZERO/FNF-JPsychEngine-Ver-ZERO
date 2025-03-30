--動画撮影用に使ってるカットしやすくするためのluaです
function onCreate()

	makeLuaSprite('EngineText', 'Engine', screenWidth - 250 -10 ,10);
	addLuaSprite('EngineText', false);
	scaleObject('EngineText', 0.5, 0.5);
	setObjectCamera('EngineText', 'other')--hud or other
	setProperty('EngineText.alpha', 0.5)
	setProperty('EngineText.antialiasing', true);
	setObjectOrder('EngineText', 10);

	if BlackOutEnd == true then
		endSong()
	end
end

local BlackOutEnd = false

function onTimerCompleted(tag, loops, loopsLeft)
		if tag == 'Blacktime' then
		BlackOutEnd = true
		endSong()
		end
end

function onEndSong()
		if not BlackOutEnd and not isStoryMode then
			cameraFade("other", "000000", 1, true)
			runTimer('Blacktime', 3, 1)
			return Function_Stop
		end
	return Function_Continue
end
