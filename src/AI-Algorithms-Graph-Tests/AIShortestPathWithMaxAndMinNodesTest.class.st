Class {
	#name : 'AIShortestPathWithMaxAndMinNodesTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests',
	#package : 'AI-Algorithms-Graph-Tests'
}

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testAmplifyingCycleBehindMinNode [

    | algo edges |

    edges := #( #(1 2 10) #(1 3 -5) #(3 4 -5) #(4 3 -5) #(2 5 0) #(3 5 0) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5); start: 1; isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo run.

    self assert: (algo distanceTo: 5 isLessThan: 15) equals: 1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testAmplifyingNegativeCycle [

    | algo edges |

    edges := #( #(1 2 10) #(2 3 -5) #(3 2 -5) #(2 4 10) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4).
    algo edges: edges from: #first to: #second weight: #third.

    algo isMaxNodePredicate: [ :node | node = 2 ].
    algo 
    	start: 1;
    	run.

    self assert: (algo distanceTo: 4 isLessThan: 100) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testDisconnectedGraph [
    | algo edges |

    edges := #( #(1 2 5) #(3 4 10) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4).
    algo edges: edges from: #first to: #second weight: #third.
    algo isMaxNodePredicate: [ :node | false ].
    algo runFrom: 1.

    self assert: (algo distanceTo: 4 isLessThan: 100) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testExactBoundMatch [

    | algo edges |

    edges := #( #(1 2 10) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2); start: 1; isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo run.
    self assert: (algo distanceTo: 2 isLessThan: 10) equals: 1.
    self assert: (algo distanceTo: 2 isLessThan: 9) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testHarmlessCycleBehindMaxNode [

    | algo edges |

    edges := #( #(1 2 10) #(3 4 5) #(4 3 5) #(2 5 0) #(3 5 0) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5); start: 1; isMaxNodePredicate: [ :n | n = 5 ].
    algo edges: edges from: #first to: #second weight: #third.
    algo run.

    self assert: (algo distanceTo: 5 isLessThan: 15) equals: 0.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testHarmlessPositiveCycle [

    | algo edges |

    edges := #( #(1 2 10) #(2 3 5) #(3 2 5) #(2 4 10) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4).
    algo edges: edges from: #first to: #second weight: #third.
    algo isMaxNodePredicate: [ :node | false ].
    algo 
    	start: 1;
    	run.

    self assert: (algo distanceTo: 4 isLessThan: 25) equals: 1. 
    self assert: (algo distanceTo: 4 isLessThan: 15) equals: 0.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testLargeGraphPerformanceAndMemoization [

    | algo edges n |
    n := 1000.
    edges := OrderedCollection new.

    1 to: n - 1 do: [ :i |
        edges add: { i . i + 1 . 1 }.
        (i + 2 <= n) ifTrue: [ edges add: { i . i + 2 . 2 } ].
    ].
    
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: (1 to: n) asArray.
    algo edges: edges asArray from: #first to: #second weight: #third.

    algo isMaxNodePredicate: [ :node | node even ].
    algo runFrom: 1.

    self assert: (algo distanceTo: n isLessThan: 1000) equals: 1.
    self assert: (algo distanceTo: n isLessThan: 998) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testLinearDAG [

    | algo edges |

    edges := #( #(1 2 5) #(2 3 5) #(3 4 5) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4); isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.
    self assert: (algo distanceTo: 4 isLessThan: 15) equals: 1.
    self assert: (algo distanceTo: 4 isLessThan: 14) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testMaxNodeCircuitBreaker [

    | algo edges |

    edges := #( #(1 2 10) #(3 2 0) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3).
    algo edges: edges from: #first to: #second weight: #third.

    algo isMaxNodePredicate: [ :node | false ].
    algo 
    	start: 1;
    	run.
    self assert: (algo distanceTo: 2 isLessThan: 15) equals: 1.

    algo run. 
    algo isMaxNodePredicate: [ :node | node = 2 ].
    algo run.
    self assert: (algo distanceTo: 2 isLessThan: 15) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testMinVsMaxNodeLogic [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 10) #(2 4 0) #(3 4 0) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4).
    algo edges: edges from: #first to: #second weight: #third.

    algo isMaxNodePredicate: [ :node | false ].
    algo 
    	start: 1;
    	run.
    self assert: (algo distanceTo: 4 isLessThan: 6) equals: 1. 

    algo run. 
    algo isMaxNodePredicate: [ :node | node = 4 ].
    algo run.
    self assert: (algo distanceTo: 4 isLessThan: 6) equals: -1. 
    self assert: (algo distanceTo: 4 isLessThan: 11) equals: 1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testMixedMinMaxLattice [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 10) #(2 4 0) #(3 4 0) #(1 5 15) #(1 6 20) #(5 7 0) #(6 7 0) #(4 8 0) #(7 8 0) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5 6 7 8); isMaxNodePredicate: [ :n | n = 8 ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.

    self assert: (algo distanceTo: 8 isLessThan: 15) equals: 1.
    self assert: (algo distanceTo: 8 isLessThan: 14) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testMultipleMaxBranching [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 10) #(1 5 15) #(2 4 0) #(3 4 0) #(5 4 0) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5); isMaxNodePredicate: [ :n | n = 4 ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.

    self assert: (algo distanceTo: 4 isLessThan: 15) equals: 1.
    self assert: (algo distanceTo: 4 isLessThan: 14) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testMultipleMinBranching [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 10) #(1 5 15) #(2 4 0) #(3 4 0) #(5 4 0) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5); isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.

    self assert: (algo distanceTo: 4 isLessThan: 5) equals: 1.
    self assert: (algo distanceTo: 4 isLessThan: 4) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testOverlappingPathsMemoization [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 5) #(2 4 5) #(3 4 5) #(4 5 5) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5); isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.
    self assert: (algo distanceTo: 5 isLessThan: 15) equals: 1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testReducedLatticePropagation [

    | algo edges |

    edges := #( #(2 3 5) #(3 2 5) #(1 5 10) #(2 6 0) #(4 6 0) #(2 7 0) #(5 7 0) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3 4 5 6 7); isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.

    self assert: (algo distanceTo: 6 isLessThan: 20) equals: 0.
    self assert: (algo distanceTo: 7 isLessThan: 20) equals: 1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testStandardShortestPathDAG [

    | algo edges |

    edges := #( #(1 2 5) #(1 3 2) #(3 2 1) ).

    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3).
    algo edges: edges from: #first to: #second weight: #third.
    algo isMaxNodePredicate: [ :node | false ].
    algo runFrom: 1.

    self assert: (algo distanceTo: 2 isLessThan: 3) equals: 1.
    self assert: (algo distanceTo: 2 isLessThan: 2) equals: -1.
]

{ #category : 'tests' }
AIShortestPathWithMaxAndMinNodesTest >> testUnreachableTarget [

    | algo edges |

    edges := #( #(1 2 5) ).
    algo := AIShortestPathWithMaxAndMinNodes new.
    algo nodes: #(1 2 3); isMaxNodePredicate: [ :n | false ].
    algo edges: edges from: #first to: #second weight: #third.
    algo runFrom: 1.
    self assert: (algo distanceTo: 3 isLessThan: 100) equals: -1.
]
