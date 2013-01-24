package clipper.game;

import awe6.interfaces.IKernel;
import awe6.core.Process;

import nme.display.Graphics;

class GameTileMap extends Process {
	var tileSize_ : Int = 0;
	var rowCount_ : Int = 0;
	var colCount_ : Int = 0;

	public var tileSize( getTileSize, null ) : Int;
	public var rowCount( getRowCount, null ) : Int;
	public var colCount( getColCount, null ) : Int;

	public function new( p_kernel:IKernel, tileSize : Int, colCount : Int, rowCount : Int ) {
		super( p_kernel );

		tileSize_ = tileSize;
		colCount_ = colCount;
		rowCount_ = rowCount;
	}

	override private function _init():Void {


	override private function _disposer():Void {
	}

	override private function _updater( ?p_deltaTime:Int = 0 ):Void {
	}

	override private function _pauser():Void {
	}

	override private function _resumer():Void {
	}

	public function render( graphics : Graphics, color : Int, lineWidth : Int ) : Void {
		graphics.clear();
		graphics.lineStyle(lineWidth, color, 1);

		var mapWidth : Int = colCount_ * tileSize_;
		var mapHeight : Int = rowCount_ * tileSize_;

		for( i in 0 ... ( rowCount_ + 1 ) ) {
			graphics.moveTo( 0, i * tileSize_ );
			graphics.lineTo( mapWidth, i * tileSize_ );
		}

		for( i in 0 ... ( colCount_ + 1 ) ) {
			graphics.moveTo( i * tileSize_, 0 );
			graphics.lineTo( i * tileSize_, mapHeight );
		}
	}

	// get and set
	function getTileSize() : Int {
		return tileSize_;
	}

	function getRowCount() : Int {
		return rowCount_;
	}

	function getColCount() : Int {
		return colCount_;
	}
}