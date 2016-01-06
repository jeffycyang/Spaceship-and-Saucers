package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Spaceship extends MovieClip {
		
		private var modtwo:int = 0;
		
		public var hit:Boolean = false;
		
		public function Spaceship() {
			addEventListener(Event.ENTER_FRAME, flicker);
		}
		
		private function flicker(event:Event):void {
			visible = true;
			
			modtwo = (modtwo + 1) % 4;

			if (hit) {
				if (modtwo == 0 || modtwo == 1) {
					visible = false;
				} else {
					visible = true;
				}
			}
		}
		
	}
}