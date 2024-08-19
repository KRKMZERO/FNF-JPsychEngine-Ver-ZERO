function onCreatePost()
	makeLuaSprite('EngineText', 'Engine', screenWidth - 250 -10 ,10);
	addLuaSprite('EngineText', false);
	scaleObject('EngineText', 0.5, 0.5);
	setObjectCamera('EngineText', 'other')--hud or other
	setProperty('EngineText.alpha', 0.5)
	setProperty('EngineText.antialiasing', true);
	setObjectOrder('EngineText', 10);
end