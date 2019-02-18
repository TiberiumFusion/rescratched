package util
{
	import flash.utils.ByteArray;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	public class Base64Encoder
	{
		// LLK implementation was flawed, replaced with mx.utils
		
		public static function encodeString(s:String):String
		{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(s);
			
			var encoder:mx.utils.Base64Encoder = new mx.utils.Base64Encoder();
			encoder.encodeBytes(data, 0, data.length);
			return encoder.toString();
		}
		
		public static function encode(data:ByteArray):String
		{
			var encoder:mx.utils.Base64Encoder = new mx.utils.Base64Encoder();
			encoder.encodeBytes(data, 0, data.length);
			return encoder.toString();
		}
		
		public static function decode(s:String):ByteArray
		{
			var decoder:mx.utils.Base64Decoder = new mx.utils.Base64Decoder();
			decoder.decode(s);
			return decoder.toByteArray();
		}
	}
}