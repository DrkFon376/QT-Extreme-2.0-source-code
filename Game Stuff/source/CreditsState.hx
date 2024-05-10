//This is from the Psych Engine lol
package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['QT Mod Extreme Devs'],
		['DrkFon376',			'drkfon',			'Main Developer, Programmer and All New Stuff',		'https://www.youtube.com/channel/UCCVTns4b43V8Q5EON8xuSUQ',	0xFF0A408A],
		['Marshal',				'marshal',			'Help with Some New Animations and Art',			'https://twitter.com/Marshal_H1',			0xFF01C7A6],
		[''],
		['Special Contributors'],
		['NickZ',				'nick_z',			'Author of the CompotaHyper Sprites',				'https://gamebanana.com/members/1977536',	0xFFE66500],
		['JerPez',				'jerpez',			'Author of the BF Holding GF Sprites',				'https://gamebanana.com/members/1859117',	0xFFDF0000],
		[''],
		['Original QT Mod Team'],
		['Hazard24',			'hazard',			'Main Developer of the Original QT Mod',			'https://twitter.com/Hazard248',			0xFFFFFF00],
		['CountNightshade',		'nightshade',		'Artist of the Original QT Mod',					'https://twitter.com/CountNightshade',		0xFF000066],
		[''],
		['Kade Engine Development'],
		['KadeDev',				'kade',				'Kade Engine Programmer and Developer',				'https://twitter.com/kade0912',				0xFF0D9E35],
		[''],
		["Funkin' Crew"],
		['Ninjamuffin99',		'ninjamuffin99',	"Original Programmer of Friday Night Funkin'",		'https://twitter.com/ninja_muffin99',		0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Original Animator of Friday Night Funkin'",		'https://twitter.com/PhantomArcade3K',		0xFFFFBB1B],
		['Evilsk8r',			'evilsk8r',			"Original Artist of Friday Night Funkin'",			'https://twitter.com/evilsk8r',				0xFF53E52C],
		['KawaiSprite',			'kawaisprite',		"Original Composer of Friday Night Funkin'",		'https://twitter.com/kawaisprite',			0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuBGDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
				icon.antialiasing = true;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
