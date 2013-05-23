package  src.com.filikatasarim.cpm.serra {
	
	public class SerraGlobals {
		
		private static var instance:SerraGlobals;      //This will be the unique instance created by the class
		private static var isOkayToCreate:Boolean=false;    //This variable will help us to determine whether the instance can be created
		
		public var cat:Array = [],
					catThumbs:Array = [],
						   catLen:int = 0,
						   subcat:Array = [],
						   subcatThumbs:Array = [],
						   subcatLen:int = 0,
						   images:Array = [],
						   imagesLen:int = 0;
		
		public var pageId:int;
		public var catId:int;
		public var subcatId:int;
		public var catName:String;
		
		public function SerraGlobals() {
			//If we can't create an instance, throw an error so no instance is created
			if(!isOkayToCreate) throw new Error(this + " is a Singleton. Access using getInstance()");
		}
		
		//With this method we will create and access the instance of the method
		public static function getInstance():SerraGlobals
		{
			//If there's no instance, create it
			if (!instance)
			{
				//Allow the creation of the instance, and after it is created, stop any more from being created
				isOkayToCreate = true;
				instance = new SerraGlobals();
				isOkayToCreate = false;
				trace("Singleton instance created!");
			}
			return instance;
		}
	}
}