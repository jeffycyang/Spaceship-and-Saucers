package code {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import CollisionTest;
	
	public class ShipandSaucers extends MovieClip {
		var titledisplay:Title = new Title();

		var startbutton:Start_Button = new Start_Button();

		var spaceship:Spaceship = new Spaceship();

		var saucer1:Saucer = new Saucer();
		
		var collisiontest:CollisionTest = new CollisionTest();
		
		var game_time:TextField = new Game_Time();

		var exploding:Explosion;
		var inc:int;
		var numexp:int = 5;
		var life1:Life = new Life();
		var life2:Life = new Life();
		var life3:Life = new Life();

		var numlives:int;

		var firsttime:Boolean = true;
		var playedonce:Boolean = false;
		var gamerunning:Boolean = false;
		
		var gameover:Game_Over = new Game_Over();
		var restartbutton:Restart_Button = new Restart_Button();
		
		var spaceshipdummyx:Number;
		var spaceshipdummyy:Number;
		var explodedummyx:Number = 0;
		var explodedummyy:Number = 0;
		var saucerdummyx:Number = 0
		var saucerdummyy:Number = 0
		var explodingdummyx:Number = 0;
		var explodingdummyy:Number = 0;
		
		//for easing
		var speed:Number = 3;
		
		var laserArray:Array = new Array();
		//var maxlasers:int = 20;
		
		//var saucerexplode:Saucer_Explosion;
		var saucerexplodedummyx:Number = 0;
		var saucerexplodedummyy:Number = 0;
		//var saucerexplodeArray:Array = new Array();
		
		public static var theStage:Stage;
		
		//for object pool*
		public var explosionpool:UnboundedObjectPool = new UnboundedObjectPool(createExplosion, cleanExplosion);
		
		public var laserpool:UnboundedObjectPool = new UnboundedObjectPool(createLaser, cleanLaser);
		
		public var saucerexplosioneffectpool:UnboundedObjectPool = new UnboundedObjectPool(createSaucerExplosionEffect, cleanSaucerExplosionEffect);
		//*end
		
		//var fuckthis:TextField;
		
		public function ShipandSaucers() {
			
			theStage = this.stage;
			
			addChild(titledisplay);
			titledisplay.x = 242.35;
			titledisplay.y = 104.35;
			addChild(startbutton);
			startbutton.x = 237.15;
			startbutton.y = 231.80;
			startbutton.addEventListener(MouseEvent.CLICK, startGame);			
		}
		
		protected function startGame(event:MouseEvent):void {
			gamerunning = true;
			spaceshipdummyx = 242.45;
			spaceshipdummyy = 261.20;
			
			if (firsttime) {
				removeChild(titledisplay);
				removeChild(startbutton);
				startbutton.removeEventListener(MouseEvent.CLICK, startGame);	
				firsttime = false;
			}
			
			if (playedonce) {
				removeChild(gameover);
				removeChild(restartbutton);
				restartbutton.removeEventListener(MouseEvent.CLICK, startGame);
			}

			game_time = new Game_Time();
			addChild(game_time);
			game_time.x = 375;
			game_time.y = 5;

			addChild(spaceship);
			spaceship.x = 242.45;
			spaceship.y = 261.20;
			
			addChild(life1);
			life1.x = 398;
			life1.y = 300;
			
			addChild(life2);
			life2.x = 428;
			life2.y = 300;
			addChild(life3);
			life3.x = 458;
			life3.y = 300;
			
			addChild(saucer1);	
			saucer1.x = 60;
			saucer1.y = 30;
			saucer1.addEventListener("Saucer_Death_Complete", respawn);
			
			numlives = 3;

			addEventListener(Event.ENTER_FRAME, enterframeHandler);

			stage.addEventListener(MouseEvent.MOUSE_DOWN, fireLaser);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, moveShip);
			
			
			//for object pool*
			//explosionpool = new UnboundedObjectPool(createExplosion, cleanExplosion);
			//*end
			
		}
		
		//what happens every frame
		protected function enterframeHandler(event:Event):void {
			
			if ( 0 < mouseX && mouseX < 480 && 0 < mouseY && mouseY < 320 ) {
				spaceshipdummyx = mouseX;
				spaceshipdummyy = mouseY;
			
			//if (gamerunning) {
			}
				//spaceship.x = spaceshipdummyx;
				//spaceship.y = spaceshipdummyy;
				spaceship.x -= (spaceship.x - spaceshipdummyx)/speed;	//easing
				spaceship.y -= (spaceship.y - spaceshipdummyy)/speed;
			//}

			if ( gamerunning ) {
				
			if ( saucer1.hit == false ) {
				
			if ( collisiontest.exampleCollide(saucer1, spaceship) ) {
				//stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveShip);
				gamerunning = false;

				var timeout:Timer = new Timer(750,1);
				timeout.addEventListener(TimerEvent.TIMER, moveAgain);
				timeout.start();
				
				spaceship.hit = true;
				
				removeEventListener(Event.ENTER_FRAME, enterframeHandler);
				explodeeffect();
				spaceship.x = 242.45;
				spaceship.y = 261.20;
				spaceshipdummyx = 242.45;
				spaceshipdummyy = 261.20;
			}
			
			}
			
			}
			
			//for (var i:int = 0; i < laserArray.length; i++) {
				//if ( laserArray[i].y < -10 ) {
					//removeChild(laserArray[i]);
					//laserArray.splice(i,1);
				//}
			//}
			
			for (var j:int = 0; j < laserArray.length; j++) {
				
				//so that saucer explosion effect only occurs once
				if ( saucer1.hit == false ) {
				
				if ( collisiontest.exampleCollide(saucer1, laserArray[j]) ) {
					
					//var saucerexplode = new Saucer_Explosion( 1 );
					//addChild(saucerexplode);
					//*
					
					
					//saucerexplodedummyx = saucer1.x;
					//saucerexplodedummyy = saucer1.y;
					var saucerexplosioneffect:Saucer_Explosion_Effect;
					saucerexplosioneffect = saucerexplosioneffectpool.checkOut();
					addChild(saucerexplosioneffect);
					saucerexplosioneffect.x = saucer1.x;
					saucerexplosioneffect.y = saucer1.y;
					saucerexplosioneffect.commence();
					saucerexplosioneffect.addEventListener("Saucer_Explosion_Effect_Complete", removeSaucerExplosionEffect);
					
					//*
					//saucerexplode.x = saucerexplodedummyx;
					//saucerexplode.y = saucerexplodedummyy;
					
					//var explodetimeout:Timer = new Timer(50, 4);
					//explodetimeout.addEventListener(TimerEvent.TIMER, saucerexplodeeffect);
					//explodetimeout.start();
					
					var item:Object;
					
					//saucerexplodeeffect();
					//removeChild(laserArray[j]);
					//laserArray[j].removeEventListener("Laser_Complete", removeLaser);
					
					item = laserArray[j];					
					laserpool.checkIn(item);
					
					laserArray.splice(j,1);
					saucer1.hit = true;
					//respawn();
				}
				
				}
			}
			
		}
		
		//public function moveShip(event:MouseEvent):void {
			//spaceship.x = mouseX;
			//spaceship.y = mouseY;
			//}
			
		private function respawn(e:Event):void {
			e.currentTarget.removeEventListener("Saucer_Death_Complete", removeExplosion);
			removeChild(e.currentTarget as Saucer);
			saucer1 = new Saucer();
			addChild(saucer1);
			saucer1.addEventListener("Saucer_Death_Complete", respawn);
			//make respawn RANDOM!!!
			saucer1.randomsign1 = Math.pow(-1,Math.floor(Math.random()*2+1));
			saucer1.randomsign2 = Math.pow(-1,Math.floor(Math.random()*2+1));
			saucer1.x = Math.random()*480;
			saucer1.y = -20;
		}
		
		public function fireLaser(event:MouseEvent):void {
			
			var laser:Laser;
			laser = laserpool.checkOut();
			
			if(laser != null) {
				addChild(laser);
				laser.x = spaceship.x;
				laser.y = spaceship.y;
				laser.commence();
				laser.addEventListener("Laser_Complete", removeLaser);
			
			//*old working code
			//if ( laserArray.length < 20 ) {
			//var laser:Laser = new Laser();
			//addChild(laser);
			//laser.x = spaceship.x;
			//laser.y = spaceship.y;
			laserArray.push(laser);
			trace("laser " + laserArray.length);
			}
			//*end
		}
		
		public function explodeeffect():void {
			//position the explosion
			//*old working code
			//explodedummyx = spaceship.x;
			//explodedummyy = spaceship.y;
			//saucerdummyx = saucer1.x;
			//saucerdummyy = saucer1.y;
			//exploding = new Explosion(1);
			//addChild(exploding);
			//exploding.x = (saucerdummyx + explodedummyx)/2;
			//exploding.y = (saucerdummyy + explodedummyy)/2;
			//exploding.commence();
			//exploding.addEventListener("Explosion_Complete", removeMainExplosion);
			//explodingdummyx = exploding.x;
			//explodingdummyy = exploding.y;
			//*end
			
			explodedummyx = spaceship.x;
			explodedummyy = spaceship.y;
			saucerdummyx = saucer1.x;
			saucerdummyy = saucer1.y;
			exploding = explosionpool.checkOut();
			
			if(exploding != null) {
				addChild(exploding);
				exploding.speedsetting = 1;
				exploding.x = (saucerdummyx + explodedummyx)/2;
				exploding.y = (saucerdummyy + explodedummyy)/2;
				exploding.commence();
				exploding.addEventListener("Explosion_Complete", removeExplosion);
				explodingdummyx = exploding.x;
				explodingdummyy = exploding.y;
				//trace("item created" + explosionpool.arraylength);
			}
			
			for ( inc = 0; inc < 4; inc++){
				//trace( inc );
				var exexploding:Explosion;
				exexploding = explosionpool.checkOut();
				if(exexploding != null) {
					//trace("reusing");
					//setupExplosion(exexploding);
					
					addChild(exexploding);
					exexploding.scaleX *= Math.random()*0.3;
					exexploding.scaleY *= Math.random()*0.3;
					exexploding.x = explodingdummyx + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
					exexploding.y = explodingdummyy + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
					exexploding.commence();
					exexploding.addEventListener("Explosion_Complete", removeExplosion);
					//trace("item created" + explosionpool.arraylength);
				}
				
				
				//*old working code
				//var exexploding:Explosion = new Explosion(Math.floor(Math.random() * 4 + 1));
				//addChild(exexploding);
				//*time delay? no overlap?
				//exexploding.scaleX *= Math.random()*0.3;
				//exexploding.scaleY *= Math.random()*0.3;
				//exexploding.x = explodingdummyx + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
				//exexploding.y = explodingdummyy + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
				//exexploding.addEventListener("Explosion_Complete", removeExplosion);
				//*end
			}			
			removeLife();
		}
		
		//public function saucerexplodeeffect(event:TimerEvent):void {
			//for (var k:int = 0; k < 5; k++) {
			//if ( k < 5) {
				//saucerexplodeArray
				//var exsaucerexplode:Saucer_Explosion = new Saucer_Explosion( 0.3 + Math.random()*0.3 );
				//addChild(exsaucerexplode);
				//var saucerscale:Number = 0.3 + Math.random()*0.3;
				//exsaucerexplode.scaleX *= saucerscale;
				//exsaucerexplode.scaleY *= saucerscale;
				//exsaucerexplode.x = saucerexplodedummyx + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
				//exsaucerexplode.y = saucerexplodedummyy + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
			//}
			//}
		//}
		
		public function moveAgain(event:TimerEvent):void {
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, moveShip);
			//gamerunning = true;
			addEventListener(Event.ENTER_FRAME, enterframeHandler);
			var timeout2:Timer = new Timer(1250,1);
			timeout2.addEventListener(TimerEvent.TIMER, resumeGame);
			timeout2.start();
		}
		
		public function resumeGame(event:TimerEvent):void {
			spaceship.hit = false;
			//addEventListener(Event.ENTER_FRAME, enterframeHandler);
			gamerunning = true;
		}
		
		private function removeExplosion(e:Event):void {
			var item:Object;
			e.currentTarget.removeEventListener("Explosion_Complete", removeExplosion);
            removeChild(e.currentTarget as Explosion);
			item = e.currentTarget;
			explosionpool.checkIn(item);
			//trace("item returned" + explosionpool.arraylength);
			//*old working code
			//e.currentTarget.removeEventListener("Explosion_Complete", removeExplosion);
            //removeChild(e.currentTarget as Explosion);
			//*change this somehow?? exploded += 1 , IF NUMBER OF EXPLOSTIONS > ...
			//numexp -= 1;
			//if ( numexp == 0 ) {
				//numexp = 5;
				//*addEventListener(Event.ENTER_FRAME, enterframeHandler);
			//}
			//*end
        }
		
		private function removeSaucerExplosionEffect(e:Event):void {
			var item:Object;
			e.currentTarget.removeEventListener("Saucer_Explosion_Effect_Complete", removeSaucerExplosionEffect);
            removeChild(e.currentTarget as Saucer_Explosion_Effect);
			item = e.currentTarget;
			saucerexplosioneffectpool.checkIn(item);
			//trace("item returned" + saucerexplosioneffectpool.arraylength);
			
		}
		
		private function removeLaser(e:Event) {
			var item:Object;
			e.currentTarget.removeEventListener("Laser_Complete", removeLaser);
			removeChild(e.currentTarget as Laser);
			item = e.currentTarget;
			laserpool.checkIn(item);
			trace("item returned" + laserpool.arraylength);
		}
		
		private function removeLife():void {
			if ( numlives == 3 ) {
				removeChild(life1);
				numlives = numlives - 1;
				
				//removeChild(fuckthis);
				
			} else if ( numlives == 2 ) {
				removeChild(life2);
				numlives = numlives - 1;
			} else {
				removeChild(life3);
				gameOver();
			}
		}
		
		public function gameOver():void {
			removeChild(saucer1);
			saucer1.removeEventListener("Saucer_Death_Complete", respawn);
			removeChild(spaceship);
			removeChild(game_time);
			removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, fireLaser);
			
			spaceship.hit = false;
			
			playedonce = true;
			
			addChild(gameover);
			gameover.x = 241.90;
			gameover.y = 93.35;
			addChild(restartbutton);
			restartbutton.x = 241.15;
			restartbutton.y = 215.65;
			restartbutton.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function setupExplosion(item:Explosion) {
			addChild(item);
			item.scaleX *= Math.random()*0.3;
			item.scaleY *= Math.random()*0.3;
			item.x = explodingdummyx + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
			item.y = explodingdummyy + Math.random()*50*Math.pow(-1,Math.floor(Math.random()*2+1));
			item.commence();
			item.addEventListener("Explosion_Complete", removeExplosion);
		}
		
		//for object pool*
		public function createExplosion():Explosion {
			return new Explosion(Math.floor(Math.random() * 4 + 1));
			//trace("clean : item");
        }

        public function cleanExplosion(item:Explosion):void {
            //trace("clean : " + item);
			item.renew();
        }
		//*end
		
		private function removeMainExplosion(e:Event):void {

			e.currentTarget.removeEventListener("Explosion_Complete", removeExplosion);
            removeChild(e.currentTarget as Explosion);

        }
		
		public function createSaucerExplosionEffect():Saucer_Explosion_Effect {
			return new Saucer_Explosion_Effect;
		}
		
		public function cleanSaucerExplosionEffect(item:Saucer_Explosion_Effect):void {
			item.renew();
		}
		
		public function createLaser():Laser {
			return new Laser;
		}
		
		public function cleanLaser(item:Laser):void {
			item.renew();
			//trace("laser return" + laserpool.arraylength);
		}
		
	}
}