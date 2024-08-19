BOTtextB = false
function onUpdatePost(elapsed)

	RPC = getProperty('ratingPercent')
	Acc = math.floor((RPC*100)*100)/100;

	local  timeElapsed = math.floor(getProperty('songTime')/1000)
	local  timeTotal = math.floor(getProperty('songLength')/1000)
	local timeElapsedFixed = string.format("%.2d:%.2d", timeElapsed/60%60, timeElapsed%60)
	local timeTotalFixed = string.format("%.2d:%.2d", timeTotal/60%60, timeTotal%60)

	formatted_score = format_int(score)

	if botPlay == false then
		if getProperty('songMisses') == 0 then
			setTextString('scoreTxt',"スコア:" ..formatted_score.. ' 精度:'..math.floor((RPC*100)*100)/100 ..'%');
		else
			setTextString('scoreTxt',"スコア:" ..formatted_score.. ' ミス:'..getProperty('songMisses')..' 精度:'..math.floor((RPC*100)*100)/100 ..'%');
		end
	elseif botPlay == true then
		if BOTtextB == false then
			setTextString('scoreTxt',"オートプレイ");
		elseif BOTtextB == true then
			setTextString('scoreTxt',timeElapsedFixed .. '/' .. timeTotalFixed);
		end
	end

	setProperty('scoreTxt.antialiasing', true)
end
function onSongStart()
	if botPlay == true then
	doTweenAlpha('scoreTxtTween1','scoreTxt',0,1.5,'circOut')
	end
end
function onTweenCompleted(tag)
	if tag == 'scoreTxtTween1' then
		if BOTtextB == true then
			BOTtextB = false
		elseif BOTtextB == false then
			BOTtextB = true
		end
		doTweenAlpha('scoreTxtTween2','scoreTxt',1,1.5,'circOut')
		runTimer('switch',3)
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'switch' then
		doTweenAlpha('scoreTxtTween1','scoreTxt',0,1.5,'circOut')
	end
end
function format_int(number)

  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  -- reverse the int-string and append a comma to all blocks of 3 digits
  int = int:reverse():gsub("(%d%d%d)", "%1,")

  -- reverse the int-string back remove an optional comma and put the 
  -- optional minus and fractional part back
  return minus .. int:reverse():gsub("^,", "") .. fraction
end