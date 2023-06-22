"
Graph Class:
1. Cyclic
2. 3 negative Weighted, rest positive
3. Directed graphs
4. Complex Graphs
"
Class {
	#name : #AICyclicWeightedComplexFixture,
	#superclass : #Object,
	#instVars : [
		'complexWeightedGraph',
		'complexWeightedGraph2',
		'complexWeightedGraph3',
		'complexWeightedGraph4'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AICyclicWeightedComplexFixture >> complexWeightedGraph [

	"https://i.imgur.com/LAy4W3Z.jpeg"

	| nodes edges graph |
	nodes := $a to: $s.
	edges := #( #( $a $b 30 ) #( $b $s 1 ) #( $b $p 4 ) #( $b $c 30 )
	            #( $d $e 30 ) #( $d $f 20 ) #( $d $j 10 ) #( $e $a 15 )
	            #( $f $m 8 ) #( $g $h 20 ) #( $g $r 3 ) #( $i $a 14 )
	            #( $i $k 4 ) #( $i $d 3 ) #( $j $q 5 ) #( $k $l 10 )
	            #( $k $g 5 ) #( $m $n 7 ) #( $m $o 6 ) #( $n $c 5 )
	            #( $p $b 5 ) #( $q $i 4 ) ).

	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicWeightedComplexFixture >> complexWeightedGraph2 [

	"https://i.imgur.com/Syyd7YI.png"

	| nodes edges graph |
	nodes := 0 to: 5.
	edges := #( #( 0 1 5 ) #( 0 2 1 ) #( 1 2 2 ) #( 1 4 20 ) #( 1 3 3 )
	            #( 2 1 3 ) #( 2 4 12 ) #( 3 2 3 ) #( 3 4 2 ) #( 3 5 6 )
	            #( 4 5 1 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicWeightedComplexFixture >> complexWeightedGraph3 [

	"https://i.imgur.com/0kgPUQM.png"

	| nodes edges graph |
	nodes := $a to: $e.
	edges := #( #( $a $b 6 ) #( $a $d 1 ) #( $b $a 6 ) #( $b $c 5 )
	            #( $b $d 2 ) #( $b $e 2 ) #( $c $b 5 ) #( $c $e 5 )
	            #( $d $a 1 ) #( $d $b 2 ) #( $d $e 1 ) #( $e $b 2 )
	            #( $e $c 5 ) #( $e $d 1 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicWeightedComplexFixture >> complexWeightedGraph4 [
	"https://imgur.com/Szd19hW"

	| nodes edges graph |
	nodes := 1 to: 12.
	edges := #( #( 1 2 1 ) #( 1 4 25 ) #( 2 1 1 ) #( 2 3 26 ) #( 3 2 26 )
	            #( 3 4 17 ) #( 3 5 6 ) #( 3 6 20 ) #( 4 1 25 )
	            #( 4 3 17 ) #( 4 6 15 ) #( 4 7 8 ) #( 5 3 6 ) #( 5 6 18 )
	            #( 5 9 16 ) #( 5 12 23 ) #( 6 3 20 ) #( 6 4 15 )
	            #( 6 5 18 ) #( 6 7 6 ) #( 6 8 16 ) #( 6 9 16 )
	            #( 7 4 8 ) #( 7 6 6 ) #( 7 8 20 ) #( 8 6 16 ) #( 8 7 20 )
	            #( 8 9 7 ) #( 8 10 9 ) #( 9 5 16 ) #( 9 6 16 )
	            #( 9 8 7 ) #( 9 11 24 ) #( 9 12 9 ) #( 10 8 9 )
	            #( 10 11 9 ) #( 11 9 24 ) #( 11 10 9 ) #( 11 12 16 )
	            #( 12 5 23 ) #( 12 9 9 ) #( 12 11 16 ) ).
	graph:= AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #initialization }
AICyclicWeightedComplexFixture >> initialize [ 
  super initialize .
  complexWeightedGraph := self complexWeightedGraph . 
  complexWeightedGraph2 := self complexWeightedGraph2 .
  complexWeightedGraph3 := self complexWeightedGraph3 .
  complexWeightedGraph4 := self complexWeightedGraph4 .
]
