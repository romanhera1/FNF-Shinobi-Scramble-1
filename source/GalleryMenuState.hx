package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class GalleryMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var description:Array<String> = [
		"Artwork done to announce an update that fixed a couple things.",
		"Initial concept for the ninja hideaway's background.",
		"A quick doodle of Hex ballin' with the girls and Whitty",
		"First concepts of Shuri and Ken",
		"Sketch of Girlfriend and Boyfriend hanging with Ken.",
		"Concepts of Ken's poses.",
		"Concepts of Shuri's poses.",
		"Initial concepts of Shuri's expressions.",
		"Initial concepts of Ken's expressions.",
		"Thumbnail for the teaser video on YouTube.",
		"Sketch of Girlfriend and Boyfriend hanging with Shuri.",
		"Promotional artwork done by Steel (@EmissarySteel on Twitter)"
	];
	public var money:FlxText;

	public var credit1:FlxSprite;
	public var credit2:FlxSprite;
	public var credit3:FlxSprite;
	public var credit4:FlxSprite;
	public var credit5:FlxSprite;
	public var credit6:FlxSprite;
	public var credit7:FlxSprite;
	public var credit8:FlxSprite;
	public var credit9:FlxSprite;
	public var credit10:FlxSprite;
	public var credit11:FlxSprite;
	public var credit12:FlxSprite;


	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Extras Menu", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF404040);
		add(bg);

		var arrow:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image("extras/laziest left and right you'll ever see", 'shared'));
		arrow.scrollFactor.x = 0;
		arrow.scrollFactor.y = 0;
		arrow.setGraphicSize(Std.int(bg.width * 1));
		arrow.updateHitbox();
		arrow.screenCenter();
		arrow.antialiasing = true;
		add(arrow);
		
		credit1 = new FlxSprite().loadGraphic(Paths.image('extras/1-2-1 update', 'shared'));
		credit1.scrollFactor.x = 0;
		credit1.scrollFactor.y = 0.10;
		credit1.setGraphicSize(Std.int(credit1.width * .5));
		credit1.updateHitbox();
		credit1.screenCenter();
		credit1.visible = true;
		credit1.antialiasing = true;
		add(credit1);

		credit2 = new FlxSprite().loadGraphic(Paths.image('extras/background concept sketch', 'shared'));
		credit2.scrollFactor.x = 0;
		credit2.scrollFactor.y = 0.10;
		credit2.setGraphicSize(Std.int(credit2.width * .3));
		credit2.updateHitbox();
		credit2.screenCenter();
		credit2.visible = false;
		credit2.antialiasing = true;
		add(credit2);

		credit3 = new FlxSprite().loadGraphic(Paths.image('extras/hex doodle', 'shared'));
		credit3.scrollFactor.x = 0;
		credit3.scrollFactor.y = 0.10;
		credit3.setGraphicSize(Std.int(credit3.width * .3));
		credit3.updateHitbox();
		credit3.screenCenter();
		credit3.visible = false;
		credit3.antialiasing = true;
		add(credit3);

		credit4 = new FlxSprite().loadGraphic(Paths.image('extras/initial concept sketches', 'shared'));
		credit4.scrollFactor.x = 0;
		credit4.scrollFactor.y = 0.10;
		credit4.setGraphicSize(Std.int(credit4.width * .3));
		credit4.updateHitbox();
		credit4.screenCenter();
		credit4.visible = false;
		credit4.antialiasing = true;
		add(credit4);

		credit5 = new FlxSprite().loadGraphic(Paths.image('extras/ken and gf doodle', 'shared'));
		credit5.scrollFactor.x = 0;
		credit5.scrollFactor.y = 0.10;
		credit5.setGraphicSize(Std.int(credit5.width * .3));
		credit5.updateHitbox();
		credit5.screenCenter();
		credit5.visible = false;
		credit5.antialiasing = true;
		add(credit5);

		credit6 = new FlxSprite().loadGraphic(Paths.image('extras/Ken sketches', 'shared'));
		credit6.scrollFactor.x = 0;
		credit6.scrollFactor.y = 0.10;
		credit6.setGraphicSize(Std.int(credit6.width * .4));
		credit6.updateHitbox();
		credit6.screenCenter();
		credit6.visible = false;
		credit6.antialiasing = true;
		add(credit6);

		credit7 = new FlxSprite().loadGraphic(Paths.image('extras/Shuri sketches', 'shared'));
		credit7.scrollFactor.x = 0;
		credit7.scrollFactor.y = 0.10;
		credit7.setGraphicSize(Std.int(credit7.width * .4));
		credit7.updateHitbox();
		credit7.screenCenter();
		credit7.visible = false;
		credit7.antialiasing = true;
		add(credit7);

		credit8 = new FlxSprite().loadGraphic(Paths.image('extras/portrait expressions_Shurisketch', 'shared'));
		credit8.scrollFactor.x = 0;
		credit8.scrollFactor.y = 0.10;
		credit8.setGraphicSize(Std.int(credit8.width * .2));
		credit8.updateHitbox();
		credit8.screenCenter();
		credit8.visible = false;
		credit8.antialiasing = true;
		add(credit8);

		credit9 = new FlxSprite().loadGraphic(Paths.image('extras/portrait expressions-ken sketch', 'shared'));
		credit9.scrollFactor.x = 0;
		credit9.scrollFactor.y = 0.10;
		credit9.setGraphicSize(Std.int(credit9.width * .2));
		credit9.updateHitbox();
		credit9.screenCenter();
		credit9.visible = false;
		credit9.antialiasing = true;
		add(credit9);

		credit10 = new FlxSprite().loadGraphic(Paths.image('extras/shinobi scramble teaser thumb (yt)', 'shared'));
		credit10.scrollFactor.x = 0;
		credit10.scrollFactor.y = 0.10;
		credit10.setGraphicSize(Std.int(credit10.width * .8));
		credit10.updateHitbox();
		credit10.screenCenter();
		credit10.visible = false;
		credit10.antialiasing = true;
		add(credit10);

		credit11 = new FlxSprite().loadGraphic(Paths.image('extras/log doodle', 'shared'));
		credit11.scrollFactor.x = 0;
		credit11.scrollFactor.y = 0.10;
		credit11.setGraphicSize(Std.int(credit11.width * .3));
		credit11.updateHitbox();
		credit11.screenCenter();
		credit11.visible = false;
		credit11.antialiasing = true;
		add(credit11);

		credit12 = new FlxSprite().loadGraphic(Paths.image('extras/shuri_ken_juno', 'shared'));
		credit12.scrollFactor.x = 0;
		credit12.scrollFactor.y = 0.10;
		credit12.setGraphicSize(Std.int(credit12.width * .3));
		credit12.updateHitbox();
		credit12.screenCenter();
		credit12.visible = false;
		credit12.antialiasing = true;
		add(credit12);

		money = new FlxText(0, 680, 0, "", 32);
		money.alignment = CENTER;
		money.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		money.screenCenter(X);
		add(money);

		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	override function update(elapsed:Float)
	{
		money.text = description[curSelected];
		switch (curSelected)
			{
				case 0:
					{
						money.screenCenter(X);
						credit1.visible = true;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 1:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = true;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 2:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = true;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 3:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = true;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 4:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = true;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 5:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = true;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 6:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = true;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 7:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = true;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 8:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = true;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 9:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = true;
						credit11.visible = false;
						credit12.visible = false;
					}
				case 10:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = true;
						credit12.visible = false;
					}
				case 11:
					{
						money.screenCenter(X);
						credit1.visible = false;
						credit2.visible = false;
						credit3.visible = false;
						credit4.visible = false;
						credit5.visible = false;
						credit6.visible = false;
						credit7.visible = false;
						credit8.visible = false;
						credit9.visible = false;
						credit10.visible = false;
						credit11.visible = false;
						credit12.visible = true;
					}
			}
		#if debug
		trace(curSelected);
		#end
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_LEFT)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_RIGHT)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.LEFT)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new ExtraMenuState());
			}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= 12)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = 12 - 1;
	}
}
