package firerice.interfaces;
import firerice.components.Component;

/**
 * ...
 * @author oggyiu
 */

interface IComponentContainer 
{
	public var components( default, null ) : Hash<Component>;
}