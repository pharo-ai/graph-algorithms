"
Graph Class:
1. Cyclic
2. 3 negative Weighted, rest positive
3. Directed graphs
4. Simple Graphs
"
Class {
	#name : 'AICyclicWeightedSimpleFixture',
	#superclass : 'Object',
	#instVars : [
		'aseCircuitWeightedGraph',
		'aseWeightedCircuitGraph',
		'negativeUnconnectedWeightedGraph',
		'negativeWeightedGraph',
		'negativeWeightedGraph2',
		'simpleWeightedGraph',
		'simpleWeightedGraph2'
	],
	#category : 'AI-Algorithms-Graph-Tests-Fixture',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Fixture'
}

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> aseCircuitWeightedGraph [

	"This is the same graph, but with weights of 1 to all edges"
	"https://i.imgur.com/t1S6dG4.jpeg"

	| nodes edges graph |
	nodes := $a to: $h.
	edges := #( #( $a $b 1 ) #( $b $a 1 ) #( $b $c 1 ) #( $b $d 1 ) #( $c $d 1 )
	            #( $c $f 1 ) #( $d $b 1 ) #( $d $e 1 ) #( $e $a 1 ) #( $f $g 1 )
	            #( $g $h 1 ) #( $h $g 1 ) ).

	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> aseWeightedCircuitGraph [

	| nodes edges graph |
	nodes := $a to: $h.
	edges := #( #( $a $b 1 ) #( $b $a 1 ) #( $b $c 1 ) #( $b $d 1 )
	            #( $c $d 1 ) #( $c $f 1 ) #( $d $b 1 ) #( $d $e 1 )
	            #( $e $a 1 ) #( $f $g 1 ) #( $g $h 1 ) #( $h $g 1 ) ).

	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'initialization' }
AICyclicWeightedSimpleFixture >> initialize [ 
  super initialize .
  aseCircuitWeightedGraph := self aseCircuitWeightedGraph . 
  aseWeightedCircuitGraph := self aseWeightedCircuitGraph .
  negativeUnconnectedWeightedGraph := self negativeUnconnectedWeightedGraph .
  negativeWeightedGraph := self negativeWeightedGraph .
  negativeWeightedGraph2 := self negativeWeightedGraph2 .
  simpleWeightedGraph := self simpleWeightedGraph .
  simpleWeightedGraph2 := self simpleWeightedGraph2 .
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> negativeUnconnectedWeightedGraph [

	"https://i.imgur.com/EKPxvx7.png"

	| nodes edges graph |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 6 7 -50 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> negativeWeightedGraph [

	"https://i.imgur.com/GsnrKtx.png"

	| nodes edges graph |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 5 8 50 ) #( 6 7 -50 )
	            #( 7 8 -10 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> negativeWeightedGraph2 [

	"https://i.imgur.com/R3EV1pl.png"

	| nodes edges graph |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 6 7 -50 ) #( 8 7 -18 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> simpleWeightedGraph [

	"https://i.imgur.com/AQTX2hz.jpeg"

	| nodes edges graph |
	nodes := 1 to: 5.
	edges := #( #( 1 2 5 ) #( 1 3 4 ) #( 2 3 2 ) #( 3 4 5 ) #( 2 4 3 )
	            #( 4 5 1 ) #( 5 1 2 ) #( 1 5 3 ) ).

	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicWeightedSimpleFixture >> simpleWeightedGraph2 [
	"https://imgur.com/6Mjdngn"

	| nodes edges graph |
	nodes := 1 to: 5.
	edges := #( #( 1 2 3 ) #( 1 4 7 ) #( 1 5 8 ) #( 2 1 3 ) #( 2 3 1 )
	            #( 2 4 4 ) #( 3 2 1 ) #( 3 4 2 ) #( 4 1 7 ) #( 4 2 4 )
	            #( 4 3 2 ) #( 4 5 3 ) #( 5 1 8 ) #( 5 4 3 ) ).

	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]
