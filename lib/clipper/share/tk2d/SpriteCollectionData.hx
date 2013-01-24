package clipper.share.tk2d;

import nme.geom.Rectangle;
import nme.display.BitmapData;

class SpriteDefinition
{
	// public enum ColliderType
	// {
	// 	Unset,	// Do not create or destroy anything
	// 	None,	// If a collider exists, it will be destroyed
	// 	Box,
	// 	Mesh,
	// }
	
	public var name : String;
	// public Vector3[] boundsData;
    // public Vector3[] positions;
    public var transform : TransformComponent;
    // public Vector2[] uvs;
    // public int[] indices = new int[] { 0, 3, 1, 2, 3, 0 };
	// public Material material;
	
	// public string sourceTextureGUID;
	// public bool extractRegion;
	// public int regionX, regionY, regionW, regionH;
	
	// public bool flipped;
	
	// Collider properties
	// public ColliderType colliderType = ColliderType.None;
	// v0 and v1 are center and size respectively for box colliders
	// otherwise, they are simply an array of vertices
	public var colliders : Array<Rectangle>;
	// public Vector3[] colliderVertices; 
	// public int[] colliderIndicesFwd;
	// public int[] colliderIndicesBack;
	// public bool colliderConvex;
	// public bool colliderSmoothSphereCollisions;

	public function new() {
		name = "";
    	transform = new TransformComponent();
    	colliders = new Array<Rectangle>();
	}
}

class SpriteCollectionData
{
	public var CURRENT_VERSION : Int = 1;
	
	// [HideInInspector]
	public var version : Int;
	
    // [HideInInspector]
    public var spriteDefinitions : Array<SpriteDefinition>;
	
    // [HideInInspector]
    // public bool premultipliedAlpha;
	
	// legacy data
    // [HideInInspector]
	// public Material material;	
	
	// [HideInInspector]
	// public Material[] materials;
	
	// [HideInInspector]
	public textures : Array<BitmapData>;
	
	// [HideInInspector]
	// public bool allowMultipleAtlases;
	
	// [HideInInspector]
	public var spriteCollectionGUID : String;
	
	// [HideInInspector]
	public var spriteCollectionName : String;

	// [HideInInspector]
	// public float invOrthoSize = 1.0f;
	
	// [HideInInspector]
	// public int buildKey = 0;
	
	// [HideInInspector]
	public var guid : String;
	
    public var count( getCount, null ) : Int;

    function getCount() : Int {
    	return spriteDefinitions.length;	
    }

    public function new() {
		version = CURRENT_VERSION;
    	spriteDefinitions = new Array<SpriteDefinition>();
		textures = new Array<BitmapData>();
		spriteCollectionGUID = "";
		spriteCollectionName = "";
		guid = "";
    }
}
