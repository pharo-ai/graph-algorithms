"
Graph Class:
1. Cyclic
2. Non-Weighted
3. 1 UnDirected, rest Directed graphs
"
Class {
	#name : #AICyclicNonWeightedGraph,
	#superclass : #Object,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AICyclicNonWeightedGraph >> aseCircuitGraph [

	"https://i.imgur.com/t1S6dG4.jpeg"

	| nodes edges graph|
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $c $f ) #( $d $b ) #( $d $e ) #( $e $a ) #( $f $g )
	            #( $g $h ) #( $h $g ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> aseSccGraph [

	| nodes edges graph|
	nodes := $a to: $e.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $d $b ) #( $d $e ) #( $e $a ) ).
	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> complexCycleGraph [

	"https://i.imgur.com/4trPCcb.jpeg"

	| nodes edges graph|
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $a $c ) #( $a $g ) #( $b $e ) #( $c $b )
	            #( $c $d ) #( $d $f ) #( $f $c ) #( $g $h ) #( $g $d )
	            #( $h $g ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> complexCycleGraph2 [
	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #($a $b) 	#($a $f)
					#($b $e) 	#($b $f)
					#($c $b) 	#($c $a) 	#($c $e) 	#($c $f) 	#($c $g) 	#($c $d)
					#($d $b)
					#($e $b) 	#($e $d) 	#($e $h)
					#($f $b) 	#($f $e) 	#($f $d)
					#($g $b) 	#($g $a) 	#($g $e) 	#($g $f) 	#($g $d) 	#($g $i) ).
	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> complexUndirectedGraph [

	"https://i.imgur.com/qK2zsYb.png"

	| nodes edges graph|
	nodes := 0 to: 12.
	edges := #( #( 0 7 ) #( 0 11 ) #( 0 8 ) #( 1 9 ) #( 1 10 ) #( 2 3 )
	            #( 2 12 ) #( 3 2 ) #( 3 4 ) #( 3 7 ) #( 4 3 ) #( 5 6 )
	            #( 6 7 ) #( 6 5 ) #( 7 3 ) #( 7 0 ) #( 7 11 ) #( 7 6 )
	            #( 8 9 ) #( 8 10 ) #( 8 0 ) #( 9 1 ) #( 9 8 ) #( 9 12 )
	            #( 10 1 ) #( 10 8 ) #( 11 7 ) #( 11 0 ) #( 12 2 )
	            #( 12 9 ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> cycleGraph [

	"https://i.imgur.com/MNtwA56.jpeg"

	| nodes edges graph|
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $c $a ) #( $d $c ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> dependencyGraph [

	| nodes edges graph|
	nodes := $a to: $k.
	edges := #( #( $a $b ) #( $a $c ) #( $c $a ) #( $c $k ) #( $d $e )
	            #( $d $g ) #( $d $i ) #( $e $c ) #( $e $f ) #( $f $j )
	            #( $g $f ) #( $g $h ) #( $g $i ) #( $h $j ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> moduleGraph [

	| nodes edges graph |
	nodes := #('v1' 'v2' 'v3' 'v4' 'v5'	'v6' 'v7' 'v8' 'v9' 'v10' 'v11').
	edges := #(
		('v1' 'v2') ('v1' 'v3') ('v1' 'v4')
		('v2' 'v4') ('v2' 'v5') ('v2' 'v6') ('v2' 'v7')
		('v3' 'v4') ('v3' 'v5') ('v3' 'v6') ('v3' 'v7')
		('v4' 'v2') ('v4' 'v3') ('v4' 'v5') ('v4' 'v6') ('v4' 'v7')
		('v5' 'v6') ('v5' 'v7')
		('v6' 'v8') ('v6' 'v9') ('v6' 'v10') ('v6' 'v11')
		('v7' 'v8') ('v7' 'v9') ('v7' 'v10') ('v7' 'v11')
		('v8' 'v9') ('v8' 'v10') ('v8' 'v11')
		('v9' 'v10') ('v9' 'v11')).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> nestedCycleGraph [

	"https://i.imgur.com/6lk0pmR.jpeg"

	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $b $c ) #( $c $d ) #( $d $e ) #( $e $a )
	            #( $b $e ) #( $e $b ) #( $e $f ) #( $f $g ) #( $g $h )
	            #( $h $f ) #( $g $i ) #( $i $g ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> simpleGraphForHits [

	"https://i.imgur.com/FvqrFbf.png"

	"Note that the socres (auth and hub) obtained by the hits algorithm will difer the scores from the image. This because the scores of the image were rounded several times in each iteartion to be obtained. But the scores must be similar"

	| nodes edges graph|
	nodes := #( 'N1' 'N2' 'N3' 'N4' ).
	edges := #( #( 'N1' 'N2' ) #( 'N1' 'N3' ) #( 'N1' 'N4' )
	            #( 'N2' 'N3' ) #( 'N2' 'N4' ) #( 'N3' 'N1' )
	            #( 'N3' 'N4' ) #( 'N4' 'N4' ) ).

	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> stronglyConnectedGraph [

	"This a graph for 4 strongly connected components "
	"https://i.imgur.com/NA87YUP.png"

	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $a $c ) #( $b $a ) #( $b $d ) #( $c $a )
	            #( $c $d ) #( $d $e ) #( $e $d ) #( $f $b ) #( $f $e )
	            #( $f $h ) #( $g $f ) #( $h $e ) #( $h $g ) #( $i $g )
	            #( $i $h ) #( $i $i ) ).
	graph:= AIGraphStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> stronglyConnectedGraph: objects [

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
	graph:= AIGraphStructure new.
	graph nodes: objects .
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AICyclicNonWeightedGraph >> stronglyConnectedGraph: graphBuilder withObjects: objects [

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
