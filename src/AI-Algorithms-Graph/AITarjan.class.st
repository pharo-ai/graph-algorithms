"
I implement the well known Tarjan's algorithm. My purpose is to find the strongly connected components (aka circuits /cycles) of a graph in O(m+n).
See https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm for more details.
"
Class {
	#name : #AITarjan,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'stack',
		'runningIndex',
		'sccs'
	],
	#category : #'AI-Algorithms-Graph-Tarjan'
}

{ #category : #accessing }
AITarjan >> circuits [

	^ self stronglyConnectedComponents select: [ :each | each size > 1 ]
]

{ #category : #accessing }
AITarjan >> findNode: aModel ifAbsent: aBlock [

	^ nodes at: aModel ifAbsent: aBlock
]

{ #category : #initialization }
AITarjan >> initialize [

	super initialize.
	nodes := Dictionary new
]

{ #category : #testing }
AITarjan >> isRootNode: aTarjanNode [

	^ aTarjanNode tarjanIndex = aTarjanNode tarjanLowlink
]

{ #category : #configuration }
AITarjan >> nodeClass [

	^ AITarjanNode
]

{ #category : #accessing }
AITarjan >> nodes [

	^ nodes values
]

{ #category : #'building - graph' }
AITarjan >> nodes: aCollection [

	aCollection do: [ :model | 
		nodes at: model put: (self nodeClass with: model) ]
]

{ #category : #setting }
AITarjan >> nodesAndNextFrom: aNodeList [

	aNodeList do: [ :node | 
		nodes at: node model put: (self nodeClass with: node model) ].
	aNodeList do: [ :node | 
		node nextNodes do: [ :each | 
			(self findNode: node model) to: (self findNode: each model) ] ]
]

{ #category : #running }
AITarjan >> popStackAndUpdateCurrentScc: aComponent until: aTarjanNode [

	| currentNode |
	[ 
	currentNode := stack pop.
	currentNode popped.
	aComponent add: currentNode ] doWhileFalse: [ 
		currentNode = aTarjanNode ].
	sccs add: aComponent.
	aComponent do: [ :each | each cycleNodes: aComponent ]
]

{ #category : #running }
AITarjan >> putOnStack: aTarjanNode [

	stack push: aTarjanNode.
	"I use a flag to avoid stack access"
	aTarjanNode inStack: true
]

{ #category : #running }
AITarjan >> run [

	sccs := OrderedCollection new.
	stack := Stack new.
	runningIndex := 0.
	self nodes do: [ :n | 
		n isTarjanUndefined ifTrue: [ self traverse: n ] ].
	^ sccs
]

{ #category : #accessing }
AITarjan >> stronglyConnectedComponents [

	^ sccs ifNil: [ self run ]
]

{ #category : #running }
AITarjan >> traverse: aTarjanNode [

	| component |
	aTarjanNode tarjanIndex: runningIndex.
	aTarjanNode tarjanLowlink: runningIndex.
	runningIndex := runningIndex + 1.
	self putOnStack: aTarjanNode.
	self traverseChildrenOf: aTarjanNode.
	(self isRootNode: aTarjanNode) ifFalse: [ ^ self ].
	component := OrderedCollection new. "start new SCC"
	self popStackAndUpdateCurrentScc: component until: aTarjanNode
]

{ #category : #running }
AITarjan >> traverseChildrenOf: aTarjanNode [

	aTarjanNode nextNodes do: [ :next | 
		next isTarjanUndefined
			ifTrue: [ 
				self traverse: next.
				aTarjanNode tarjanLowlink:
					(aTarjanNode tarjanLowlink min: next tarjanLowlink) ]
			ifFalse: [ 
				next inStack ifTrue: [ 
					aTarjanNode tarjanLowlink:
						(aTarjanNode tarjanLowlink min: next tarjanIndex) ] ] ]
]
