package com.alptugan.utils
{
	import com.alptugan.valueObjects.AudioPlayerVO;
	
	public class ParseAudioXML
	{
		private var xml : XML;
		public var VO:AudioPlayerVO;
		
		public function ParseAudioXML(xml:XML)
		{
			this.xml = xml;
			VO = new AudioPlayerVO();
			
			/**Parse XML to VAriables**/
			VO               = new AudioPlayerVO();
			
			/** Color Properties of DOs **/
			VO.ClBg          = this.xml.runtime[int(0)].Bg[int(0)].@Color;
			VO.ClPlayPause   = this.xml.runtime[int(0)].Play[int(0)].@Color;
			VO.ClSoundIco    = this.xml.runtime[int(0)].SoundIco[int(0)].@Color;
			VO.ClTbDef       = this.xml.runtime[int(0)].TbDef[int(0)].@Color;
			VO.ClTbLoaded    = this.xml.runtime[int(0)].TbLoaded[int(0)].@Color;
			VO.ClTbPlayed    = this.xml.runtime[int(0)].TbPlayed[int(0)].@Color;
			VO.ClTbSoundCurr = this.xml.runtime[int(0)].TbSoundCurr[int(0)].@Color;
			VO.ClTbSoundDef  = this.xml.runtime[int(0)].TbSoundDef[int(0)].@Color;
			
			/** Time : Color, x pos, y pos**/
			VO.ClTxt         = this.xml.runtime[int(0)].Txt[int(0)].@Color;
			VO.xTxt          = this.xml.runtime[int(0)].Txt[int(0)].@X;
			VO.yTxt          = this.xml.runtime[int(0)].Txt[int(0)].@Y;
			
			/** Background Properties **/
			VO.ehBg          = this.xml.runtime[int(0)].Bg[int(0)].@eH;
			VO.ewBg          = this.xml.runtime[int(0)].Bg[int(0)].@eW;
			VO.wBg           = this.xml.runtime[int(0)].Bg[int(0)].@W;
			VO.hBg           = this.xml.runtime[int(0)].Bg[int(0)].@H;
			
			/** Time Tracker Properties **/
			VO.wTbDef        = this.xml.runtime[int(0)].TbDef[int(0)].@W;
			VO.hTbDef        = this.xml.runtime[int(0)].TbDef[int(0)].@H;
			VO.hTbPlayed     = this.xml.runtime[int(0)].TbPlayed[int(0)].@H;
			VO.yTbPlayed     = this.xml.runtime[int(0)].TbPlayed[int(0)].@Y;
			VO.ewTbDef       = this.xml.runtime[int(0)].TbDef[int(0)].@eW;
			VO.ehTbDef       = this.xml.runtime[int(0)].TbDef[int(0)].@eH;
			VO.xTbDef        = this.xml.runtime[int(0)].TbDef[int(0)].@X;
			VO.yTbDef        = this.xml.runtime[int(0)].TbDef[int(0)].@Y;
			
			/** Play  Button Properties **/
			VO.wPlayPause    = this.xml.runtime[int(0)].Play[int(0)].@W;
			VO.hPlayPause    = this.xml.runtime[int(0)].Play[int(0)].@H;
			VO.xPlayPause    = this.xml.runtime[int(0)].Play[int(0)].@X;
			VO.yPlayPause    = this.xml.runtime[int(0)].Play[int(0)].@Y;
			
			/** Pause  Button Properties **/
			VO.ClPause   = this.xml.runtime[int(0)].Pause[int(0)].@Color;
			VO.wPause    = this.xml.runtime[int(0)].Pause[int(0)].@W;
			VO.hPause    = this.xml.runtime[int(0)].Pause[int(0)].@H;
			VO.xPause    = this.xml.runtime[int(0)].Pause[int(0)].@X;
			VO.yPause    = this.xml.runtime[int(0)].Pause[int(0)].@Y;
			
			/** Sound Tracker Properties **/
			VO.wTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@W;
			VO.hTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@H;	
			VO.ewTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@eW;
			VO.ehTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@eH;
			VO.xTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@X;	
			VO.yTbSoundDef   = this.xml.runtime[int(0)].TbSoundDef[int(0)].@Y;
			
			/** Sound Icon Properties **/
			VO.xSoundIco     = this.xml.runtime[int(0)].SoundIco[int(0)].@X;		
			VO.ySoundIco     = this.xml.runtime[int(0)].SoundIco[int(0)].@Y;
			
			/** Current Sound Value Graphics **/
			VO.yTbSoundCurr    = this.xml.runtime[int(0)].TbSoundCurr[int(0)].@Y;
			VO.hTbSoundCurr    = this.xml.runtime[int(0)].TbSoundCurr[int(0)].@H;
			
		
		}
		
		private function init():void
		{
			
		}
	}
}