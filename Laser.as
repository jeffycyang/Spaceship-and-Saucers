package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Laser extends Sprite {
		
		private var initialposition:Number;
		
		public function Laser() {
			//addEventListener(Event.ENTER_FRAME, fired);
		}
		
		private function fired(event:Event):void {
			y -= 20;
			
			if ( (initialposition - y) > 350) {
				removeEventListener(Event.ENTER_FRAME, fired);
				dispatchEvent(new Event("Laser_Complete"));
			}
		
		}
		
		public function commence():void {
			initialposition = y;
			addEventListener(Event.ENTER_FRAME, fired);
		}
		
		public function renew():void {
			null;
		}
		
	}
}