Class {
	#name : 'AIHopcroftKarp',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'pairU',
		'pairV',
		'dist',
		'queue',
		'nilNode',
		'adjacencyList',
		'infinity'
	],
	#category : 'AI-Algorithms-Graph',
	#package : 'AI-Algorithms-Graph'
}

{ #category : 'as yet unclassified' }
AIHopcroftKarp >> adjacentNodesOf: u [
	^ adjacencyList at: u ifAbsent: [ #() ]
]

{ #category : 'backtracking' }
AIHopcroftKarp >> bfs [
	queue removeAll.
	
	pairU keysDo: [ :u |
		(pairU at: u) == nilNode
			ifTrue: [ dist at: u put: 0. queue addLast: u ]
			ifFalse: [ dist at: u put: infinity ] ].
			
	dist at: nilNode put: infinity.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| u |
		u := queue removeFirst.
		(dist at: u) < (dist at: nilNode) ifTrue: [ 
			(adjacencyList at: u ifAbsent: [ #() ]) do: [ :v |
				| pairedU |
				pairedU := pairV at: v ifAbsent: [ nilNode ].
				(dist at: pairedU) == infinity ifTrue: [ 
					dist at: pairedU put: (dist at: u) + 1.
					pairedU == nilNode ifFalse: [ queue addLast: pairedU ] ] ] ] ].
			
	^ (dist at: nilNode) ~= infinity
]

{ #category : 'backtracking' }
AIHopcroftKarp >> dfs: u [
	u == nilNode ifFalse: [ 
		(adjacencyList at: u ifAbsent: [ #() ]) do: [ :v |
			| pairedU |
			pairedU := pairV at: v ifAbsent: [ nilNode ].
			(dist at: pairedU) == ((dist at: u) + 1) ifTrue: [ 
				(self dfs: pairedU) ifTrue: [ 
					pairV at: v put: u.
					pairU at: u put: v.
					^ true ] ] ].
		
		dist at: u put: infinity.
		^ false ].
	^ true
]

{ #category : 'as yet unclassified' }
AIHopcroftKarp >> findNeighborsOf: aNode [
	(aNode respondsTo: #adjacentNodes) ifTrue: [ ^ aNode adjacentNodes ].
	(aNode respondsTo: #outgoingNodes) ifTrue: [ ^ aNode outgoingNodes ].
	(aNode respondsTo: #outgoingEdges) ifTrue: [ 
		^ aNode outgoingEdges collect: [ :e | 
			(e respondsTo: #to) ifTrue: [ e to ] ifFalse: [ e target ] ] ].
	^ #()
]

{ #category : 'initialization' }
AIHopcroftKarp >> initializeVariables [
	pairU := IdentityDictionary new.
	pairV := IdentityDictionary new.
	dist := IdentityDictionary new.
	adjacencyList := IdentityDictionary new.
	queue := OrderedCollection new.
	nilNode := Object new.
	infinity := SmallInteger maxVal. 
	
	self nodes do: [ :node | 
		| neighbors |
		neighbors := self findNeighborsOf: node.
		adjacencyList at: node put: neighbors.
		
		neighbors isNotEmpty ifTrue: [ 
			pairU at: node put: nilNode.
			neighbors do: [ :v | pairV at: v put: nilNode ] ] ].
]

{ #category : 'running' }
AIHopcroftKarp >> run [
	| matchingSize |
	self initializeVariables.
	matchingSize := 0.
	
	[ self bfs ] whileTrue: [
		pairU keysDo: [ :u |
			(pairU at: u) == nilNode ifTrue: [
				(self dfs: u) ifTrue: [ matchingSize := matchingSize + 1 ] ] ] ].
		
	^ matchingSize
]
