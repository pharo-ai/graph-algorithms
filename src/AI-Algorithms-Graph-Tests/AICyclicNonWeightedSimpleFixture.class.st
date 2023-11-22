"
Graph Class:
1. Cyclic
2. Non-Weighted
3. 1 UnDirected, rest Directed graphs
4. Simple Graphs
"
Class {
	#name : 'AICyclicNonWeightedSimpleFixture',
	#superclass : 'Object',
	#instVars : [
		'aseCircuitGraph',
		'aseSccGraph',
		'cycleGraph',
		'dependencyGraph',
		'moduleGraph',
		'nestedCycleGraph',
		'simpleGraphForHits'
	],
	#category : 'AI-Algorithms-Graph-Tests-Fixture',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Fixture'
}

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> aseCircuitGraph [

	"https://i.imgur.com/t1S6dG4.jpeg"

	| nodes edges graph|
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $c $f ) #( $d $b ) #( $d $e ) #( $e $a ) #( $f $g )
	            #( $g $h ) #( $h $g ) ).

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> aseSccGraph [

	| nodes edges graph|
	nodes := $a to: $e.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $d $b ) #( $d $e ) #( $e $a ) ).
	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> cycleGraph [

	"https://i.imgur.com/MNtwA56.jpeg"

	| nodes edges graph|
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $c $a ) #( $d $c ) ).

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> dependencyGraph [

	| nodes edges graph|
	nodes := $a to: $k.
	edges := #( #( $a $b ) #( $a $c ) #( $c $a ) #( $c $k ) #( $d $e )
	            #( $d $g ) #( $d $i ) #( $e $c ) #( $e $f ) #( $f $j )
	            #( $g $f ) #( $g $h ) #( $g $i ) #( $h $j ) ).

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'initialization' }
AICyclicNonWeightedSimpleFixture >> initialize [ 
  super initialize .
  aseCircuitGraph := self aseCircuitGraph . 
  aseSccGraph := self aseSccGraph .
  cycleGraph := self cycleGraph .
  dependencyGraph := self dependencyGraph .
  moduleGraph := self moduleGraph .
  nestedCycleGraph := self nestedCycleGraph .
  simpleGraphForHits := self simpleGraphForHits .
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> moduleGraph [

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

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> nestedCycleGraph [

	"https://i.imgur.com/6lk0pmR.jpeg"

	| nodes edges graph|
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $b $c ) #( $c $d ) #( $d $e ) #( $e $a )
	            #( $b $e ) #( $e $b ) #( $e $f ) #( $f $g ) #( $g $h )
	            #( $h $f ) #( $g $i ) #( $i $g ) ).

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : 'fixtures' }
AICyclicNonWeightedSimpleFixture >> simpleGraphForHits [

	"https://i.imgur.com/FvqrFbf.png"

	"Note that the socres (auth and hub) obtained by the hits algorithm will difer the scores from the image. This because the scores of the image were rounded several times in each iteartion to be obtained. But the scores must be similar"

	| nodes edges graph|
	nodes := #( 'N1' 'N2' 'N3' 'N4' ).
	edges := #( #( 'N1' 'N2' ) #( 'N1' 'N3' ) #( 'N1' 'N4' )
	            #( 'N2' 'N3' ) #( 'N2' 'N4' ) #( 'N3' 'N1' )
	            #( 'N3' 'N4' ) #( 'N4' 'N4' ) ).

	graph:= AIGraphNonWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]
