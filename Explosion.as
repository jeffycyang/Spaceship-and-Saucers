package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Explosion extends MovieClip {
		
		private var timeframe:Number;
		private var timeshrink:Number;
		private var exploded:Boolean = false;
		
		private var expandtime:Number;
		private var contracttime:Number;
		
		//sets speed of explosion animation
		public var speedsetting:Number;
		
		private var rotatesetting:Number;
		
		public function Explosion(Number) {
			
			speedsetting = Number;
			
			//rotatesetting = 6 + speedsetting*(Math.random()*15);
			
			timeframe = 0;	
			timeshrink = 0;
			
			//readjust symbol size
			//scaleX = scaleX*0.15;
			//scaleY = scaleY*0.15;
			
			//declare what to show every frame
			//addEventListener(Event.ENTER_FRAME, explode);
		}
		
		//what who show every frame
		private function explode(event:Event):void {
			rotation += rotatesetting;
			y += 2;
			x += 5*Math.sin(timeframe);
			//timeframe += 1;
			timeframe += speedsetting;
			
			if ( timeframe < 5 ) {
				//animation
				//rotation = timeframe * 6;
				scaleX += 0.6*Math.sin(timeframe/5.09);
				scaleY += 0.6*Math.sin(timeframe/5.09);
				
				//timeframe += 1;
			} else if ( timeframe >= 5 && timeframe < 45 ) {
				//scaleX *= 1 - Math.sin(timeshrink/25);
				//scaleY *= 1 - Math.sin(timeshrink/25);
				scaleX *= Math.cos(timeshrink/51);
				scaleY *= Math.cos(timeshrink/51);
				//timeshrink += 1;
				timeshrink += speedsetting;
				//timeframe += 1;
			} else {
				removeEventListener(Event.ENTER_FRAME, explode);
                dispatchEvent(new Event("Explosion_Complete"));
			}
		}
		
		public function commence():void {
			rotatesetting = 6 + speedsetting*(Math.random()*20);
			addEventListener(Event.ENTER_FRAME, explode);
			//trace("speed : " + speedsetting);
		}
		
		public function renew():void {
			speedsetting = Math.floor(Math.random() * 4 + 1);
			timeframe = 0;
			timeshrink = 0;
			rotation = 0;
			width = 34.30;
			height = 28.10;
			//rotatesetting = 6 + speedsetting*(Math.random()*15);
		}
		
	}
}