package com.alptugan.experiments.extras {
	
	import flash.utils.Dictionary;
	
	/**
	 * Converts strings of letters and numbers to Morse code.
	 * @author Devon O. Wolfgang
	 */
	public class MorseGenerator {
		
		private var _morseDict:Dictionary = new Dictionary();
		
		public function MorseGenerator() {
			initDictionary();
		}
		
		private function initDictionary():void {
			_morseDict["a"] = ".-";
			_morseDict["b"] = "-...";
			_morseDict["c"] = "-.-.";
			_morseDict["d"] = "-..";
			_morseDict["e"] = ".";
			_morseDict["f"] = "..-.";
			_morseDict["g"] = "--.";
			_morseDict["h"] = "....";
			_morseDict["i"] = "..";
			_morseDict["j"] = ".---";
			_morseDict["k"] = "-.-";
			_morseDict["l"] = ".-..";
			_morseDict["m"] = "--";
			_morseDict["n"] = "-.";
			_morseDict["o"] = "---";
			_morseDict["p"] = ".--.";
			_morseDict["q"] = "--.-";
			_morseDict["r"] = ".-.";
			_morseDict["s"] = "...";
			_morseDict["t"] = "-";
			_morseDict["u"] = "..-";
			_morseDict["v"] = "...-";
			_morseDict["w"] = ".--";
			_morseDict["x"] = "-..-";
			_morseDict["y"] = "-.--";
			_morseDict["z"] = "--..";
			_morseDict[" "] = " ";
			_morseDict["1"] = ".----";
			_morseDict["2"] = "..---";
			_morseDict["3"] = "...--";
			_morseDict["4"] = "....-";
			_morseDict["5"] = ".....";
			_morseDict["6"] = "-....";
			_morseDict["7"] = "--...";
			_morseDict["8"] = "---..";
			_morseDict["9"] = "----.";
			_morseDict["0"] = "-----";
			
			_morseDict["."] = ".-.-.-";
			_morseDict[","] = "--.--";
			_morseDict["?"] = "..--..";
			_morseDict["-"] = "-....-";
			_morseDict["/"] = "-..-.";
		}
		
		public function convert(msg:String):String {
			msg = msg.toLowerCase();
			var msgArray:Array = msg.split("");
			var len:int = msgArray.length;
			var output:String = "";
			for (var i:int = 0; i < len; i++) {
				var char:* = _morseDict[String(msgArray[i])];
				if (char != undefined) output += char + " ";
			}
			return output;
		}
	}
}