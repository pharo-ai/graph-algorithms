"
I implement the Hopcroft-Karp algorithm to find the maximum-cardinality matching in a bipartite graph.

It executes in strict O(E * sqrt(V)) time, making it significantly faster than standard Ford-Fulkerson or Edmonds-Karp approaches for bipartite structures.

Key Implementation Details:
- Strict Separation: Dynamically partitions the bipartite graph into U and V sets directly from the provided edges, bypassing standard wrapper limits.
- Optimized Queues: BFS strict bounds use SmallInteger maxVal instead of float infinity to guarantee lightning-fast == identity checks.
- Robust Augmenting Paths: DFS uses IdentityDictionary lookups to trace exactly the shortest augmenting paths without nilNode queue leakage.
"
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
	#category : 'AI-Algorithms-Graph-Graph Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Graph Matching'
}

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

{ #category : 'private' }
AIHopcroftKarp >> findNeighborsOf: aNode [
    ^ aNode adjacentNodes
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

{ #category : 'accessing' }
AIHopcroftKarp >> matchingEdgeTuples [
	"Answer the matching edges found after the run."

	| tuples |
	tuples := OrderedCollection new: pairU size.
	pairU associationsDo: [ :pair | tuples add: (Array with: pair key model with: pair value model) ].
	^ tuples
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
