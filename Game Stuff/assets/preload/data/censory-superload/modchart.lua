function start(song) -- do nothing

end

function update(elapsed)
    if difficulty == 2 then
		if curBeat>=704 and curBeat<832 then
			local currentBeat = (songPos / 1000)*(bpm/60)
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + 10 * math.sin((currentBeat + i*0.25) * math.pi), i)
				setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
			end
		elseif curBeat>=896 and curBeat<960 then
			local currentBeat = (songPos / 1000)*(bpm/60)
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + 10 * math.sin((currentBeat + i*0.25) * math.pi), i)
			end
		else
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'],i)
				setActorY(_G['defaultStrum'..i..'Y'],i)
			end
		end
	elseif difficulty == 1 then
		if curBeat>=704 and curBeat<832 then
			local currentBeat = (songPos / 1000)*(bpm/60)
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + 8 * math.sin((currentBeat + i*0.25) * math.pi), i)
			end
		else
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'],i)
			end
		end
	end
end

function beatHit(beat) -- do nothing

end

function stepHit(step)

	if curStep == 48 then
		kbAttackTOGGLE(true)
		kbAlertTOGGLE(true)
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 52 then
		kbAttackAlert(false)
	end
	if curStep == 56 then
		kbAttack(true)
	end
	if curStep == 912 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 916 then
		kbAttackAlert(false)
	end
	if curStep == 920 then
		kbAttack(true)
	end
	if curStep == 1072 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 1076 then
		kbAttackAlert(false)
	end
	if curStep == 1080 then
		kbAttack(true)
	end
	if curStep == 1200 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 1204 then
		kbAttackAlert(false)
	end
	if curStep == 1208 then
		kbAttack(true)
	end
	if curStep == 1968 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 1972 then
		kbAttackAlert(false)
	end
	if curStep == 1976 then
		kbAttack(true)
	end
	if curStep == 2096 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2100 then
		kbAttackAlert(false)
	end
	if curStep == 2104 then
		kbAttack(true)
	end
	if curStep == 2176 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2180 then
		kbAttackAlert(false)
	end
	if curStep == 2184 then
		kbAttack(true)
	end
	if curStep == 2208 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2212 then
		kbAttackAlert(false)
	end
	if curStep == 2216 then
		kbAttack(true)
	end
	if curStep == 2240 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2244 then
		kbAttackAlert(false)
	end
	if curStep == 2248 then
		kbAttack(true)
	end
	if curStep == 2256 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2260 then
		kbAttackAlert(false)
	end
	if curStep == 2264 then
		kbAttack(true)
	end
	if curStep == 2276 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2280 then
		kbAttackAlert(false)
	end
	if curStep == 2284 then
		kbAttack(true)
	end
	if curStep == 2288 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2292 then
		kbAttackAlert(false)
	end
	if curStep == 2296 then
		kbAttack(true)
	end
	if curStep == 2304 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2308 then
		kbAttackAlert(false)
	end
	if curStep == 2312 then
		kbAttack(true)
	end
	if curStep == 2320 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2324 then
		kbAttackAlert(false)
	end
	if curStep == 2328 then
		kbAttack(true)
	end
	if curStep == 2340 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2344 then
		kbAttackAlert(false)
	end
	if curStep == 2348 then
		kbAttack(true)
	end
	if curStep == 2352 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2356 then
		kbAttackAlert(false)
	end
	if curStep == 2360 then
		kbAttack(true)
	end
	if curStep == 2496 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2500 then
		kbAttackAlert(false)
	end
	if curStep == 2504 then
		kbAttack(true)
	end
	if curStep == 2512 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2516 then
		kbAttackAlert(false)
	end
	if curStep == 2520 then
		kbAttack(true)
	end
	if curStep == 2544 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2548 then
		kbAttackAlert(false)
	end
	if curStep == 2552 then
		kbAttack(true)
	end
	if curStep == 2560 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2564 then
		kbAttackAlert(false)
	end
	if curStep == 2568 then
		kbAttack(true)
	end
	if curStep == 2576 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2580 then
		kbAttackAlert(false)
	end
	if curStep == 2584 then
		kbAttack(true)
	end
	if curStep == 2608 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2612 then
		kbAttackAlert(false)
	end
	if curStep == 2616 then
		kbAttack(true)
	end
	if curStep == 2672 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2676 then
		kbAttackAlert(false)
	end
	if curStep == 2680 then
		kbAttack(true)
	end
	if curStep == 2704 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2708 then
		kbAttackAlert(false)
	end
	if curStep == 2712 then
		kbAttack(true)
	end
	if curStep == 2880 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2884 then
		kbAttackAlert(false)
	end
	if curStep == 2888 then
		kbAttack(true)
	end
	if curStep == 2912 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2916 then
		kbAttackAlert(false)
	end
	if curStep == 2920 then
		kbAttack(true)
	end
	if curStep == 2944 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2948 then
		kbAttackAlert(false)
	end
	if curStep == 2952 then
		kbAttack(true)
	end
	if curStep == 2956 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2960 then
		kbAttackAlert(false)
	end
	if curStep == 2964 then
		kbAttack(true)
	end
	if curStep == 2976 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2980 then
		kbAttackAlert(false)
	end
	if curStep == 2984 then
		kbAttack(true)
	end
	if curStep == 2988 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 2992 then
		kbAttackAlert(false)
	end
	if curStep == 2996 then
		kbAttack(true)
	end
	if curStep == 3008 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3012 then
		kbAttackAlert(false)
	end
	if curStep == 3016 then
		kbAttack(true)
	end
	if curStep == 3024 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3028 then
		kbAttackAlert(false)
	end
	if curStep == 3032 then
		kbAttack(true)
	end
	if curStep == 3040 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3044 then
		kbAttackAlert(false)
	end
	if curStep == 3048 then
		kbAttack(true)
	end
	if curStep == 3056 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3060 then
		kbAttackAlert(false)
	end
	if curStep == 3064 then
		kbAttack(true)
	end
	if curStep == 3168 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3172 then
		kbAttackAlert(false)
	end
	if curStep == 3176 then
		kbAttack(true)
	end
	if curStep == 3216 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3220 then
		kbAttackAlert(false)
	end
	if curStep == 3224 then
		kbAttack(true)
	end
	if curStep == 3248 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3252 then
		kbAttackAlert(false)
	end
	if curStep == 3256 then
		kbAttack(true)
	end
	if curStep == 3312 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3316 then
		kbAttackAlert(false)
	end
	if curStep == 3320 then
		kbAttack(true)
	end
	if curStep == 3360 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3364 then
		kbAttackAlert(false)
	end
	if curStep == 3368 then
		kbAttack(true)
	end
	if curStep == 3376 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3380 then
		kbAttackAlert(false)
	end
	if curStep == 3384 then
		kbAttack(true)
	end
	if curStep == 3412 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3416 then
		kbAttackAlert(false)
	end
	if curStep == 3420 then
		kbAttack(true)
	end
	if curStep == 3424 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3428 then
		kbAttackAlert(false)
	end
	if curStep == 3432 then
		kbAttack(true)
	end
	if curStep == 3440 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3444 then
		kbAttackAlert(false)
	end
	if curStep == 3448 then
		kbAttack(true)
	end
	if curStep == 3584 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3588 then
		kbAttackAlert(false)
	end
	if curStep == 3592 then
		kbAttack(true)
	end
	if curStep == 3596 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3600 then
		kbAttackAlert(false)
	end
	if curStep == 3604 then
		kbAttack(true)
	end
	if curStep == 3616 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3620 then
		kbAttackAlert(false)
	end
	if curStep == 3624 then
		kbAttack(true)
	end
	if curStep == 3628 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3632 then
		kbAttackAlert(false)
	end
	if curStep == 3636 then
		kbAttack(true)
	end
	if curStep == 3648 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3652 then
		kbAttackAlert(false)
	end
	if curStep == 3656 then
		kbAttack(true)
	end
	if curStep == 3664 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3668 then
		kbAttackAlert(false)
	end
	if curStep == 3672 then
		kbAttack(true)
	end
	if curStep == 3680 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3684 then
		kbAttackAlert(false)
	end
	if curStep == 3688 then
		kbAttack(true)
	end
	if curStep == 3692 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3696 then
		kbAttackAlert(false)
	end
	if curStep == 3700 then
		kbAttack(true)
	end
	if curStep == 3888 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3892 then
		kbAttackAlert(false)
	end
	if curStep == 3896 then
		kbAttack(true)
	end
	if curStep == 3952 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3956 then
		kbAttackAlert(false)
	end
	if curStep == 3960 then
		kbAttack(true)
	end
	if curStep == 3984 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 3988 then
		kbAttackAlert(false)
	end
	if curStep == 3992 then
		kbAttack(true)
	end
	if curStep == 4016 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 4020 then
		kbAttackAlert(false)
	end
	if curStep == 4024 then
		kbAttack(true)
	end
	if curStep == 4048 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 4052 then
		kbAttackAlert(false)
	end
	if curStep == 4056 then
		kbAttack(true)
	end
	if curStep == 4080 then
		kbAttackAlert(false)
		kbAttack(false)
	end
	if curStep == 4084 then
		kbAttackAlert(false)
	end
	if curStep == 4088 then
		kbAttack(true)
	end

end
	
function playerTwoTurn()

end

function playerOneTurn()

end

function playerOneMiss()

end

function playerOneSing()

end

function playerTwoSing()

end