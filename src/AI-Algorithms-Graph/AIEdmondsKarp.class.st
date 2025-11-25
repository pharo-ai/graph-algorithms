"
The Edmonds-Karp algorithm is an implementation of the Ford-Fulkerson method for computing the maximum flow in a flow network. It uses breadth-first search to find the shortest augmenting path from source to sink in terms of the number of edges.

The algorithm works by:
1. Initialize flow to 0 for all edges
2. While there exists an augmenting path from source to sink:
   a. Find the shortest augmenting path using BFS
   b. Find the minimum residual capacity along this path
   c. Update the flow along this path
3. Return the maximum flow value

Time complexity: O(VE²) where V is the number of vertices and E is the number of edges.

Example usage:
|nodes edges edmondsKarp maxFlow|
nodes := #( $s $a $b $t ).
edges := #( #( $s $a 10 ) #( $s $b 8 ) #( $a $b 5 ) #( $a $t 10 ) #( $b $t 10 ) ).

edmondsKarp := AIEdmondsKarp new.
edmondsKarp nodes: nodes.
edmondsKarp
    edges: edges
    from: [ :each | each first ]
    to: [ :each | each second ]
    capacity: [ :each | each third ].

edmondsKarp source: $s sink: $t.
maxFlow := edmondsKarp run.
"
Class {
	#name : 'AIEdmondsKarp',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'source',
		'sink',
		'parent'
	],
	#category : 'AI-Algorithms-Graph-Maximum Flow',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Maximum Flow'
}

{ #category : 'configuration' }
AIEdmondsKarp >> edgeClass [
	^ AINetworkFlowEdge
]

{ #category : 'building - graph' }
AIEdmondsKarp >> edges: aCollection from: aSource to: target capacity: capacityFunction [
	| edge reverseEdge |
	aCollection do: [ :eModel |
		edge := self addEdge: eModel from: aSource to: target.
		edge ifNotNil: [ 
			edge capacity: (capacityFunction value: eModel).
			edge flow: 0 ].
		
		"Add reverse edge with 0 capacity for residual graph"
		reverseEdge := self addEdge: eModel from: target to: aSource.
		reverseEdge ifNotNil: [ 
			reverseEdge capacity: 0.
			reverseEdge flow: 0 ] ]
]

{ #category : 'private' }
AIEdmondsKarp >> findAugmentingPathBFS [
	"Find an augmenting path from source to sink using BFS.
	Returns true if a path exists, false otherwise.
	Updates the parent array to reconstruct the path."
	
	| queue visited |
	queue := LinkedList new.
	visited := Set new.
	parent := Dictionary new.
	
	queue addLast: source.
	visited add: source.
	
	[ queue isNotEmpty ] whileTrue: [
		| current |
		current := queue removeFirst.
		
		current = sink ifTrue: [ ^ true ].
		
		current outgoingEdges do: [ :edge |
			| neighbor |
			neighbor := edge to.
			
			(visited includes: neighbor) not & (edge residualCapacity > 0) ifTrue: [
				queue addLast: neighbor.
				visited add: neighbor.
				parent at: neighbor put: edge ] ] ].
	
	^ false
]

{ #category : 'private' }
AIEdmondsKarp >> findBottleneckCapacity [
	"Find the minimum residual capacity along the augmenting path"
	
	| current minCapacity |
	current := sink.
	minCapacity := Float infinity.
	
	[ current ~= source ] whileTrue: [
		| edge |
		edge := parent at: current.
		minCapacity := minCapacity min: edge residualCapacity.
		current := edge from ].
	
	^ minCapacity
]

{ #category : 'private' }
AIEdmondsKarp >> findReverseEdge: anEdge [
	"Find the reverse edge for the given edge"
	
	^ anEdge to outgoingEdges 
		detect: [ :edge | edge to = anEdge from ]
		ifNone: [ nil ]
]

{ #category : 'initialization' }
AIEdmondsKarp >> initialize [
	super initialize.
	parent := Dictionary new
]

{ #category : 'configuration' }
AIEdmondsKarp >> nodeClass [
	^ AIPathDistanceNode
]

{ #category : 'running' }
AIEdmondsKarp >> run [
	"Execute the Edmonds-Karp algorithm and return the maximum flow value"
	
	| maxFlow pathFlow |
	maxFlow := 0.
	
	[ self findAugmentingPathBFS ] whileTrue: [
		pathFlow := self findBottleneckCapacity.
		self updateFlowAlongPath: pathFlow.
		maxFlow := maxFlow + pathFlow ].
	
	^ maxFlow
]

{ #category : 'accessing' }
AIEdmondsKarp >> source: sourceNode sink: sinkNode [
	source := self findNode: sourceNode.
	sink := self findNode: sinkNode
]

{ #category : 'private' }
AIEdmondsKarp >> updateFlowAlongPath: flowValue [
	"Update the flow along the augmenting path found by BFS"
	
	| current |
	current := sink.
	
	[ current ~= source ] whileTrue: [
		| edge reverseEdge |
		edge := parent at: current.
		
		"Update forward edge flow"
		edge flow: edge flow + flowValue.
		
		"Update reverse edge flow"
		reverseEdge := self findReverseEdge: edge.
		reverseEdge flow: reverseEdge flow - flowValue.
		
		current := edge from ]
]
