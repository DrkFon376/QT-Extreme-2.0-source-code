package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";
	var TerminationText:FlxSprite;

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'bf-with-gf':
				daBf = 'bf-with-gf';
			case 'compota':
				daBf = 'compota';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		if(PlayState.deathBySawBlade){
			//For telling the player how to dodge in Termination.
			//I'm telling the player how to dodge after they've first died to the first saw blade to also communicate that sawblades = instant death.
			//UPDATE - Tutorial text on TV screens now. This isn't necessary, but might as well reuse this for a custom "funny death" animation. -Haz
			TerminationText = new FlxSprite();
			TerminationText.frames = Paths.getSparrowAtlas('bonus/sawkillanimation2');
			TerminationText.animation.addByPrefix('normal', 'kb_attack_animation_kill_idle', 24, true);
			TerminationText.animation.addByPrefix('animate', 'kb_attack_animation_kill_moving', 24, true);
			TerminationText.x = x-1175; //negative = left
			TerminationText.y = y+135; //positive = down
			TerminationText.antialiasing = true;
			TerminationText.animation.play("normal");
			add(TerminationText);
		}

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			if (PlayState.SONG.player1 == 'bf-with-gf')
				{
					bf.animation.play('deathLoop');
				}
			if (PlayState.SONG.player1 == 'compota')
				{
					bf.animation.play('deathLoop');
				}
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			if(PlayState.deathBySawBlade){
				TerminationText.animation.play("animate");
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			/*
			if(PlayState.deathBySawBlade){ //In case player retries early.
				TerminationText.visible = true;
			}*/
			isEnding = true;
			bf.playAnim('deathConfirm', true);
				if (PlayState.SONG.player1 == 'bf-with-gf')
				{
					bf.animation.play('deathConfirm');
				}
				if (PlayState.SONG.player1 == 'compota')
				{
					bf.animation.play('deathConfirm');
				}
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
