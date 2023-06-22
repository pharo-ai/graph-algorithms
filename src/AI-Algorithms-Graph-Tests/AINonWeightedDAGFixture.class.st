"
Graph Class:
1. Acyclic
2. Non-Weighted
3. Directed graphs
"
Class {
	#name : #AINonWeightedDAGFixture,
	#superclass : #Object,
	#instVars : [
		'moduleGraph2',
		'simpleGraph',
		'withoutCyclesComplexGraph',
		'withoutCyclesMediumGraph'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #initialization }
AINonWeightedDAGFixture >> initialize [ 
  super initialize .
  moduleGraph2 := self moduleGraph2 . 
  simpleGraph := self simpleGraph .
  withoutCyclesComplexGraph := self withoutCyclesComplexGraph .
  withoutCyclesMediumGraph := self withoutCyclesMediumGraph .
]

{ #category : #fixtures }
AINonWeightedDAGFixture >> moduleGraph2 [

	"sample graph from Habib et al for modular decomposition"

	| nodes edges graph|
	nodes := #( $u $w $v $z $a $b $c $d ).
	edges := #( #( $u $w ) #( $w $a ) #( $w $b ) #( $w $c ) #( $w $d )
	            #( $w $v ) #( $v $b ) #( $v $d ) #( $v $z ) #( $z $b )
	            #( $a $d ) #( $c $v ) #( $c $z ) #( $d $b ) #( $d $z ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AINonWeightedDAGFixture >> simpleGraph [

	"https://i.imgur.com/uJwu5xS.jpeg"

	| nodes edges graph|
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $d $c ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AINonWeightedDAGFixture >> withoutCyclesComplexGraph [

	"for longest path algo"
	"This is a disconnected graph"
	"https://i.imgur.com/yTLwTVA.jpeg"

	| nodes edges graph|
	nodes := #( $a $b $c $d $e $f $g $h $i $j $k $l $m $n $o $p $q $r $s ).
	edges := #( #( $a $e ) #( $a $g ) #( $b $c ) #( $b $h ) #( $c $o )
	            #( $c $q ) #( $d $f ) #( $d $i ) #( $f $i ) #( $g $f )
	            #( $h $d ) #( $i $r ) #( $j $k ) #( $j $l ) #( $l $m )
	            #( $l $n ) #( $o $p ) #( $q $p ) #( $p $s ) #( $r $s ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]

{ #category : #fixtures }
AINonWeightedDAGFixture >> withoutCyclesMediumGraph [

	"for longest path algo"
	"https://i.imgur.com/Vx3QwZF.jpeg"

	| nodes edges graph|
	nodes := #( $a $b $c $d $e $f $g $h ).
	edges := #( #( $a $e ) #( $a $g ) #( $b $c ) #( $b $h ) #( $d $f )
	            #( $g $f ) #( $h $d ) ).

	graph:= AIGraphNonWeightedStructureFixture new.
	graph nodes: nodes.
	graph edges: edges.
	^graph
]
