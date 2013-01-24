package clipper.entities;

import awe6.interfaces.IKernel;
import awe6.core.Entity;
import awe6.core.Context;

import clipper.share.Helper;

class ClipperEntity extends Entity {
	var context_ : Context = null;

	public var context( getContext, setContext ) : Context;

	public function new( p_kernel : IKernel, p_context : Context ) {
		context_ = p_context;
		super( p_kernel, Helper.guid(), p_context );
	}

	function getContext() : Context {
		return context_;
	}

	function setContext( value : Context ) : Context {
		context_ = value;
		return context_;
	}
}