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
		'memoizationCache'
	],
	#category : 'AI-Algorithms-Graph-Shortest path',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Shortest path'
}

{ #category : 'running' }
AIShortestPathWithMaxAndMinNodes >> distanceTo: aModel isLessThan: aNumber [

	"Evaluates the algorithm lattice. 
    Returns 1 (True), 0 (Reduced/Harmless Cycle), or -1 (False/Amplifying Cycle)."

    | v memo isMaxNode res |
    v := self findNode: aModel.

    memo := memoizationCache at: v ifAbsentPut: [ Dictionary new ].
    memo keysAndValuesDo: [ :limit :val |
        (limit <= aNumber and: [ val = 1 ]) ifTrue: [ ^ 1 ].
        (limit >= aNumber and: [ val = -1 ]) ifTrue: [ ^ -1 ].
        (limit <= aNumber and: [ val = 0 ]) ifTrue: [ ^ 0 ].
    ].

    (v = start and: [ aNumber >= 0 ]) ifTrue: [ ^ 1 ].

    v incomingEdges ifEmpty: [ ^ -1 ].

    active at: v ifPresent: [ :d |
        ^ aNumber > d 
            ifTrue: [ -1 ] 
            ifFalse: [ 0 ] 
    ].

    active at: v put: aNumber.
    isMaxNode := isMaxNodePredicate value: v model.

    res := isMaxNode ifTrue: [ 1 ] ifFalse: [ -1 ].

    v incomingEdges do: [ :e |
        | u prev |
        u := e from.
        prev := self distanceTo: u model isLessThan: (aNumber - e weight).

        isMaxNode 
            ifTrue: [ res := res min: prev ] 
            ifFalse: [ res := res max: prev ]. 
    ].

    active removeKey: v.
    memo at: aNumber put: res.
    ^ res
]

{ #category : 'configuration' }
AIShortestPathWithMaxAndMinNodes >> edgeClass [

	^ AIWeightedEdge
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> initialize [

    super initialize.
    active := Dictionary new.
    memoizationCache := Dictionary new.
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> isMaxNodePredicate: aBlock [

	isMaxNodePredicate := aBlock
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> memoDictionary: aDictionary [

	memoizationCache := aDictionary
]

{ #category : 'configuration' }
AIShortestPathWithMaxAndMinNodes >> nodeClass [

	^ AIWeightedHitsNode
]

{ #category : 'running' }
AIShortestPathWithMaxAndMinNodes >> run [

    start ifNil: [ Error signal: 'Start node must be set before running' ].
    active removeAll.
    memoizationCache removeAll.
]

{ #category : 'running' }
AIShortestPathWithMaxAndMinNodes >> runFrom: aModel [

    self start: aModel.
    self run.
]

{ #category : 'initialization' }
AIShortestPathWithMaxAndMinNodes >> start: aModel [

	start := (self findNode: aModel).

]
