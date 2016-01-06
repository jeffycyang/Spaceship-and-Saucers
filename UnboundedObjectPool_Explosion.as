package {

        public class UnboundedObjectPool {

                //public var minSize : int;
                //public var size : int = 0;

                public var create : Function;
                public var clean : Function;
                public var arraylength : int = 0;

                private var list : Array = [];
                private var disposed : Boolean = false;

                public function UnboundedObjectPool( create:Function, clean:Function = null ) {
                        this.create = create;
                        this.clean = clean;
                        //this.minSize = minSize;
                        
                        //for(var i : int = 0;i < minSize; i++) add();
                }
                
                //public function add() : void {
                        //list[length++] = create();
                        //size++;
                //}

                public function checkOut() : * {
                        if(arraylength == 0) {
							trace("created");
							//length += 1;
							return create();
								
                        } //else {
                        //trace("reusing");
                        	return list[--arraylength];
							//arraylength -= 1;
						
						//}
                }

                public function checkIn(item : *) : void {
                        //if(clean != null) {
						clean(item);
						//}
                        list[arraylength++] = item;
						trace("item returned");
                }

                public function dispose() : void {
                        if(disposed) return;
                        
                        disposed = true;
                        
                        create = null;
                        clean = null;
                        list = null;
                }
        }
}
