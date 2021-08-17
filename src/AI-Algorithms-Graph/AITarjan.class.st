"
I implement the well known Tarjan's algorithm. My purpose is to find the strongly connected components (aka circuits /cycles) of a graph in O(m+n).
See https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm for more details.

Instance variable `sccs` means strongly connected components. It is an array with all the strngly connected components that the algorithm found.
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

	"Finding a 'root' node means that we found a strongly connected component. The 'root' node represents the beginning of that strongly connected component"

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
AITarjan >> popStackAndAddNewSccUntil: aTarjanNode [

	| currentNode stronglyConnectedComponent |
	stronglyConnectedComponent := OrderedCollection empty.
	[ 
	currentNode := stack pop.
	currentNode popped.
	stronglyConnectedComponent add: currentNode ] doWhileFalse: [ 
		currentNode = aTarjanNode ].
	sccs add: stronglyConnectedComponent.
	stronglyConnectedComponent do: [ :each | 
		each cycleNodes: stronglyConnectedComponent ]
]

{ #category : #running }
AITarjan >> putOnStack: aTarjanNode [

	stack push: aTarjanNode.
	"I use a flag to avoid stack access. The stack data structure doesn't allow to check which items has. For this algorithm we need to see if a node is in the stack"
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

	aTarjanNode tarjanIndex: runningIndex.
	aTarjanNode tarjanLowlink: runningIndex.
	runningIndex := runningIndex + 1.
	self putOnStack: aTarjanNode.
	aTarjanNode nextNodes do: [ :adjacentNode | 
		adjacentNode isTarjanUndefined
			ifTrue: [ 
				self traverse: adjacentNode.
				aTarjanNode tarjanLowlink:
					(aTarjanNode tarjanLowlink min: adjacentNode tarjanLowlink) ]
			ifFalse: [ 
				adjacentNode inStack ifTrue: [ 
					aTarjanNode tarjanLowlink:
						(aTarjanNode tarjanLowlink min: adjacentNode tarjanIndex) ] ] ].
	(self isRootNode: aTarjanNode) ifTrue: [ 
		self popStackAndAddNewSccUntil: aTarjanNode ]
]
