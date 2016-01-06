package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Saucer extends MovieClip {
		
		private var incrementer:Number = 0.1;
		public var randomsign1:Number = 1;
		public var randomsign2:Number = 1;
		public var hit:Boolean = false
		private var modfour:int = 0;
		private var j:int = 0;
		
		public function Saucer() {
			addEventListener(Event.ENTER_FRAME, fly);
		}
		
		//what happens every frame
		private function fly(event:Event):void {
			
			if (hit) {
				modfour = (modfour + 1) % 4;
				j += 1;
				if (modfour == 0 || modfour == 1) {
					visible = false;
				} else {
					visible = true;
				}
				
				if ( j == 24 ) {
					removeEventListener(Event.ENTER_FRAME, fly);
					dispatchEvent(new Event("Saucer_Death_Complete"));
				}
				
			} else {
			
			//*test with nooby movement
			
			//y = y + 1;
			
			//*end test
			
			//*real movement
			//random movement with increasing speed and undulation
			
			y = y + 1 + Math.log(incrementer)*Math.sin(incrementer/50) + Math.log(incrementer);
			x = x + (1 + 15*Math.sin(incrementer/10)*randomsign2 +  Math.log(incrementer))*randomsign1;
			
			//relocate when it disappears off screen
			
			if ( y > 350 ) {
				y = -20;
			}
			if ( x > 530 ) {
				x = -20;
			}
			if ( x < -25 ) {
				x = 520;
			}
			//*end real movement
			
			//hit detection
			//if ( Saucer.hitTest(Spaceship) ) {
				//draw hit animation and call it
				//respawn();
			//}
			
			incrementer += 1;
		}
		}
	}
}