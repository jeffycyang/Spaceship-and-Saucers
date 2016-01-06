package {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CollisionTest {

		public function exampleCollide( object1:DisplayObject, object2:DisplayObject ):Boolean {
			//get bounds of object 1, convert to bitmapdata
			var rectangle1:Rectangle = object1.getBounds(object1.stage);
			var bmp1:BitmapData = new BitmapData(rectangle1.width, rectangle1.height, true, 0);
			var matrix1:Matrix = object1.transform.matrix;
			matrix1.tx = object1.x - rectangle1.x;
			matrix1.ty = object1.y - rectangle1.y;
			bmp1.draw( object1, matrix1 );
			
			//get bounds and convert to bitmapdata for object 2
			var rectangle2:Rectangle = object2.getBounds(object2.stage);
			var bmp2:BitmapData = new BitmapData(rectangle1.width, rectangle1.height, true, 0);
			var matrix2:Matrix = object2.transform.matrix;
			matrix2.tx = object2.x - rectangle1.x;
			matrix2.ty = object2.y - rectangle1.y;
			bmp2.draw( object2, matrix2 );
	
			return bmp1.hitTest( new Point(), 0xFFFFFF, bmp2, new Point() );
		}
		
	}
}