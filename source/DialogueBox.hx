package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var bgbox:FlxSprite;

	var skipText:FlxText;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var backgroundImage:FlxSprite;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					{
						portraitLeft = new FlxSprite(-20, 40);
						portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
						portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
						portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
						portraitLeft.updateHitbox();
						portraitLeft.scrollFactor.set();
						add(portraitLeft);
						portraitLeft.visible = false;

						portraitRight = new FlxSprite(0, 40);
						portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
						portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
						portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
						portraitRight.updateHitbox();
						portraitRight.scrollFactor.set();
						add(portraitRight);
						portraitRight.visible = false;
						portraitRight.screenCenter(X);
					}
				default:
					{
						portraitLeft = new FlxSprite(0, 0);
						portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
						portraitLeft.animation.addByPrefix('enter', 'happy', 24, false);
						portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 1));
						portraitLeft.updateHitbox();
						portraitLeft.scrollFactor.set();
						add(portraitLeft);
						portraitLeft.visible = false;

						portraitRight = new FlxSprite(0, 0);
						portraitRight.frames = Paths.getSparrowAtlas('dialogue/bfportrait','shared');
						portraitRight.animation.addByPrefix('enter', 'default', 24, false);
						portraitRight.setGraphicSize(Std.int(portraitRight.width * 1));
						portraitRight.updateHitbox();
						portraitRight.scrollFactor.set();
						add(portraitRight);
						portraitRight.visible = false;

						portraitLeft.flipX = true;
						portraitLeft.screenCenter(X);
						portraitRight.screenCenter(X);

						portraitLeft.x += -380;
						portraitLeft.y += 120;
						portraitRight.x += 300;
						portraitRight.y += 240;
					}
			}
		box = new FlxSprite(-20, 45);
		bgbox = new FlxSprite(0, 0);
		
		var hasDialog = false;
		switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					{
						switch (PlayState.SONG.song.toLowerCase())
						{
							case 'senpai':
								hasDialog = true;
								box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
								box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
								box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
							case 'roses':
								hasDialog = true;
								FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

								box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
								box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
								box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

							case 'thorns':
								hasDialog = true;
								box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
								box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
								box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

								var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
								face.setGraphicSize(Std.int(face.width * 6));
								add(face);
								box.animation.play('normalOpen');
								box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
								box.updateHitbox();
								add(box);
						
								box.screenCenter(X);
						}
					}
				default:
					{
						hasDialog = true;
						box.frames = Paths.getSparrowAtlas('speech_bubble_talking','shared');
						box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
						box.animation.addByPrefix('normalIdle', 'speech bubble normal0', 24, true);
						box.animation.addByPrefix('loud', 'AHH speech bubble', 24, true);
						box.animation.play('normalOpen');
						box.setGraphicSize(Std.int(box.width * 1));
						box.updateHitbox();
						add(box);
						box.y += 350;
						box.screenCenter(X);
						box.x += 50;
					}
			}
		

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		


		if (!talkingRight)
		{
			 
		}

		backgroundImage = new FlxSprite();
		backgroundImage.x = 0;
		backgroundImage.y = 0;
		add(backgroundImage);
		backgroundImage.visible = false;

		bgbox.frames = Paths.getSparrowAtlas('bgdialogue','shared');
		bgbox.animation.addByPrefix('normalIdle', 'normal', 24, true);
		bgbox.animation.play('normalOpen');
		bgbox.setGraphicSize(Std.int(bgbox.width * 1));
		bgbox.updateHitbox();
		add(bgbox);
		bgbox.y += 430;
		bgbox.screenCenter(X);
		bgbox.visible = false;

		skipText = new FlxText(5, 695, 640, "Press ESCAPE to skip the dialogue.\n", 40);
		skipText.scrollFactor.set(0, 0);
		skipText.setFormat(Paths.font("VCR OSD Mono"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipText.borderSize = 2;
		skipText.borderQuality = 1;
		add(skipText);

		switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
					dropText.font = 'Pixel Arial 11 Bold';
					dropText.color = 0xFFD89494;
					add(dropText);

					swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
					swagDialogue.font = 'Pixel Arial 11 Bold';
					swagDialogue.color = 0xFF3F2021;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
					add(swagDialogue);

				default:
					dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 30);
					dropText.font = 'VCR OSD Mono';
					dropText.color = 0xFFD89494;
					add(dropText);

					swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 30);
					swagDialogue.font = 'VCR OSD Mono';
					swagDialogue.color = 0xFF3F2021;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
					add(swagDialogue);
			}
		

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normalIdle');
				dialogueOpened = true;
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
			{
				dialogueStarted = false;
				endinstantly();
			}
		
		if (!dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);
			enddialogue();
		}
		
		super.update(elapsed);
	}

	function endinstantly()
		{
			isEnding = true;
	
			if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
				FlxG.sound.music.fadeOut(2.2, 0);

			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				backgroundImage.alpha -= 1 / 5;
				bgbox.alpha -= 1 / 5;
				box.alpha -= 1 / 5;
				bgFade.alpha -= 1 / 5 * 0.7;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				swagDialogue.alpha -= 1 / 5;
				dropText.alpha = swagDialogue.alpha;
			}, 5);

			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				finishThing();
				kill();
			});
		}

	function enddialogue()
		{
			if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
	
						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
							FlxG.sound.music.fadeOut(2.2, 0);
	
						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							skipText.alpha -= 1 / 5;
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							portraitLeft.visible = false;
							portraitRight.visible = false;
							swagDialogue.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);
	
						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				}
		}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		switch (PlayState.SONG.noteStyle)
			{
				case 'pixel':
					{
						switch (curCharacter)
						{
							case 'dad':
								portraitRight.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.animation.play('enter');
								}
							case 'bf':
								portraitLeft.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.animation.play('enter');
								}
						}
					}
				default:
					{
						switch (curCharacter)
						{
							//BF STUFF
							case 'bf-default':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/bfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'default', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'bf-relaxed':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/bfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'relaxed', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'bf-worried':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/bfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'worried', 24, false);
									portraitRight.animation.play('enter');
								}


							//GF STUFF
							case 'gf-default':
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'default', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'gf-nervous':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'nervous', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'gf-happy':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'happy', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'gf-scared':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'scared', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'gf-terror':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'terror', 24, false);
									portraitRight.animation.play('enter');
								}
							case 'gf-sad':
								box.flipX = false;
								portraitRight.visible = false;
								if (!portraitRight.visible)
								{
									portraitRight.visible = true;
									portraitRight.frames = Paths.getSparrowAtlas('dialogue/gfportrait','shared');
									portraitRight.animation.addByPrefix('enter', 'sad', 24, false);
									portraitRight.animation.play('enter');
								}
							
							//SHURI STUFF
							case 'shuri-happy':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'happy', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'shuri-surprised':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'surprised', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'shuri-love':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'love', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'shuri-embarrassed':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'embarrassed', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'shuri-hurt':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'hurt', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'shuri-embarrassed':
								portraitLeft.y = 140;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/shuriportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'embarrassed', 24, false);
									portraitLeft.animation.play('enter');
								}
							
							//KEN STUFF
							case 'ken-neutral':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'neutral', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-tired':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'tired', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-aggressive':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'aggressive', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-closedeyes':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'closedeyes', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-happy':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'happy', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-laugh':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'laugh', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-love':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'love', 24, false);
									portraitLeft.animation.play('enter');
								}
							case 'ken-surprised':
								portraitLeft.y = 100;
								box.flipX = true;
								portraitLeft.visible = false;
								if (!portraitLeft.visible)
								{
									portraitLeft.visible = true;
									portraitLeft.frames = Paths.getSparrowAtlas('dialogue/kenportrait','shared');
									portraitLeft.animation.addByPrefix('enter', 'surprised', 24, false);
									portraitLeft.animation.play('enter');
								}
								
							//Misc stuff that is needed
							case 'showbackgroundimage':
								dropText.color = 0xFF000000;
								swagDialogue.color = 0xFFffffff;
								bgbox.visible = true;
								backgroundImage.loadGraphic(Paths.image('dialogue/' + dialogueList[0], 'shared'));
								enddialogue();
								backgroundImage.visible = true;
							case 'hidebackground':
								dropText.color = 0xFFD89494;
								swagDialogue.color = 0xFF3F2021;
								bgbox.visible = false;
								enddialogue();
								backgroundImage.visible = false;
							case 'hideleft':
								portraitLeft.visible = false;
								enddialogue();
							case 'hideright':
								portraitRight.visible = false;
								enddialogue();
						}
					}
			}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
