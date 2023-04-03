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
			((each distance < lowKey) & (each visited not) ) ifTrue: [ 
					lowKey := each distance.
					lowNode := each 
				]
		 ].
	^lowNode
]

{ #category : #configuration }
AIPrim >> nodeClass [ 
	^ AIBFSNode 
]

{ #category : #running }
AIPrim >> run [ 
	|curNode curEdge treeEdges fromNode toNode|
	
	nodes do: [ :each | each distance: Float infinity ].
	
	treeEdges := OrderedCollection new.
	
	nodes first distance: 0; previousNode: nil.

	(nodes size ) timesRepeat: [ 
			curNode := self minNode.
			curNode visited: true.
			curNode previousNode ifNotNil: [ 
					treeEdges add: { curNode previousNode. curNode. curNode distance }.
				 ].
			
			edges do: [ :edge |
					curEdge := edge asTuple.
					fromNode := (self findNode: (curEdge first)).
					toNode := (self findNode: (curEdge second)).
					((fromNode == curNode) & (curEdge third < toNode distance) & (toNode visited not)) ifTrue: [ 
							toNode previousNode: curNode.
							toNode distance: curEdge third.
						]
				 ].
		 ].
	
	^treeEdges  
	
]
