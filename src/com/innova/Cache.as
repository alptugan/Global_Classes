package src.com.innova {
	
	public class Cache {
		
		private static var instance:Cache;      //This will be the unique instance created by the class
		private static var isOkayToCreate:Boolean=false;    //This variable will help us to determine whether the instance can be created
		
		public var previousMenu : String;
		public var previousLargeBmp:String;
		public var preivousKatInfo : String;
		public var preDairePlanB:String;
		public var preDairePlanK:String;
		public var preDaireData:String;
		public var preKatData:String;
		public var currentPage:String;
		public var volume:Number;
		
		public function Cache() {
			//If we can't create an instance, throw an error so no instance is created
			if(!isOkayToCreate) throw new Error(this + " is a Singleton. Access using getInstance()");
		}
		
		//With this method we will create and access the instance of the method
		public static function getInstance():Cache
		{
			//If there's no instance, create it
			if (!instance)
			{
				//Allow the creation of the instance, and after it is created, stop any more from being created
				isOkayToCreate = true;
				instance = new Cache();
				isOkayToCreate = false;
				trace("Singleton instance created!");
			}
			return instance;
		}
	}
}