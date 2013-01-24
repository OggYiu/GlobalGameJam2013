import nme.display.Sprite;

import firerice.log.RayTrace;

/**
 * @version 4.1.0
 * @author saumya
 */

class Trace extends Sprite
{
	public function new() {
		super();
		addChild( new RayTrace() );
	}
}