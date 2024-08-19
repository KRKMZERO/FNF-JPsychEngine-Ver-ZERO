--動画撮影用に使ってるカットしやすくするためのluaです
function onCreate()
	makeLuaSprite('Black','',-10,-10)
	makeGraphic('Black', 1300, 800, '000000')
	addLuaSprite('Black')
	setProperty('Black.alpha', 0)
	setObjectCamera('Black', 'other')
	setObjectOrder('Black', 900);

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
			doTweenAlpha('BlackTween', 'Black', 1, 1, linear)
			runTimer('Blacktime', 3, 1)
			return Function_Stop
		end
	return Function_Continue
end
