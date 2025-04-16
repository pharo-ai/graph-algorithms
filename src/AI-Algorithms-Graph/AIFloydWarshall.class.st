"
The Floyd-Warshall algorithm is used to find the shortest paths between all pairs of vertices in a weighted graph. This implementation works with both positive and negative edge weights (as long as there are no negative weight cycles) and can detect negative weight cycles in the graph.

The algorithm uses a distance matrix to track the shortest known distances between all pairs of nodes and a next matrix to reconstruct the shortest paths.

Usage example:

fw := AIFloydWarshall new
    nodes: #(1 2 3);
    edges: { #(1 2 4). #(2 3 -2). #(3 1 1) }
        from: #first to: #second weight: #third;
    run.

fw distanceFrom: 1 to: 3.  ""Returns 2""
fw pathFrom: 1 to: 3.      ""Returns #(1 2 3)""
"
Class {
	#name : 'AIFloydWarshall',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'distanceMatrix',
		'nextMatrix',
		'hasNegativeCycle'
	],
	#category : 'AI-Algorithms-Graph-Shortest path',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Shortest path'
}

{ #category : 'private' }
AIFloydWarshall >> computeAllPairsShortestPaths [

	nodes do: [ :k |
        nodes do: [ :i |
            nodes do: [ :j |
                | currentDist throughK |
                currentDist := distanceMatrix at: {i. j}.
                ((distanceMatrix at: {i. k}) ~= Float infinity and: [
                   (distanceMatrix at: {k. j}) ~= Float infinity ]) ifTrue: [
                    throughK := (distanceMatrix at: {i. k}) + (distanceMatrix at: {k. j}).
                    throughK < currentDist ifTrue: [
                        distanceMatrix at: {i. j} put: throughK.
                        nextMatrix at: {i. j} put: (nextMatrix at: {i. k}) ] ] ] ] ]
]

{ #category : 'configuration' }
AIFloydWarshall >> distanceFrom: sourceModel to: destinationModel [

| source destination |
	source := self findNode: sourceModel.
	destination := self findNode: destinationModel.
	^ distanceMatrix at: {source. destination}
]

{ #category : 'accessing' }
AIFloydWarshall >> distanceMatrix [

	^ distanceMatrix
]

{ #category : 'configuration' }
AIFloydWarshall >> edgeClass [
	
	^ AIWeightedEdge
]

{ #category : 'running' }
AIFloydWarshall >> getAllPairsDistances [

	| result |
	
	result := Dictionary new.
	nodes do: [ :source |
		nodes do: [ :destination |
			result
				at: {
						source model.
						destination model }
				put: (distanceMatrix at: {
							 source.
							 destination }) ] ].

	^ result
]

{ #category : 'running' }
AIFloydWarshall >> getAllPairsPaths [

	| result |
	result := Dictionary new.
	nodes do: [ :source |
		nodes do: [ :destination |
			result
				at: {
						source model.
						destination model }
				put: (self pathFrom: source model to: destination model) ] ].
	^ result
]

{ #category : 'private' }
AIFloydWarshall >> handleNegativeCycles [

	nodes do: [ :v | (distanceMatrix at: {v. v}) < 0 ifTrue: [ hasNegativeCycle := true ] ].
    
    hasNegativeCycle ifTrue: [
        nodes do: [ :k |
            (distanceMatrix at: {k. k}) < 0 ifTrue: [
                nodes do: [ :i |
                    nodes do: [ :j |
                        ((distanceMatrix at: {i. k}) ~= Float infinity and: [
                           (distanceMatrix at: {k. j}) ~= Float infinity ]) ifTrue: [
                            distanceMatrix at: {i. j} put: Float negativeInfinity.
                            nextMatrix at: {i. j} put: nil ] ] ] ] ] ]
]

{ #category : 'accessing' }
AIFloydWarshall >> hasNegativeCycle [

	^ hasNegativeCycle
]

{ #category : 'configuration' }
AIFloydWarshall >> hasPathFrom: sourceModel to: destinationModel [

	| source destination dist |
    source := self findNode: sourceModel.
    destination := self findNode: destinationModel.
    dist := distanceMatrix at: {source. destination}.
    ^ dist ~= Float infinity and: [dist ~= Float negativeInfinity]
]

{ #category : 'initialization' }
AIFloydWarshall >> initialize [

	super initialize.
	distanceMatrix := Dictionary new.
	nextMatrix := Dictionary new.
	hasNegativeCycle := false.
]

{ #category : 'accessing' }
AIFloydWarshall >> nextMatrix [

	^ nextMatrix
]

{ #category : 'configuration' }
AIFloydWarshall >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : 'configuration' }
AIFloydWarshall >> pathFrom: sourceModel to: destinationModel [

	| source destination path current |
	source := self findNode: sourceModel.
	destination := self findNode: destinationModel.

	(distanceMatrix at: {
			 source.
			 destination }) = Float infinity ifTrue: [ ^ #(  ) ].

	(distanceMatrix at: {
			 source.
			 destination }) = Float negativeInfinity ifTrue: [
		^ #( 'Path affected by negative cycle' ) ].

	source = destination ifTrue: [ ^ { source model } ].

	path := OrderedCollection new.
	path add: source model.

	current := source.
	[ current ~= destination ] whileTrue: [
		current := nextMatrix at: {
				           current.
				           destination }.
		current ifNil: [
			^ #( 'Path broken - possible negative cycle effect' ) ].
		path add: current model ].

	^ path asArray
]

{ #category : 'actions' }
AIFloydWarshall >> reset [

	distanceMatrix := Dictionary new.
	nextMatrix := Dictionary new.
	hasNegativeCycle := false.
	self setupMatrices
]

{ #category : 'running' }
AIFloydWarshall >> run [

	self reset.
    self computeAllPairsShortestPaths.
    self handleNegativeCycles.
]

{ #category : 'configuration' }
AIFloydWarshall >> setupMatrices [

	| infinity |
	infinity := Float infinity.

	nodes do: [ :u |
		nodes do: [ :v |
			distanceMatrix at: {u. v} put: (u = v ifTrue: [ 0 ] ifFalse: [ infinity ]).
			nextMatrix at: {u. v} put: (u = v ifTrue: [ u ] ifFalse: [ nil ]).
		].
	].

	edges do: [ :edge |
		distanceMatrix at: {edge from. edge to} put: edge weight.
		nextMatrix at: {edge from. edge to} put: edge to.
	].
]
