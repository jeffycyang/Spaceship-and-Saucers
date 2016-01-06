package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Saucer_Explosion extends Sprite {
		
		//private var timelast:Number;
		private var timeframe:int = 0;
		public var scalesize:Number;
		private var randomrotation:Number;
		
		public function Saucer_Explosion(Number) {
			
			//alpha = 0;
			//scaleX = 0.1;
			//scaleY = 0.1;
			//set a final size instead!!
			scalesize = Number;
			//timelast = Number;
			
			//random rotation!!!
			randomrotation = (Math.pow(-1,Math.floor(Math.random()*2+1)))*12;		
		}
		
		private function saucer_explode(event:Event):void {
			rotation += randomrotation;
			if ( timeframe <= 7 ) {
				alpha += 1/7;
				scaleX += scalesize/30;
				scaleY += scalesize/30;
				timeframe += 1;
			} else if ( timeframe > 7 && timeframe <= 30 ) {
				alpha -= 1/22;
				scaleX += scalesize/30;
				scaleY += scalesize/30;
				timeframe += 1;
			} else if ( alpha > 0.06 ) {
				alpha -= 1/22;
			} else {
				removeEventListener(Event.ENTER_FRAME, saucer_explode);
				dispatchEvent(new Event("Saucer_Explosion_Complete"));
                //dispatchEvent(new Event("Saucer_Explosion_Complete"));
			}
		}
		
		public function commence():void {
			alpha = 0;
			scaleX = 0.1;
			scaleY = 0.1;
			addEventListener(Event.ENTER_FRAME, saucer_explode);
			//trace("speed : " + speedsetting);
			//trace(scalesize);
		}
		
		public function renew():void {
			scalesize = 0.3 + Math.random()*0.3;
			randomrotation = (Math.pow(-1,Math.floor(Math.random()*2+1)))*12;
			timeframe = 0;
			alpha = 0;
			rotation = 0;
			width = 36.05;
			height = 33.55;
		}
		
	}
}