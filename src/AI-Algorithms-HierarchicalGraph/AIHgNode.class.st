"
I am a node inside a hierarchical graph. It knows the graph it belongs to, its children and its parent, on which level in the graph it resides and its outgoing ind incoming edges. One can also store arbitrary informaition as attributes to a node.

Instance Variables
	attributes:		<Dictionary>
	children:		<OrderedCollection> s
	hiGraph:		<AIHierarchicalGraph>
	incoming:		<OrderedCollection>
	level:		      <Number>
	outgoing:		<OrderedCollection>
	parent:		      <AIHgNode>

attributes
	- Dictionary to attach arbitrary information to a node

children
	- This nodes children. Empty collection if the node is a leaf in the hierarchy.

hiGraph
	- The MalHierarchicalGraph this node belongs to.

incoming
	- All incoming edges to this node.

level
	- The level this node is on in the hierachy where 0 is the top level (root nodes). The larger the number, the deeper down in the hierarchy the node is located.

outgoing
	- All outgoing edges from this node.

parent
	- This nodes parent

"
Class {
	#name : #AIHgNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'hiGraph',
		'parent',
		'children',
		'outgoing',
		'incoming',
		'level',
		'attributes'
	],
	#category : #'AI-Algorithms-HierarchicalGraph'
}

