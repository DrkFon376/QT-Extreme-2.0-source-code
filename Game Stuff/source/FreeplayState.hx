package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var messageText:FlxText;
	var messageText2:FlxText;
	var messageText3:FlxText;
	var messageText4:FlxText;
	var messageBG:FlxSprite;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			if(!(data[0]=='Extermination') && !(data[0]=='Cessation') && !(data[0]=='Expurgation')){ //Add everything to the song list which isn't Extermination, Cessation and Expurgation.
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			}
			else if(FlxG.save.data.terminationUnlocked && data[0]=='Extermination') //If the list picks up Termination, check if its unlocked before adding.
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			else if(FlxG.save.data.terminationBeaten && data[0]=='Cessation') //If the list picks up Cessation, check if its unlocked before adding.
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
			else if(FlxG.save.data.cessationBeaten && data[0]=='Expurgation') //If the list picks up Expurgation, check if its unlocked before adding.
				songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
		}

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		messageText = new FlxText(scoreText.x -170, scoreText.y +100, 0, "You need to beat", 40);
		messageText.font = scoreText.font;

		messageText2 = new FlxText(scoreText.x -150, scoreText.y +144, 0, "the whole week", 40);
		messageText2.font = scoreText.font;

		messageText3 = new FlxText(scoreText.x -88, scoreText.y +188, 0, "to unlock", 40);
		messageText3.font = scoreText.font;

		messageText4 = new FlxText(scoreText.x -172, scoreText.y +232, 0, "Extermination :)", 40);
		messageText4.font = scoreText.font;
	
		messageBG = new FlxSprite(messageText.x -35, 75).makeGraphic(Std.int(FlxG.width * 0.35), 236, 0xFF000000);
		messageBG.alpha = 0.6;
		add(messageBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);
		add(messageText);
		add(messageText2);
		add(messageText3);
		add(messageText4);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		if(songs[curSelected].songName.toLowerCase()=="censory-superload" && !(FlxG.save.data.terminationUnlocked)){
			messageText.visible = true;
			messageText2.visible = true;
			messageText3.visible = true;
			messageText4.visible = true;
			messageBG.visible = true;
		}
		
		if(!(songs[curSelected].songName.toLowerCase()=="censory-superload")){
			messageText.visible = false;
			messageText2.visible = false;
			messageText3.visible = false;
			messageText4.visible = false;
			messageBG.visible = false;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if(!(songs[curSelected].songName.toLowerCase()=="extermination")){	//Only allow the difficulty to be changed if the song isn't termination.
		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);
		}

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			if((songs[curSelected].songName.toLowerCase()=='extermination') && !(FlxG.save.data.terminationUnlocked)){
				trace("lmao, access denied idiot!");
			}
			else if((songs[curSelected].songName.toLowerCase()=='cessation') && !(FlxG.save.data.terminationBeaten)){
				trace("lmao, access denied idiot! Prove yourself first mortal.");
			}
			else if((songs[curSelected].songName.toLowerCase()=='expurgation') && !(FlxG.save.data.cessationBeaten)){
				trace("lmao, access denied idiot! Prove yourself first mortal and... aren't you forgetting to pass a song?");
			}
			else
			{
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

				trace(poop);

				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
				PlayState.storyWeek = songs[curSelected].week;
				trace('CUR WEEK' + PlayState.storyWeek);
				LoadingState.loadAndSwitchState(new PlayState());
			}
		}
	}

	function changeDiff(change:Int = 0)
	{
		if(songs[curSelected].songName.toLowerCase()=="extermination")
		{
			curDifficulty = 2; //Force it to hard difficulty.
			if(FlxG.save.data.terminationUnlocked)
				diffText.text = "EXTREME";
			else
				diffText.text = "LOCKED";
			#if !switch
			intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
			#end
			
		}
		else if(songs[curSelected].songName.toLowerCase()=="tutorial")
			{
				curDifficulty = 2; //Force it to hard difficulty.
					diffText.text = "???";
				#if !switch
				intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
				#end
				
			}
		else if(songs[curSelected].songName.toLowerCase()=="cessation")
		{
			curDifficulty = 1; //Force it to normal difficulty.
			if(FlxG.save.data.terminationBeaten)
				diffText.text = "HARD?";
			else
				diffText.text = "LOCKED";
			#if !switch
			intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
			#end
		}
		else if(songs[curSelected].songName.toLowerCase()=="expurgation")
			{
				curDifficulty = 2; //Force it to hard difficulty.
				if(FlxG.save.data.cessationBeaten)
					diffText.text = "VERY HARD? IDK";
				else
					diffText.text = "LOCKED";
				#if !switch
				intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
				#end
			}
		else if(songs[curSelected].songName.toLowerCase()=="censory-superload")
		{
			curDifficulty = 2; //Force it to hard difficulty.
				diffText.text = "VERY HARD";
			#if !switch
			intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
			#end
		}
		else if(songs[curSelected].songName.toLowerCase()=="carefree")
			{
				curDifficulty = 2; //Force it to hard difficulty.
					diffText.text = "HARD";
				#if !switch
				intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
				#end
			}
		else if(songs[curSelected].songName.toLowerCase()=="careless")
		{
			curDifficulty = 2; //Force it to hard difficulty.
				diffText.text = "HARD";
			#if !switch
			intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
			#end
		}
		else
		{
			curDifficulty += change;

			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;

			switch (curDifficulty)
			{
				case 0:
					diffText.text = "EASY";
				case 1:
					diffText.text = 'NORMAL';
				case 2:
					diffText.text = "HARD";
			}
		}

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end		
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;


		/*
		if(songs[curSelected].songName.toLowerCase()=="termination"){ //For forcing the difficulty text to update, and forcing it to hard when selecting Termination -Haz
			changeDiff(0);
		}else{                                                      //Used for reseting the difficulty text back.
			changeDiff(0) ;
		}*/

		//In hindsight, the above code was fucking retarded since it just leads to the same outcome. -Haz
		changeDiff(0);

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		// lerpScore = 0;
		#end

		#if PRELOAD_ALL
		FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
