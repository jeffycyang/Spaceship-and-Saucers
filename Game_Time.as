package {

	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class Game_Time extends TextField {
		
		private var hrs:Number;
		private var min:Number;
		private var sec:Number;
		private var hrss:String;
		private var mins:String;
		private var secs:String;
		private var start_time:Number;
		private var elapsed_time:Number;
		
		//set text format
		private var timeFormat:TextFormat = new TextFormat();
		
		
		public function Game_Time() {
			timeFormat.size = 24;
			timeFormat.align = "right";
			timeFormat.bold = true;
			defaultTextFormat = timeFormat;
			
			//declare what to show every frame
			addEventListener(Event.ENTER_FRAME, timing);
			
			start_time = getTimer();
		}
		
		protected function timing(event:Event):void {
			
			elapsed_time = getTimer()-start_time;
			
			sec = Math.floor(elapsed_time/1000);
			secs = String(sec % 60);
			if (secs.length < 2) {
				secs = "0" + secs;
			}
			min = Math.floor(sec/60);
			mins = String(min % 60);
			if (mins.length < 2) {
				mins = "0" + mins;
			}
			hrs = Math.floor(min/60);
			hrss = String(hrs);
			if (hrss.length < 2) {
				hrss = "0" + hrss;
			}
			
			text = hrss + ":" + mins + ":" + secs;
		}
		
	}
}