"
I implement the well known Tarjan's algorithm. My purpose is to find the strongly connected components (aka circuits /cycles) of a graph in O(m+n).
See https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm for more details.

Instance variable `sccs` means strongly connected components. It is an array with all the strngly connected components that the algorithm found. The method `#stronglyConnectedComponents` will return a collection with all the strongly connected components of the graph.

See in my test class examples of how to use me. But in a nutshell:
```
tarjan := AITarjan new
				nodes: #( 1 2 3 );
				edges: { (1 -> 2) . (1 -> 3) . (2 -> 3) } from: #key to: #value;
				yourself.
tarjan run.
tarjan stronglyConnectedComponents
```

"
Class {
	#name : #AITarjan,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'stack',
		'runningIndex',
		'sccs'
	],
	#category : #'AI-Algorithms-Graph-Strongly Connected Components'
}

{ #category : #running }
AITarjan >> addNewSccForNode: aTarjanNode [

	| currentNode stronglyConnectedComponent |
	stronglyConnectedComponent := OrderedCollection empty.

	[ currentNode := stack pop.
	currentNode popped.
	stronglyConnectedComponent add: currentNode ]
	doWhileFalse: [ currentNode = aTarjanNode ].

	sccs add: stronglyConnectedComponent.
	stronglyConnectedComponent do: [ :each | each cycleNodes: stronglyConnectedComponent ]
]

{ #category : #accessing }
AITarjan >> circuits [

	^ self stronglyConnectedComponents select: [ :each | each size > 1 ]
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

{ #category : #running }
AITarjan >> putOnStack: aTarjanNode [

	stack push: aTarjanNode.
	aTarjanNode inStack: true
]

{ #category : #running }
AITarjan >> run [

	sccs := OrderedCollection new.
	stack := Stack new.
	runningIndex := 0.
	self nodes do: [ :node |
		node isTarjanUndefined ifTrue: [ self traverse: node ] ].
	^ self stronglyConnectedComponents
]

{ #category : #accessing }
AITarjan >> stronglyConnectedComponents [

	sccs ifNil: [ self run ].
	^ sccs collect: [ :component | component collect: [ :each | each model ] ]
]

{ #category : #running }
AITarjan >> traverse: aTarjanNode [

	aTarjanNode tarjanIndex: runningIndex.
	aTarjanNode tarjanLowlink: runningIndex.
	runningIndex := runningIndex + 1.

	self putOnStack: aTarjanNode.

	aTarjanNode adjacentNodes do: [ :adjacentNode |
		adjacentNode isTarjanUndefined
			ifTrue: [
				self traverse: adjacentNode.
				aTarjanNode tarjanLowlink:
					(aTarjanNode tarjanLowlink min: adjacentNode tarjanLowlink) ]
			ifFalse: [
				adjacentNode inStack ifTrue: [
					aTarjanNode tarjanLowlink:
						(aTarjanNode tarjanLowlink min: adjacentNode tarjanIndex) ] ] ].

	(self isRootNode: aTarjanNode) ifTrue: [ self addNewSccForNode: aTarjanNode ]
]
