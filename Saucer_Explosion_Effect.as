package {

	import flash.display.Sprite;
	import flash.events.Event;
	import code.ShipandSaucers;
	
	public class Saucer_Explosion_Effect extends Sprite {
		
		//private var saucerexplode:Saucer_Explosion;
		//public var xPosition:Number
		//public var yPosition:Number
		private var i:int = 0;
		
		public static var saucerexplosionpool:UnboundedObjectPool = new UnboundedObjectPool(createSaucerExplosion, cleanSaucerExplosion);
		
		public function Saucer_Explosion_Effect() {
			
			//var saucerexplode:Saucer_Explosion;
			//saucerexplode = saucerexplosionpool.checkOut();
			
			//if (saucerexplode != null) {
				//saucerexplode.scalesize = 1;
				//code.ShipandSaucers.theStage.addChild(saucerexplode);
				//saucerexplode.x = x;
				//saucerexplode.y = y;
				//saucerexplode.commence();
				//saucerexplode.addEventListener("Saucer_Explosion_Complete", removeSaucerExplosion);
			//}
			
			//addEventListener(Event.ENTER_FRAME, saucer_explode_effect);
			
		}
		
		private function saucer_explode_effect(event:Event):void {
			
			if ( i == 1 || i == 2|| i == 3 ) {
			
				var exsaucerexplode:Saucer_Explosion;
				exsaucerexplode = saucerexplosionpool.checkOut();
				
				if (exsaucerexplode != null) {
					code.ShipandSaucers.theStage.addChild(exsaucerexplode);			
					exsaucerexplode.x = x + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
					exsaucerexplode.y = y + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
					exsaucerexplode.commence();
					exsaucerexplode.addEventListener("Saucer_Explosion_Complete", removeSaucerExplosion);
				}
			}
			
			if ( i == 4 ) {
				var lastsaucerexplode:Saucer_Explosion;
				lastsaucerexplode = saucerexplosionpool.checkOut();
				
				if (lastsaucerexplode != null) {
					code.ShipandSaucers.theStage.addChild(lastsaucerexplode);			
					lastsaucerexplode.x = x + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
					lastsaucerexplode.y = y + Math.random()*45*Math.pow(-1,Math.floor(Math.random()*2+1));
					lastsaucerexplode.commence();
					lastsaucerexplode.addEventListener("Saucer_Explosion_Complete", removeSaucerExplosion);
					//dispatch removal
				}
			}
			
			i += 1;
			
			if ( i == 100 ) {
				removeEventListener(Event.ENTER_FRAME, saucer_explode_effect);
				dispatchEvent(new Event("Saucer_Explosion_Effect_Complete"));
			}
			
		}
		
		//private function removeMainSaucerExplosion(e:Event):void {
			//e.currentTarget.removeEventListener("Saucer_Explosion_Complete", removeMainSaucerExplosion);
            //code.ShipandSaucers.theStage.removeChild(e.currentTarget as Saucer_Explosion);
			//trace("main removed");
		//}
		
		public function commence():void {
			var saucerexplode:Saucer_Explosion;
			saucerexplode = saucerexplosionpool.checkOut();
			
			if (saucerexplode != null) {
				saucerexplode.scalesize = 1;
				code.ShipandSaucers.theStage.addChild(saucerexplode);
				saucerexplode.x = x;
				saucerexplode.y = y;
				saucerexplode.commence();
				saucerexplode.addEventListener("Saucer_Explosion_Complete", removeSaucerExplosion);
			}
			
			addEventListener(Event.ENTER_FRAME, saucer_explode_effect);
		}
		
		
		private function removeSaucerExplosion(e:Event):void {
			var item:Object;
			e.currentTarget.removeEventListener("Saucer_Explosion_Complete", removeSaucerExplosion);
            code.ShipandSaucers.theStage.removeChild(e.currentTarget as Saucer_Explosion);
			item = e.currentTarget;
			saucerexplosionpool.checkIn(item);
			//trace("ex removed");
        }
		
		public static function createSaucerExplosion():Saucer_Explosion {
			return new Saucer_Explosion(0.3 + Math.random()*0.3);
		}
		
		public static function cleanSaucerExplosion(item:Saucer_Explosion):void {
			item.renew();
		}
		
		public function renew():void {
			i = 0;
		}
		
	}
}