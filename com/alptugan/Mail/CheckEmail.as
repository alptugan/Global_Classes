package com.alptugan.Mail
{
	public class CheckEmail
	{
		public function CheckEmail()
		{
		}
		
		public function initCheck(s:String):Boolean
		{
			var x:Number;
			var t:Number=0;
			var boo:Boolean=new Boolean();
			for(var i:Number=0;i<s.length;i++)
			{
				if(s.charAt(i)==' ')
				{
					boo=false;
					break;
				}
				if(s.charAt(i)=='@')
				{
					x=i;
					t++;
				}
				else if(i>x&&s.charAt(i)=='.'&&s.charAt(s.length-1)!='.')
				{
					t++
					boo=true
					break;
				}
				else
				{
					if(i==s.length-1)
					{
						boo=false;
						break;
					}
				}
			}
			return boo;
		}
	}
}