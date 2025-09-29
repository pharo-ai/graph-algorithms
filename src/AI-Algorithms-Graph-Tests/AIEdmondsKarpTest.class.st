"
Test class for the Edmonds-Karp algorithm
"
Class {
	#name : 'AIEdmondsKarpTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests-Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
AIEdmondsKarpTest >> testBasicMaxFlow [
	"Test basic maximum flow computation"
	
	| nodes edges edmondsKarp maxFlow |
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
	
	self assert: maxFlow equals: 18
]

{ #category : 'tests' }
AIEdmondsKarpTest >> testComplexNetwork [
	"Test with a more complex flow network"
	
	| nodes edges edmondsKarp maxFlow |
	nodes := #( 1 2 3 4 5 6 ).
	edges := #( 
		#( 1 2 16 ) #( 1 3 13 ) 
		#( 2 3 10 ) #( 2 4 12 ) 
		#( 3 2 4 ) #( 3 5 14 ) 
		#( 4 3 9 ) #( 4 6 20 ) 
		#( 5 4 7 ) #( 5 6 4 ) ).
	
	edmondsKarp := AIEdmondsKarp new.
	edmondsKarp nodes: nodes.
	edmondsKarp
		edges: edges
		from: [ :each | each first ]
		to: [ :each | each second ]
		capacity: [ :each | each third ].
	
	edmondsKarp source: 1 sink: 6.
	maxFlow := edmondsKarp run.
	
	self assert: maxFlow equals: 23
]

{ #category : 'tests' }
AIEdmondsKarpTest >> testNoPath [
	"Test when there's no path from source to sink"
	
	| nodes edges edmondsKarp maxFlow |
	nodes := #( $a $b $c $d ).
	edges := #( #( $a $b 5 ) #( $c $d 3 ) ).
	
	edmondsKarp := AIEdmondsKarp new.
	edmondsKarp nodes: nodes.
	edmondsKarp
		edges: edges
		from: [ :each | each first ]
		to: [ :each | each second ]
		capacity: [ :each | each third ].
	
	edmondsKarp source: $a sink: $d.
	maxFlow := edmondsKarp run.
	
	self assert: maxFlow equals: 0
]

{ #category : 'tests' }
AIEdmondsKarpTest >> testSingleEdge [
	"Test with a single edge from source to sink"
	
	| nodes edges edmondsKarp maxFlow |
	nodes := #( $s $t ).
	edges := #( #( $s $t 15 ) ).
	
	edmondsKarp := AIEdmondsKarp new.
	edmondsKarp nodes: nodes.
	edmondsKarp
		edges: edges
		from: [ :each | each first ]
		to: [ :each | each second ]
		capacity: [ :each | each third ].
	
	edmondsKarp source: $s sink: $t.
	maxFlow := edmondsKarp run.
	
	self assert: maxFlow equals: 15
]
