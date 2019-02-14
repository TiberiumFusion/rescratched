package inappd 
{
	/**
	 * Simple device which contains a list of FormattedString objects and can write itself to a TextField
	 * @author TiberiumFusion
	 */
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	 
	public class FormattedStringList
	{	
		private var orderedText:Vector.<FormattedString>;
		
		public function FormattedStringList(first:FormattedString = null)
		{
			orderedText = new Vector.<FormattedString>();
			if (first != null)
				orderedText.push(first);
		}
		
		public function AddText(newitem:FormattedString):void
		{
			orderedText.push(newitem);
		}
		
		public function ClearText():void
		{
			orderedText = new Vector.<FormattedString>(); // No clear() method in AS3
		}
		
		public function AppendToTextField(tf:TextField, postfix:String = null, prefix:String = null):void
		{
			if (orderedText.length > 0)
			{
				var oldDefaultFormat:TextFormat = tf.defaultTextFormat;
				
				var cursor:int = tf.text.length;
				if (prefix != null)
					tf.appendText(prefix);
				for each (var item:FormattedString in orderedText)
				{
					tf.appendText(item.Text);
					tf.setTextFormat(item.Format, cursor, tf.text.length);
					cursor = tf.text.length;
				}
				if (postfix != null)
					tf.appendText(postfix);
				
				tf.defaultTextFormat = oldDefaultFormat;
			}
		}
	}
}