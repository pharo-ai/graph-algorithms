"
Graph Class:
1. Cyclic
2. Non-Weighted
3. 1 UnDirected, rest Directed graphs
4. Complex Graphs
"
Class {
	#name : #AICyclicNonWeightedComplexGraph,
	#superclass : #Object,
	#instVars : [
		'complexCycleGraph',
		'complexCycleGraph2',
		'complexUndirectedGraph',
		'stronglyConnectedGraph',
		'stronglyConnectedGraphWithObjects'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> complexCycleGraph [

	"https://i.imgur.com/4trPCcb.jpeg"

	| nodes edges graph|
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $a $c ) #( $a $g ) #( $b $e ) #( $c $b )
	            #( $c $d ) #( $d $f ) #( $f $c ) #( $g $h ) #( $g $d )
	            #( $h $g ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> complexCycleGraph2 [
	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #($a $b) 	#($a $f)
					#($b $e) 	#($b $f)
					#($c $b) 	#($c $a) 	#($c $e) 	#($c $f) 	#($c $g) 	#($c $d)
					#($d $b)
					#($e $b) 	#($e $d) 	#($e $h)
					#($f $b) 	#($f $e) 	#($f $d)
					#($g $b) 	#($g $a) 	#($g $e) 	#($g $f) 	#($g $d) 	#($g $i) ).
	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> complexUndirectedGraph [

	"https://i.imgur.com/qK2zsYb.png"

	| nodes edges graph|
	nodes := 0 to: 12.
	edges := #( #( 0 7 ) #( 0 11 ) #( 0 8 ) #( 1 9 ) #( 1 10 ) #( 2 3 )
	            #( 2 12 ) #( 3 2 ) #( 3 4 ) #( 3 7 ) #( 4 3 ) #( 5 6 )
	            #( 6 7 ) #( 6 5 ) #( 7 3 ) #( 7 0 ) #( 7 11 ) #( 7 6 )
	            #( 8 9 ) #( 8 10 ) #( 8 0 ) #( 9 1 ) #( 9 8 ) #( 9 12 )
	            #( 10 1 ) #( 10 8 ) #( 11 7 ) #( 11 0 ) #( 12 2 )
	            #( 12 9 ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #initialization }
AICyclicNonWeightedComplexGraph >> initialize [ 
  |persons|
  super initialize .
  complexCycleGraph := self complexCycleGraph . 
  complexCycleGraph2 := self complexCycleGraph2 .
  complexUndirectedGraph := self complexUndirectedGraph .
  stronglyConnectedGraph := self stronglyConnectedGraph .
  persons := DummyTestingPerson generateNinePersonArray.
  stronglyConnectedGraphWithObjects := self stronglyConnectedGraph: persons.
]

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> stronglyConnectedGraph [

	"This a graph for 4 strongly connected components "
	"https://i.imgur.com/NA87YUP.png"

	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $a $c ) #( $b $a ) #( $b $d ) #( $c $a )
	            #( $c $d ) #( $d $e ) #( $e $d ) #( $f $b ) #( $f $e )
	            #( $f $h ) #( $g $f ) #( $h $e ) #( $h $g ) #( $i $g )
	            #( $i $h ) #( $i $i ) ).
	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> stronglyConnectedGraph: objects [

	"This is the exact same graph as #stronglyConnectedGraph: but using a custom object"
	| edges graph|
	edges := { { objects at: 1. objects at: 2 }. { objects at: 1. objects at: 3 }.
	           { objects at: 2. objects at: 1 }. { objects at: 2. objects at: 4 }.
	           { objects at: 3. objects at: 1 }. { objects at: 3. objects at: 4 }.
              { objects at: 4. objects at: 5 }. { objects at: 5. objects at: 4 }.
              { objects at: 6. objects at: 2 }. { objects at: 6. objects at: 5 }.
              { objects at: 6. objects at: 8 }. { objects at: 7. objects at: 6 }.
		        { objects at: 8. objects at: 5 }. { objects at: 8. objects at: 7 }.
		        { objects at: 9. objects at: 7 }. { objects at: 9. objects at: 8 }.
		        { objects at: 9. objects at: 9 } }.
	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: objects .
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedComplexGraph >> stronglyConnectedGraph: graphBuilder withObjects: objects [

	"This is the exact same graph as #stronglyConnectedGraph: but using a custom object"
	| edges |
	edges := { { objects at: 1. objects at: 2 }. { objects at: 1. objects at: 3 }.
	           { objects at: 2. objects at: 1 }. { objects at: 2. objects at: 4 }.
	           { objects at: 3. objects at: 1 }. { objects at: 3. objects at: 4 }.
              { objects at: 4. objects at: 5 }. { objects at: 5. objects at: 4 }.
              { objects at: 6. objects at: 2 }. { objects at: 6. objects at: 5 }.
              { objects at: 6. objects at: 8 }. { objects at: 7. objects at: 6 }.
		        { objects at: 8. objects at: 5 }. { objects at: 8. objects at: 7 }.
		        { objects at: 9. objects at: 7 }. { objects at: 9. objects at: 8 }.
		        { objects at: 9. objects at: 9 } }.
	graphBuilder nodes: objects.
	graphBuilder edges: edges from: #first to: #second.
	^ graphBuilder
]
