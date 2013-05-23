/******************************************************************************
 CROSS FADING AS3 FULL BROWSER SLIDESHOW DOCUMENT CLASS
 *******************************************************************************
 Document class with demonstration use of some of the methods in the slideshow
 class.
 
 *******************************************************************************/

package src.com.galea{
	
	import flash.events.Event;
	
	import noponies.display.FullBrowserXShow;
	import noponies.utils.FullScreenMenu;
	import noponies.utils.LoadXmlToArray;
	import noponies.utils.StageManager;
	
	import org.casalib.display.CasaSprite;
	
	
	public class FullBrowserSlideShow extends CasaSprite {
		
		
		
		public var newBgSlideShow:FullBrowserXShow;
		private var myloadXml:LoadXmlToArray;
		//constructor
		public function FullBrowserSlideShow() {
			
			//load in xml via call to external xml parsing class
			//it returns us a nice array of images to pass to the slide class*/
			myloadXml = new LoadXmlToArray("xml/images.xml");
			myloadXml.addEventListener("xmlParsed", initSlides);
			

			//add the fullscreen context menu
			//var fullScreenMenu:FullScreenMenu = new FullScreenMenu(this);
		}
		//call back function from XML loading class
		//here we instantiate the full browser class and pass it our array of images
		
		private function initSlides(evt:Event):void {
			//instantiate the slideshow
			newBgSlideShow = new FullBrowserXShow(myloadXml.imagesArray);
			addChildAt(newBgSlideShow,0);
			//configure listeners
			newBgSlideShow.addEventListener(FullBrowserXShow.SLIDE_CHANGE, handleSlideChange);
			//newBgSlideShow.addEventListener(FullBrowserXShow.BG_LOADING, handleProgEvent);
			newBgSlideShow.addEventListener(FullBrowserXShow.BG_LOADED, handleLoadedEvent);
			//newBgSlideShow.addEventListener(FullBrowserXShow.BG_LOAD_STARTED, handleLoadStartEvent);			
			
		}
		
		//demo manual next image function
		//Here we change button text and change the buttons visual state to reflect its status
		//The next image function will not work while an image is loading and fading in
		private function nextImage():void {
			
			newBgSlideShow.loadSlide()
			
			//example below of calling a setter method in the slideshow
			//newBgSlideShow.imageDisplayTime=10
			//newBgSlideShow.pauseSlides()
			//newBgSlideShow.restartSlides()
			//newBgSlideShow.unloadAll()
		}
		
		//listener for load started event
		private function handleLoadStartEvent(event:Event):void {
			
		}
		
		//listener for status event dispatched from slideshow
		private function handleSlideChange(event:Event):void {
			//status_txt.text = "You are currently viewing slide "+newBgSlideShow.currentSlide+ " of "+newBgSlideShow.slidesTotal+" slides";
		}
		
		//listener for loaded event dispatched from sideshow
		private function handleLoadedEvent(event:Event):void {
			dispatchEvent(event);
		}
		//listener handler for progress events. This handler accesses the classes getter methods to obtain references to the bytes loaded and bytesTotal value for each object.
		//The goal here is for the class to have no external dependencies for display, rather it should simply provide information or dispatch information when requested and not
		//care about what gets done with that information
		private function handleProgEvent(event:Event):void {
			//loaded_txt.text = newBgSlideShow.bytesLoaded / 1000 + "KB loaded out of " + newBgSlideShow.bytesTotal / 1000 + "KB "+ "or "+uint(100 * newBgSlideShow.bytesLoaded / newBgSlideShow.bytesTotal)+"%";
		}
	}
}