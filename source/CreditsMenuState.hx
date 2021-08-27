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

class CreditsMenuState extends MusicBeatState
{
	var curSelected:Int = 0;
	var curSelectedtwo:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = ['twitter', 'youtube', 'kickstater', 'donate', 'github'];

	var creditShit:Array<String> = ['juno', 'jorge', 'fnfdev', 'kade', 'moddingplus'];

	public static var nightly:String = "";

	var idlebop:FlxSprite;
	var camFollow:FlxObject;

	var credit_icons:FlxSprite;
	var credit_text:FlxSprite;
	var socials:FlxSprite;
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

		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('extras/credits/credits_bg_bg_only', 'shared'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		idlebop = new FlxSprite();
		idlebop.frames = Paths.getSparrowAtlas('extras/credits/credits_bg_audience_only', 'shared');
		idlebop.animation.addByPrefix("idle", "Symbol 1", 24, false);
		idlebop.scrollFactor.x = 0;
		idlebop.scrollFactor.y = 0;
		idlebop.setGraphicSize(Std.int(bg.width * 1));
		idlebop.animation.play("idle");
		idlebop.antialiasing = true;
		idlebop.updateHitbox();
		add(idlebop);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		credit_text = new FlxSprite(0, 10);
		credit_text.frames = Paths.getSparrowAtlas('extras/credits/icons/credit_names', 'shared');
		credit_text.animation.addByPrefix("jorge", "Jorge", 24, false);
		credit_text.animation.addByPrefix("juno", "Juno", 24, false);
		credit_text.animation.addByPrefix("fnfdev", "fnfdev", 24, false);
		credit_text.animation.addByPrefix("kade", "kade", 24, false);
		credit_text.animation.addByPrefix("moddingplus", "moddingplus", 24, false);
		credit_text.scrollFactor.x = 0;
		credit_text.scrollFactor.y = 0;
		credit_text.screenCenter(X);
		credit_text.x = 20;
		credit_text.setGraphicSize(Std.int(bg.width * 1));
		credit_text.animation.play("juno");
		credit_text.antialiasing = true;
		credit_text.updateHitbox();
		add(credit_text);

		socials = new FlxSprite(0, 380);
		socials.frames = Paths.getSparrowAtlas('extras/credits/icons/socials', 'shared');
		socials.animation.addByPrefix("donate", "donate", 24, false);
		socials.animation.addByPrefix("github", "github", 24, false);
		socials.animation.addByPrefix("kickstarter", "kickstarter", 24, false);
		socials.animation.addByPrefix("twitter", "twitter", 24, false);
		socials.animation.addByPrefix("youtube", "youtube", 24, false);
		socials.scrollFactor.x = 0;
		socials.scrollFactor.y = 0;
		socials.screenCenter(X);
		socials.x = 260;
		socials.setGraphicSize(Std.int(bg.width * .6));
		socials.animation.play("juno");
		socials.antialiasing = true;
		socials.updateHitbox();
		add(socials);

		credit_icons = new FlxSprite(0, 50);
		credit_icons.frames = Paths.getSparrowAtlas('extras/credits/icons/icons', 'shared');
		credit_icons.animation.addByPrefix("jorge", "icon_jorge", 24, false);
		credit_icons.animation.addByPrefix("juno", "icon_juno", 24, false);
		credit_icons.animation.addByPrefix("fnfdev", "icon_fnfdev", 24, false);
		credit_icons.animation.addByPrefix("kade", "icon_kade", 24, false);
		credit_icons.animation.addByPrefix("moddingplus", "icon_moddingplus", 24, false);
		credit_icons.scrollFactor.x = 0;
		credit_icons.scrollFactor.y = 0;
		credit_icons.setGraphicSize(Std.int(bg.width * 0.3));
		credit_icons.screenCenter(X);
		credit_icons.x = 450;
		credit_icons.animation.play("juno");
		credit_icons.antialiasing = true;
		credit_icons.updateHitbox();
		add(credit_icons);



		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();
		Conductor.changeBPM(102);

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		
		var daChoice:String = optionShit[curSelected];
		var daCredit:String = creditShit[curSelectedtwo];

		Conductor.songPosition = FlxG.sound.music.time;
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		switch (curSelectedtwo)
				{
					case 0:
						credit_icons.animation.play("juno");
						credit_text.animation.play("juno");
					case 1:
						credit_icons.animation.play("jorge");
						credit_text.animation.play("jorge");
					case 2:
						credit_icons.animation.play("fnfdev");
						credit_text.animation.play("fnfdev");
					case 3:
						credit_icons.animation.play("kade");
						credit_text.animation.play("kade");
					case 4:
						credit_icons.animation.play("moddingplus");
						credit_text.animation.play("moddingplus");
				}
		
		if (daCredit == 'moddingplus')
			{
				socials.animation.play("github");
			}
			else
				{
				switch (curSelected)
					{
						case 0:
							socials.animation.play("twitter");
						case 1:
							socials.animation.play("youtube");
						case 2:
							socials.animation.play("kickstarter");
						case 3:
							socials.animation.play("donate");
						case 4:
							socials.animation.play("github");
					}
				}
		

		#if debug
			trace(daChoice);
		#end

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			// This is for the credit person smile
			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_LEFT)
				{
					curSelected = 0;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changecredit(-1);
				}
				if (gamepad.justPressed.DPAD_RIGHT)
				{
					curSelected = 0;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changecredit(1);
				}
			}

			if (FlxG.keys.justPressed.LEFT)
			{
				curSelected = 0;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changecredit(-1);
			}

			if (FlxG.keys.justPressed.RIGHT)
			{
				curSelected = 0;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changecredit(1);
			}

			//this is the social :)
			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new ExtraMenuState());
			}

			if (controls.ACCEPT)
			{
				goToState();
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];
		var daCredit:String = creditShit[curSelectedtwo];

		switch (daChoice)
		{
			case 'twitter':
				switch (daCredit)
					{
						case 'moddingplus':
							fancyOpenURL("https://github.com/FunkinModdingPlus/ModdingPlus");
						case 'jorge':
							fancyOpenURL("https://twitter.com/Jorge_SunSpirit");
						case 'juno':
							fancyOpenURL("https://twitter.com/JunoSongsYT");
						case 'kade':
							fancyOpenURL("https://twitter.com/KadeDeveloper");
						case 'fnfdev':
							fancyOpenURL("https://twitter.com/ninja_muffin99");
					}
			case 'youtube':
				switch (daCredit)
					{
						case 'juno':
							fancyOpenURL("https://www.youtube.com/channel/UCmam9sOUvleO0HFkhq0KLJg");
						case 'fnfdev':
							fancyOpenURL("https://www.youtube.com/channel/UC_fpxqB2Rb3hHP6e6kiqVbA");
					}
			case 'kickstarter':
				fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game");
			case 'donate':
				fancyOpenURL("https://ninja-muffin24.itch.io/funkin");
			case 'github':
				switch (daCredit)
					{
						case 'moddingplus':
							fancyOpenURL("https://github.com/FunkinModdingPlus/ModdingPlus");
						case 'kade':
							fancyOpenURL("https://github.com/KadeDev/Kade-Engine");
						case 'fnfdev':
							fancyOpenURL("https://github.com/ninjamuffin99/Funkin");
					}
		}
	}

	override function beatHit()
		{
			super.beatHit();
	
			idlebop.animation.play('idle');
			FlxG.log.add(curBeat);
		}

	
	function changecredit(huh:Int = 0)
		{
			curSelectedtwo += huh;

			if (curSelectedtwo >= 5)
				curSelectedtwo = 0;
			if (curSelectedtwo < 0)
				curSelectedtwo = 5 - 1;

			/*
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
	
				if (spr.ID == curSelected && finishedFunnyMove)
				{
					spr.animation.play('selected');
					camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				}
	
				spr.updateHitbox();
			});*/
		}
	

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;
		var daCredit:String = creditShit[curSelectedtwo];

		//lets make this hella unoptimized
		switch (daCredit)
			{
				case 'juno':
					if (curSelected >= 2)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = 1;
				case 'jorge':
					if (curSelected > 0)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = 0;
				case 'fnfdev':
					if (curSelected >= 5)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = 5 - 1;
				case 'kade':
					if (curSelected >= 5)
						curSelected = 0;

					if (curSelected == 4 || curSelected == 3)
						curSelected = 0;
					if (curSelected == 1)
						curSelected = 4;

					if (curSelected < 0)
						curSelected = 5 - 1;
				case 'moddingplus':
					if (curSelected >= 5)
						curSelected = 4;
					if (curSelected < 5)
						curSelected = 5 - 1;
			}

			/*
		if (curSelected >= 5)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = 5 - 1;
			*/
		/*
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});*/
	}
}
