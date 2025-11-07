"
Algorithm for shortest path in graphs with ""max"" vertices as well as ""min"" vertices, used in the implementation of ABCD.
The graph can have negative cycles, as long as they contain at least one max node.
If a path doesn't exist it returns Float infinity.

Possible results are {1, 0, -1}, which map to {True, Reduced, False} in the paper's algorithm.
True and Reduced means the check is redundant (with Reduced meaning a cycle was reduced)
C is a table used for memoization, that maps [v-a<=c] into {True, False, Reduced}
active detects cycles: if active[v] != null, then active[v] is the distance of v from b, where b is the check’s index variable.
active maintains the distance for each vertex v that is on the path on the current DFS stack
isMaxNodePredicate is used to know if a given node is a max node (i.e. is in V_phi)
"
Class {
	#name : 'AIShortestPathWithMaxAndMinNodes',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'start',
		'isMaxNodePredicate',
		'active',
		'c'
	],
	#category : 'AI-Algorithms-Graph-Shortest Path',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Shortest Path'
}

{ #category : 'running' }
AIShortestPathWithMaxAndMinNodes >> distanceTo: aModel isLessThan: number [

	| memo isMaxNode v |
	"start == a"
	v := self findNode: aModel.

	memo := c at: { v. start } ifAbsentPut: [ Dictionary new ].

	memo keysAndValuesDo: [ :key :val |
		(key <= number and: val = 1) ifTrue: [ ^ 1 ] ].

	memo keysAndValuesDo: [ :key :val |
		(key >= number and: val = -1) ifTrue: [ ^ -1 ] ].

	memo keysAndValuesDo: [ :key :val |
		(key <= number and: val = 0) ifTrue: [ ^ 0 ] ].

	(v = start and: number >= 0) ifTrue: [ ^ 1 ].

	v incomingEdges ifEmpty: [ ^ -1 ].

	active at: v ifPresent: [ :d |
		^ number > d
			  ifTrue: [ -1 ]
			  ifFalse: [ 0 ] ].

	active at: v put: number.
	isMaxNode := isMaxNodePredicate value: v model.
	v incomingEdges do: [ :e |
		| u res prev |
		u := e from.
		res := self distanceTo: u model isLessThan: number - e weight.
		prev := memo at: number ifAbsent: [isMaxNode
													ifTrue: [ 1 ]
													ifFalse: [ -1 ]].
		memo at: number put: (isMaxNode
			ifTrue: [ prev min: res ]
			ifFalse: [ prev max: res ])
	].
	active removeKey: v.

	^ memo at: number
]

{ #category : 'configuration' }
AIShortestPathWithMaxAndMinNodes >> edgeClass [

	^ AIWeightedEdge
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> initialize [

	super initialize.
	active := Dictionary new. "Deberia venir de arriba?"
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> isMaxNodePredicate: aBlock [

	isMaxNodePredicate := aBlock
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> memoDictionary: aDictionary [

	c := aDictionary
]

{ #category : 'configuration' }
AIShortestPathWithMaxAndMinNodes >> nodeClass [

	^ AIWeightedHitsNode
]

{ #category : 'running' }
AIShortestPathWithMaxAndMinNodes >> run [

	
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> start: aModel [

	start := (self findNode: aModel).

]
