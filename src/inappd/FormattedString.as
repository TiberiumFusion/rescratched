package inappd 
{
	/**
	 * Simple device which contains a string and an accompanying TextFormat that can write itself to a TextField
	 * @author TiberiumFusion
	 */
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	 
	public class FormattedString
	{	
		public var Text:String = "";
		public var Format:TextFormat;
		
		public function FormattedString(text:String, format:TextFormat)
		{
			Text = text;
			Format = format;
		}
		
		public function AppendToTextField(tf:TextField, postfix:String = null, prefix:String = null):void
		{
			var oldDefaultFormat:TextFormat = tf.defaultTextFormat;
			
			var cursor:int = tf.text.length;
			if (prefix != null)
				tf.appendText(prefix);
			tf.appendText(Text);
			if (postfix != null)
				tf.appendText(postfix);
			tf.setTextFormat(Format, cursor, tf.text.length);
			
			tf.defaultTextFormat = oldDefaultFormat;
		}
	}
}