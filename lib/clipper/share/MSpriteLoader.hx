package clipper.share;

import nme.display.BitmapData;
import nme.utils.ByteArray;
import nme.Assets;
import nme.utils.Endian;
import nme.events.Event;

// import awe6.core.Context;
// import nme.Loader;

/**
 * 
	<p><font size="2">MSpriteLoader is responsible for loading {@link MSpriteData}.</font></p>
	<p><font size="2">MSpriteLoader decides whether to load complete image in memory, or load it's 
	chopped clips based on value of splitImageClips passed in loadMSprite</font></p>
 */

 class MSpriteLoader {
	static var s_instance_ : MSpriteLoader = null;
	static var s_can_init_ : Bool = false;
	public static function getInstance() : MSpriteLoader {
		if( s_instance_ == null ) {
			s_can_init_ = true;
			s_instance_ = new MSpriteLoader();
			s_can_init_ = false;
		}

		return s_instance_;
	} 

	var dstrm : ByteArray = null;

	public function new() {
		if( !s_can_init_ ) {
			throw "you cannot have two instance of a singleton class!";
		}
	}

 	public function loadMSprite( spriteName:String, splitImageClips:Bool, imageloader:MSpriteImageLoader ) : MSpriteData {
		// trace( "MSpriteLoader 1" );
		if(imageloader == null){
			throw "Image Loader cannot be null";
		}

		var l_animationTable : Array<Int>;
		var frameTable : Array<Int>;
		var framePoolTable : Array<Int>;
		var imageClipPool : Array<Int>;
		var ellipseClipPool : Array<Int>;
		var lineClipPool : Array<Int>;
		var rectangleClipPool : Array<Int>;
		var roundedRectangleClipPool : Array<Int>;
		var positionerRectangleClipPool : Array<Int>;
		
		var frameTableIndex : Array<Int>;
		var imageIndex : Array<Int>;
		
		var data : MSpriteData = new MSpriteData(splitImageClips); 

		// var dstrm : ByteArray = new ByteArray();
		var targetFileName : String = "assets/motionwelder/" + spriteName + ".anu";
		// trace( "targetFileName: " + targetFileName );

		#if jeash
			//urlloader
			var myLoader = new UrlReader(targetFileName);
			myLoader.loader.addEventListener(Event.COMPLETE, fileLoadedHandler);
		#else
			dstrm = Assets.getBytes( targetFileName );
		#end

		// DataInputStream dstrm = new DataInputStream(new String().getClass().getResourceAsStream(spriteName));

		try{
			_readShort( dstrm );
			dstrm.readUTF();
			
			/** Animation table */
			var noOfAnimation : Int = dstrm.readByte();
			// l_animationTable = new short[noOfAnimation<<1];
			l_animationTable = new Array<Int>();
			l_animationTable[(noOfAnimation<<1)-1] = 0;
			for( i in 0 ... noOfAnimation ){
				l_animationTable[2*i] = _readShort( dstrm );
				l_animationTable[2*i+1] = _readShort( dstrm );
			}
			
			
			/** Animation Frame Table*/
			var totalNoOfFrame : Int = _readShort( dstrm );
			frameTable = new Array<Int>();
			frameTable[(totalNoOfFrame*4)-1] = 0;
			for( i in 0 ... totalNoOfFrame ) {
				frameTable[4*i] = _readShort( dstrm );
				frameTable[4*i+1] = dstrm.readByte(); // delay
				frameTable[4*i+2] = _readShort( dstrm );
				frameTable[4*i+3] = _readShort( dstrm );
			}
			
			/** Frame Pool */
			var length : Int = _readShort( dstrm );
			var totalNumberOfClips : Int = length>>2;
			framePoolTable = new Array<Int>();
			var noOfFrameInPool : Int =  _readShort( dstrm );
			var index : Int = 0;
			frameTableIndex = new Array<Int>();
			frameTableIndex[(noOfFrameInPool<<1)-1] = 0;
			for( i in 0 ... noOfFrameInPool ) {
				frameTableIndex[2*i] = index; 
				var noOfClips : Int = _readShort( dstrm );
				for( j in 0 ... noOfClips ) {
					framePoolTable[index++] = _readShort( dstrm ); // index
					framePoolTable[index++] = _readShort( dstrm ); // xpos
					framePoolTable[index++] = _readShort( dstrm ); // ypos
					framePoolTable[index++] = dstrm.readByte(); // flag
				}
				frameTableIndex[2*i+1] = (index-1);
			}
			
			/** Clip Pool */
			// image
			var noOfImagesClips : Int = _readShort( dstrm );
			var noOfImages : Int = dstrm.readByte();
			
			imageClipPool = new Array<Int>();
			imageClipPool[(noOfImagesClips<<2)-1] = 0;
			index=0;
			imageIndex = new Array<Int>();
			imageIndex[noOfImages-1] = 0;
			var noOfClipsRead : Int = 0;
			for( i in 0 ... noOfImages ) {
				imageIndex[i] = noOfClipsRead;
				var noOfClipsInThisImage : Int = _readShort( dstrm );
			
				// Image[][] imageArrayForClips = new Image[noOfClipsInThisImage][];
				var imageArrayForClips : Array<Array<BitmapData>> = new Array<Array<BitmapData>>();
				for( n in 0 ... noOfClipsInThisImage ) {
					imageArrayForClips[n] = new Array<BitmapData>();
				}

				for( j in 0 ... noOfClipsInThisImage ) {
					// var x : Int = imageClipPool[index++] = _readShort( dstrm );
					// var y : Int = imageClipPool[index++] = _readShort( dstrm );
					// var w : Int = imageClipPool[index++] = _readShort( dstrm );
					// var h : Int = imageClipPool[index++] = _readShort( dstrm );
					var x : Int = imageClipPool[index++] = dstrm.readUnsignedShort();
					var y : Int = imageClipPool[index++] = dstrm.readUnsignedShort();
					var w : Int = imageClipPool[index++] = dstrm.readUnsignedShort();
					var h : Int = imageClipPool[index++] = dstrm.readUnsignedShort();
					if(splitImageClips){
						// check which orientation is used..
						var orientationUsedInStudio : Int = 0;
						for( k in 0 ... totalNumberOfClips ) {
							var pos : Int = (k<<2);
							var clipIndex : Int = framePoolTable[pos];
							var flag : Int = framePoolTable[pos+3];
							var imageId : Int = ((flag&0xf8)>>3);
							clipIndex = clipIndex-imageIndex[imageId];
							if(clipIndex!=j) continue;
							if((flag&0x01)!=0) continue;
							if(imageId!=i) continue;
							
							orientationUsedInStudio |= (flag&0x07);
						}

						imageArrayForClips[j] = imageloader.loadImageClip(spriteName,i,x,y,w,h,(orientationUsedInStudio>>1)); 
						// trace( "orientationUsedInStudio>>1: " + (orientationUsedInStudio>>1) );
						// trace( "imageArrayForClips[j].length: " + imageArrayForClips[j].length );
					}
				}
				// trace( "imageArrayForClips.length: " + imageArrayForClips.length );
				// for( i in 0 ... imageArrayForClips.length ) {
				// 	trace( "imageArrayForClips[" + i + "].length: " + imageArrayForClips[i].length );
				// }
					
				noOfClipsRead +=noOfClipsInThisImage;
			
				// inform listener about loading images
				if(splitImageClips){
					data.imageVector.push(imageArrayForClips);
				} 
				// else 
				// {
				// 	var orientationUsedInStudio : Int = 0;
				// 	for( k in 0 ... totalNumberOfClips ) {
				// 		var flag : Int = framePoolTable[(k<<2)+3];
				// 		var imageId : Int = ((flag&0xf8)>>3);
				// 		if((flag&0x01)!=0) continue; // it sud be image flag
				// 		if(imageId!=i) continue;
						
				// 		orientationUsedInStudio |= (flag&0x07);
				// 	}
				// 	data.imageVector.push(imageloader.loadImage(spriteName,i,(orientationUsedInStudio>>1)));
				// }
			}
				
			// ellipse
			var noOfEllipseClip : Int = _readShort( dstrm );
			ellipseClipPool = new Array<Int>();
			ellipseClipPool[(noOfEllipseClip*5)-1] = 0;
			for( i in 0 ... noOfEllipseClip ) {
				ellipseClipPool[5*i] = _readShort( dstrm );
				ellipseClipPool[5*i+1] = _readShort( dstrm );
				ellipseClipPool[5*i+2] = _readShort( dstrm );
				ellipseClipPool[5*i+3] = _readShort( dstrm );
				ellipseClipPool[5*i+4] = dstrm.readInt();
			}

			// Line
			var noOfLineClip : Int = _readShort( dstrm );
			lineClipPool = new Array<Int>();
			lineClipPool[(noOfLineClip*3)-1] = 0;
			for( i in 0 ... noOfLineClip ) {
				lineClipPool[3*i] = _readShort( dstrm );
				lineClipPool[3*i+1] = _readShort( dstrm );
				lineClipPool[3*i+2] = dstrm.readInt();
			}
			
			// Rectangle
			var noOfRectangleClip : Int = _readShort( dstrm );
			rectangleClipPool = new Array<Int>();
			rectangleClipPool[(noOfRectangleClip*3)-1] = 0;
			for( i in 0 ... noOfRectangleClip ) {
				rectangleClipPool[3*i] = _readShort( dstrm );
				rectangleClipPool[3*i+1] = _readShort( dstrm );
				rectangleClipPool[3*i+2] = dstrm.readInt();
			}
			
			// rounded Rect
			var noOfRoundedRectangleClip : Int = _readShort( dstrm );
			roundedRectangleClipPool = new Array<Int>();
			roundedRectangleClipPool[(noOfRoundedRectangleClip*5)-1] = 0;
			for( i in 0 ... noOfRoundedRectangleClip ) {
				roundedRectangleClipPool[5*i]   = _readShort( dstrm );
				roundedRectangleClipPool[5*i+1] = _readShort( dstrm );
				roundedRectangleClipPool[5*i+2] = _readShort( dstrm );
				roundedRectangleClipPool[5*i+3] = _readShort( dstrm );
				roundedRectangleClipPool[5*i+4] = dstrm.readInt();
			}
			
			// rounded Rect
			var noOfPositionerRectangleClip : Int = _readShort( dstrm );
			positionerRectangleClipPool = new Array<Int>();
			positionerRectangleClipPool[(noOfPositionerRectangleClip<<1)-1] = 0;
			for( i in 0 ... noOfPositionerRectangleClip ) {
				positionerRectangleClipPool[2*i] = _readShort( dstrm );
				positionerRectangleClipPool[2*i+1] = _readShort( dstrm );
			}
			
		} catch ( e : String ) {
			throw e;
		}

		// if(dstrm!=null)
		// 	dstrm.close();
		
		data.animationTable = l_animationTable;
		data.frameTable = frameTable;
		data.frameTableIndex = frameTableIndex;
		
		data.framePoolTable = framePoolTable;
		
		data.imageClipPool = imageClipPool;
		data.ellipseClipPool = ellipseClipPool;
		data.lineClipPool = lineClipPool;
		data.rectangleClipPool = rectangleClipPool;
		data.roundedRectangleClipPool = roundedRectangleClipPool;
		data.positionerRectangleClipPool = positionerRectangleClipPool;
		data.imageIndexTable = imageIndex;
		
		// trace( "data: " + data );
		return data;
	}

	function _readShort( byteArray : ByteArray ) : Int {
		// var ch1 : Dynamic = byteArray.readUnsignedByte();
		// var ch2 = byteArray.readUnsignedByte();
		// var ch1 : Dynamic = byteArray.readByte();
		// var ch2 : Dynamic = byteArray.readByte();
		// ch1 = Math.abs(ch1);
		// ch2 = Math.abs(ch2);
		// var val : Int = byteArray.endian == Endian.BIG_ENDIAN? (ch1 << 8) | ch2 : (ch2 << 8) + ch1;

		// trace( "ch1 value: " + ch1 );
		// trace( "ch1 binary: " + ch1.toString(2));
		// trace( "ch2 value: " + ch2 );
		// trace( "ch2 binary: " + ch2.toString(2));
		// trace( (ch1 | 0) );
		// if( start_printing ) {
		// 	trace( "start printing!!!!!!!!!!!!" );
		// 	trace( "ch1: " + ch1 );
		// 	trace( "ch2: " + ch2 );
		// 	trace( "(val >= 0x8000 ): " + (val >= 0x8000 ) );
		// 	trace( "origin val: " + val );
		// 	trace( "val: " + ((val >= 0x8000 ) ? 65534 - val : val ));
		// }
		// return (val >= 0x8000 ) ? 65534 - val : val;
		return byteArray.readShort();
	}

	private function fileLoadedHandler( evt : Event ) : Void {
        //         arrColl.addItem({type:evt.type, idx:arrColl.length+1, eventString:evt.toString()});

        //         switch (evt.type) {
        //             case Event.COMPLETE:
        //                 /* If the load was successful, create a URLVariables object from the URLLoader.data property and populate the paramColl ArrayCollection object. */
        //                 var ldr:URLLoader = evt.currentTarget as URLLoader;
        //                 var vars:URLVariables = new URLVariables(ldr.data);
        //                 var key:String;

        //                 for (key in vars) {
        //                     paramColl.addItem({key:key, value:vars[key]});
        //                 }

        //                 params.visible = true;
        //                 break;
        //         }
        //     }
        // ]]>
	}
}