{ #category : #'instance creation' }
AIHgNode class >> in: hiGraph with: aModel [
	"Creates a new instance of a MalHgNode for given hiGraph, with given object as model."

	^ self in: hiGraph with: aModel level: nil
]

{ #category : #'instance creation' }
AIHgNode class >> in: hiGraph with: aModel level: level [
	"Creates a new instance of a MalHgNode for given hiGraph, with given object as model, on given level."

	^ self new
		model: aModel;
		hiGraph: hiGraph;
		level: level;
		yourself
]

{ #category : #'instance creation' }
AIHgNode class >> with: aModel [
	"Creates a new instance of a MalHgNode with given object as model"

	^ self in: nil with: aModel level: nil
]

{ #category : #adding }
AIHgNode >> addChild: aNode [
	"Adds a child node."
	(children includes: aNode) ifFalse: [
		children add: aNode.
	]
]

{ #category : #adding }
AIHgNode >> addChildren: aCollection [
	"Add multiple children to this node."
	aCollection do: [ :each | 
		self addChild: each.
	].
]

{ #category : #adding }
AIHgNode >> addIncoming: anEdge [
	"Add an incoming edge to this node."
	incoming add: anEdge.

]

{ #category : #adding }
AIHgNode >> addOutgoing: anEdge [
	"Add an outgoing edge to this node."
	outgoing add: anEdge.

]

{ #category : #accessing }
AIHgNode >> attributeAt: aKey [
	"Returns attribute with given key, nil if attribute is absent."
	^ attributes at: aKey ifAbsent: [ nil ].
]

{ #category : #accessing }
AIHgNode >> attributeAt: aKey ifAbsent: aBlock [
	"Returns attribute with given key, given block is run if there is no element with given key."
	^ attributes at: aKey ifAbsent: aBlock.
]

{ #category : #accessing }
AIHgNode >> attributeAt: aKey ifAbsentPut: aBlock [
	"Returns attribute with given key, if no attribute exists with given key, use given block to put an attribute. "
	^ attributes at: aKey ifAbsentPut: aBlock.
]

{ #category : #accessing }
AIHgNode >> attributeAt: aKey put: anObject [
	"Puts given object as attribute at given key."
	attributes at: aKey put: anObject.
]

{ #category : #accessing }
AIHgNode >> attributes [
	"Returns all attributes of this MalHgNode."
	^ attributes
]

{ #category : #accessing }
AIHgNode >> children [
	"Returns this nodes children."
	^ children.
]

{ #category : #printing }
AIHgNode >> description [
	"Returns a description of this node, based on its name and its models class"
	^  model name , ' (' , model class name , ')'.
]

{ #category : #accessing }
AIHgNode >> edges [
	"Return all edges, incoming and outgoing, as a set."
	^ (Set newFrom: incoming) addAll: outgoing.

]

{ #category : #accessing }
AIHgNode >> edges: aLevel [
	"Return all edges, incoming and outgoing, on given level as a Set."
	^ (Set newFrom: (self incomingEdges: aLevel)) addAll: (self outgoingEdges: aLevel).

]

{ #category : #accessing }
AIHgNode >> hiGraph [
	"Returns the hiGraph this node belongs to."
	^ hiGraph
]

{ #category : #accessing }
AIHgNode >> hiGraph: anObject [
	"Sets the hiGraph this nodes belongs to."
	hiGraph := anObject
]

{ #category : #accessing }
AIHgNode >> incoming [
	"Returns all incoming edges."
	^ incoming.

]

{ #category : #enumerating }
AIHgNode >> incomingEdges: aLevel [
	"Returns a collection of of all incoming edges that are on given level.
	Returns an empty collection if there are no incoming edges. 
	Returns all incoming edges if given level is nil"

	| incomingEdges |
	incomingEdges := Set new.
	self incoming
		do: [ :rel | 
			aLevel
				ifNil: [ incomingEdges add: rel ]
				ifNotNil: [ rel from level = level ifTrue: [ incomingEdges add: rel ] ] ].
	^ incomingEdges
]

{ #category : #enumerating }
AIHgNode >> incomingFrom: aNode [
	"Returns all edges that are incoming from given node, nil if no such edge was found."

	| result |
	result := nil.
	self incoming
		do: [ :rel | 
			rel from == aNode
				ifTrue: [ result ifNil: [ result := Set new ].
					result add: rel ] ].
	^ result
]

{ #category : #enumerating }
AIHgNode >> incomingFromThese: aNodeCollection [
	"Returns all edges that are incoming from given node collection, empty collection if no such edge was found."
	 | result |
	result := Set new.
	aNodeCollection do: [ :node |
		result addAll: (self incomingFrom: node).
	].
	^ result.
]

{ #category : #enumerating }
AIHgNode >> incomingNotPropagated [
	"Returns all incoming edges that were not propagated."
	^ incoming reject: [ :rel | rel class = AIHgPropagatedEdge ].

]

{ #category : #enumerating }
AIHgNode >> incomingPropagated [
	"Returns all incoming edges that were propagated."
	^ incoming select: [ :rel | rel class = AIHgPropagatedEdge ].

]

{ #category : #enumerating }
AIHgNode >> incomingSources [
	"Returns a set of all source nodes of all incoming edges to this node.
	Returns an empty set if there are no incoming edges."
	^ self incomingSources: nil.
]

{ #category : #enumerating }
AIHgNode >> incomingSources: aLevel [
	"Returns a collection of all source nodes of all incoming edges that are on given level.
	Returns an empty collection if there are no incoming edges.
	Returns all incoming sources if given level is nil."

	| incomingSources |
	incomingSources := Set new.
	self incoming
		do: [ :rel | 
			aLevel
				ifNil: [ incomingSources add: rel from ]
				ifNotNil: [ rel from level = level ifTrue: [ incomingSources add: rel from ] ] ].
	^ incomingSources
]

{ #category : #initialization }
AIHgNode >> initialize [
	"Initializes this node by resetting it."

	super initialize.
	self resetHierarchy.
	self resetEdges.
	self resetAttributes
]

{ #category : #testing }
AIHgNode >> isLeafNode [
	^ children isEmpty.

]

{ #category : #testing }
AIHgNode >> isRootNode [
	"Return whether this node is a root node or not."
	^ parent isNil.

]

{ #category : #accessing }
AIHgNode >> level [
	"Returns the level this node is on in the hiGraph."
	^ level.
]

{ #category : #accessing }
AIHgNode >> level: aLevel [
	"Sets the level this node is on in the hiGraph."
	level := aLevel.
]

{ #category : #testing }
AIHgNode >> notLeafNode [
	"Return whether this node is not a leaf node, false if it is."

	^ children isNotEmpty
]

{ #category : #testing }
AIHgNode >> notRootNode [
	"Return whether this node is not a root node, false if it is."

	^ parent isNotNil
]

{ #category : #accessing }
AIHgNode >> outgoing [
	"Returns all outgoing relationships."
	^ outgoing.

]

{ #category : #enumerating }
AIHgNode >> outgoingDestinations [
	"Returns a set of all destination nodes of all outgoing edge target nodes.
	Returns an empty set if there are no such nodes."
	^ self outgoingDestinations: nil.
]

{ #category : #enumerating }
AIHgNode >> outgoingDestinations: aLevel [
	"Returns a collection of all destination nodes of all outgoing relationship that are on given level.
	Returns an empty collection if there are no such nodes.
	Returns all outgoing destinations if given level is nil."

	| outgoingDestinations |
	outgoingDestinations := Set new.
	self outgoing
		do: [ :rel | 
			aLevel
				ifNil: [ outgoingDestinations add: rel destination ]
				ifNotNil: [ rel destination level = level ifTrue: [ outgoingDestinations add: rel destination ] ] ].
	^ outgoingDestinations
]

{ #category : #enumerating }
AIHgNode >> outgoingEdges: aLevel [
	"Returns a collection of all of all outgoing relationship that are on given level.
	Returns an empty collection if there are no such relationships.
	Returns all outgoing relationships if given level is nil."

	| outgoingRelationships |
	outgoingRelationships := Set new.
	self outgoing
		do: [ :rel | 
			aLevel
				ifNil: [ outgoingRelationships add: rel ]
				ifNotNil: [ rel to level = level ifTrue: [ outgoingRelationships add: rel ] ] ].
	^ outgoingRelationships
]

{ #category : #enumerating }
AIHgNode >> outgoingNotPropagated [
	"Returns all outgoing relationships that were not propagated."
	^ outgoing reject: [ :rel | rel class = AIHgPropagatedEdge ].

]

{ #category : #enumerating }
AIHgNode >> outgoingPropagated [
	"Returns all outgoing relationships that were propagated."
	^ outgoing select: [ :rel | rel class = AIHgPropagatedEdge ].

]

{ #category : #enumerating }
AIHgNode >> outgoingTo: aNode [
	"Returns all relationships that are outgoing to given node, empty collection if no such relationship was found."
	| resultSet |
	resultSet := Set new.
	self outgoing do: [:rel | 
		(rel to == aNode) ifTrue: [
			resultSet add: rel.
		].
	].
	^ resultSet.
]

{ #category : #enumerating }
AIHgNode >> outgoingToThese: aNodeCollection [
	"Returns all relationships that are outgoing to given one or more of given node collection, empty collection if no such relationship was found."
	 | resultSet |
	resultSet := Set new.
	aNodeCollection do: [ :node |
		resultSet addAll: (self outgoingTo: node).
	].
	^ resultSet.
	
]

{ #category : #accessing }
AIHgNode >> parent [
	"Returns the parent of this node. If node returns nil, it is a root node."
	^ parent.

]

{ #category : #accessing }
AIHgNode >> parent: aNode [
	"Sets parent of this node"
	parent := aNode.

]

{ #category : #accessing }
AIHgNode >> parentOnLevel: aLevel [
	"Returns the node that is on given level in this nodes ancestry.
	Returns nil if this node is on the same or on a deeper level than given one 
	or if given level does not exist in the graph (i.e. greater level than leaf nodes)."
	| levelDifference currentNode |
	
	self assert: aLevel >= 0 description: 'Smalles possible level is 0 (root nodes), negative levels do not exists. Given level was: ', aLevel asString.
	
	self level <= aLevel ifTrue: [ ^ nil ].
	
	levelDifference := self level - aLevel.
	currentNode := self.

	[levelDifference ~= 0] whileTrue: [
		currentNode := currentNode parent.	
		levelDifference := levelDifference - 1.
	].

	^ currentNode.
	

]

{ #category : #enumerating }
AIHgNode >> recursiveChildren [
	"Returns the whole family tree below myself (excluding myself)."
	^ self recursiveChildren: false.
	
]

{ #category : #enumerating }
AIHgNode >> recursiveChildren: withMyself [
	"Returns the whole family tree below myself. 
	If withMyself is true, also add myself to the returning collection."
	| result |
	result := Set new.
	
	withMyself ifTrue: [
		result add: self.
	].
	
	self isLeafNode ifTrue: [
		^ result.	
	].

	result addAll: children.
	
	children do: [ :each | 
		result addAll: (each recursiveChildren: true). 
	].

	^ result.
]

{ #category : #resetting }
AIHgNode >> resetAttributes [
	"Resets this nodes attributes."
	attributes := Dictionary new.
]

{ #category : #resetting }
AIHgNode >> resetEdges [
	"Resets this nodes edges"
	outgoing := OrderedCollection new. "Outgoing Edges"
	incoming := OrderedCollection new. "Incoming Edges"
]

{ #category : #resetting }
AIHgNode >> resetHierarchy [
	"Resets this nodes children"
	children := OrderedCollection new. "My direct children"
]

{ #category : #ordering }
AIHgNode >> setLevels [
	"Set levels of all my children if I have any. I have to have a level set for this to work."

	| currLevelCollection |
	self assert: level isNotNil description: 'This node must have a level set to set its childrens level'.
	currLevelCollection := hiGraph levels at: level ifAbsentPut: [ OrderedCollection new ].

	"We have already added the root nodes in the process. No need to add them again."
	self notRootNode ifTrue: [ currLevelCollection add: self ].

	"Recurse if this node has children."
	self notLeafNode
		ifTrue: [ children
				do: [ :childNode | 
					childNode level: level + 1.
					childNode setLevels ] ]
]

{ #category : #printing }
AIHgNode >> shortName [
	"Returns a short name of this node."
	^ model name.
]
