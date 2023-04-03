Class {
	#name : #AIPrim,
	#superclass : #AIGraphAlgorithm,
	#category : #'AI-Algorithms-Graph'
}

{ #category : #configuration }
AIPrim >> edgeClass [ 
	^ AIWeightedEdge
]

{ #category : #initialization }
AIPrim >> initialize [ 
	super initialize.
]

{ #category : #accessing }
AIPrim >> minNode [
	|lowNode lowKey|
	lowKey := Float infinity.
	nodes do: [ :each | 
			((each distance < lowKey) & (each visited not) ) ifTrue: [ lowNode := each ]
		 ].
	^lowNode
]

{ #category : #configuration }
AIPrim >> nodeClass [ 
	^ AIBFSNode 
]

{ #category : #running }
AIPrim >> run [ 
	|firstNode numNodes curNode curEdge treeEdges|
	nodes do: [ :each | each distance: Float infinity ].
	
	treeEdges := OrderedCollection new.
	firstNode := nodes first.
	firstNode distance: 0.

	numNodes := nodes size.

	numNodes timesRepeat: [ 
			curNode := self minNode.
			edges do: [ :edge |
					curEdge := edge asTuple.
					(curEdge first == curNode) ifTrue: [ 
							((curEdge third < curEdge second distance) & (curEdge second visited not)) ifTrue: [ 
									curEdge second previous: curNode.
									curEdge second visited: true.
									treeEdges add: edge.
								 ]
						 ]
				 ]
		 ].
	^treeEdges  
	
]
