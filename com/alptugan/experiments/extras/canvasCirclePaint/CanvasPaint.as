package  com.alptugan.experiments.extras.canvasCirclePaint {
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.IOErrorEvent;
    import flash.filters.BlurFilter;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    import com.adobe.images.PNGEncoder;
    import com.bit101.components.*;
    
    
    public class CanvasPaint extends Sprite {
        private const WIDTH:Number  = 1024;
           private const HEIGHT:Number = 768;
        
        private var _canvas:Canvas;
        private var _bmd:BitmapData;
        private var _bm:Bitmap;
        private var _saveBmd:BitmapData;
        private var _container:Sprite = new Sprite();
        private var _ctf:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 0.5);
        private var _fr:FileReference = new FileReference();
        
        private var _removeBtn:PushButton;
        private var _saveBtn:PushButton;
        
        public function CanvasPaint(){
            addChild(_container);
            _removeBtn = new PushButton(this, 140, 430, "Canvas Clear", btnClick);
            _saveBtn = new PushButton(this, 250, 430, "Save Image", btnClick);
            //
            _canvas = new Canvas(WIDTH, HEIGHT);
            _bmd = new BitmapData(WIDTH, HEIGHT, true, 0);
            _saveBmd = _bmd.clone();
            //
            _container.addChild(_canvas);
            _container.addChild(_bm = new Bitmap(_bmd) as Bitmap);
            _bm.blendMode = "add";
            //
            addEventListener(Event.ENTER_FRAME, update);
        }
        
        private function btnClick(e:MouseEvent):void{
            switch(e.target){
                case _removeBtn:
                    _canvas.remove();
                    break;
                case _saveBtn:
                    removeEventListener(Event.ENTER_FRAME, update);
                    _saveBmd.draw(_container);
                    fileSave(_saveBmd);
                    break;
            }
        }
        
        private function update(e:Event):void{
            _bmd.draw(_canvas, null, _ctf, "add");
            _bmd.applyFilter(_bmd, _bmd.rect, new Point(), new BlurFilter(8, 8, 3));
        }
        
        private function fileSave($bmd:BitmapData):void {
            var png:ByteArray = PNGEncoder.encode($bmd);
            _fr.addEventListener(Event.COMPLETE, complete);
            _fr.addEventListener(Event.CANCEL, cancel);
            _fr.addEventListener(IOErrorEvent.IO_ERROR, ioError);
            var date:Date = new Date  ;
            _fr.save(png, "export_image_" + date.getTime() + ".png");
            //
            function complete(e:Event):void{
                removedEventListener();
                addEventListener(Event.ENTER_FRAME, update);
            }
            function cancel(e:Event):void{
                removedEventListener();
                addEventListener(Event.ENTER_FRAME, update);
            }
            function ioError(e:IOErrorEvent):void{
                removedEventListener();
                addEventListener(Event.ENTER_FRAME, update);
            }
            //
            function removedEventListener():void{
                _fr.removeEventListener(Event.COMPLETE, complete);
                _fr.removeEventListener(Event.CANCEL, cancel);
                _fr.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
            }
        }
    }
}


import frocessing.display.*;
import flash.geom.Point;
  
class Canvas extends F5MovieClip2DBmp{ 
    private var _w:Number;
    private var _h:Number;
    private var _t:Number = 0;
    private var _pastMousePos:Point;
    private var _px:Number = 0;
    private var _py:Number = 0;
    private var _r:Number = 0;
    private var _list:Array = new Array();
    
    public function Canvas($w:Number, $h:Number) {
        _w = $w
        _h = $h
        super();
    }
    
    public function setup():void {
        for(var i:uint=0; i<5; i++){
            var p:Point = new Point(random(0 ,_w), random(0 ,_h));
            _list.push(p);
        }
        size(_w, _h);
        background(0);
        noFill();
        colorMode(HSV, 2, 1, 1);
    }

    public function draw():void{
        if(isMousePressed){
            var p:Point;
            if(mouseX > 0 && mouseX < _w && mouseY > 0 && mouseY < _h){
                p = new Point(mouseX, mouseY);
            }
            if(_pastMousePos){
                var distance:int = Point.distance(p, _pastMousePos);
                _pastMousePos = p;
                
                //
                var r:int = Math.random() * 5
                for(var i:int; i<distance ;i++){
                    stroke(_t, 0.8, 1, 0.1);
                    _px += (p.x + (Math.random() * distance-distance / 4) - _px) * Math.random() * 0.5;    
                    _py += (p.y + (Math.random() * distance-distance / 4) - _py) * Math.random() * 0.5;
                    ellipse(_px, _py, r * distance / 4, r * distance / 4);
                }
                _pastMousePos = p
            }else{
                _pastMousePos = new Point(mouseX, mouseY)
            }
            _t += 0.01;
            _r += 30;
        }else{
            _pastMousePos = null
        }

    }
    
    public function remove():void{
        background(0, 1);
        _t = 0;
    }
}