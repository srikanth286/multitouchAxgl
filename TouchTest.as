package 
{
    import flash.events.Event;
    import org.axgl.*;
  	import org.axgl.input.AxKey;
    import org.axgl.input.AxMouseButton;
    import org.axgl.render.AxColor;
	  import org.axgl.text.AxFont;
    import org.axgl.text.AxText;
    public class ZTouch extends AxState
    {
		    private var t:Touch;
		    private var ovr:AxGroup;
		
        override public function create():void
        {
      			Ax.background = AxColor.fromHex(0xffAEEDFF);
      			
      			add(leftButton);
      			add(rightButton);
      			
      			t = new Touch(false,20);
      			add(t);
      			
      			ovr = new AxGroup;
      			add(ovr);
      			
      			ovr.add(t.ghost1);
      			ovr.add(t.ghost2);
        }
		
        override public function update():void
        {
      			if(t.justTouched1)
      				{add(new AxSprite(a * 30, 50).create(30, 30, 0xffFF0606)); a++ }
      			if (t.justReleased1)
      				{add(new AxSprite(b * 30, 100).create(30, 30, 0xffAA00F2));b++;}
            if(t.justTouched2)
      				{add(new AxSprite(c * 30, 150).create(30, 30, 0xffFF0606)); c++ }
      			if (t.justReleased2)
      				{add(new AxSprite(d * 30, 200).create(30, 30, 0xffAA00F2));d++;}
      			if(t.down1)
      				{add(new AxSprite(e * 30, 250).create(30, 30, 0xffFF0606)); e++; }
      			if (t.down2)
      				{add(new AxSprite(f * 30, 300).create(30, 30, 0xffAA00F2));f++;}	

		      	super.update();
        }       
		
    		private var a:int = 0;
    		private var b:int = 0;
    		private var c:int = 0;
    		private var d:int = 0;
    		private var e:int = 0;
    		private var f:int = 0;
    }
}
