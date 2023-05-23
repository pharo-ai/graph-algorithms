"
Graph Class:
1. Acyclic
2. Non-Weighted
3. Directed graphs
"
Class {
	#name : #AINonWeightedDAG,
	#superclass : #Object,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AINonWeightedDAG >> moduleGraph2: builder [

	"sample graph from Habib et al for modular decomposition"

	| nodes edges |
	nodes := #( $u $w $v $z $a $b $c $d ).
	edges := #( #( $u $w ) #( $w $a ) #( $w $b ) #( $w $c ) #( $w $d )
	            #( $w $v ) #( $v $b ) #( $v $d ) #( $v $z ) #( $z $b )
	            #( $a $d ) #( $c $v ) #( $c $z ) #( $d $b ) #( $d $z ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AINonWeightedDAG >> simpleGraph: builder [

	"https://i.imgur.com/uJwu5xS.jpeg"

	| nodes edges |
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $d $c ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AINonWeightedDAG >> withoutCyclesComplexGraph: builder [

	"for longest path algo"
	"This is a disconnected graph"
	"https://i.imgur.com/yTLwTVA.jpeg"

	| nodes edges |
	nodes := #( $a $b $c $d $e $f $g $h $i $j $k $l $m $n $o $p $q $r $s ).
	edges := #( #( $a $e ) #( $a $g ) #( $b $c ) #( $b $h ) #( $c $o )
	            #( $c $q ) #( $d $f ) #( $d $i ) #( $f $i ) #( $g $f )
	            #( $h $d ) #( $i $r ) #( $j $k ) #( $j $l ) #( $l $m )
	            #( $l $n ) #( $o $p ) #( $q $p ) #( $p $s ) #( $r $s ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AINonWeightedDAG >> withoutCyclesMediumGraph: builder [

	"for longest path algo"
	"https://i.imgur.com/Vx3QwZF.jpeg"

	| nodes edges |
	nodes := #( $a $b $c $d $e $f $g $h ).
	edges := #( #( $a $e ) #( $a $g ) #( $b $c ) #( $b $h ) #( $d $f )
	            #( $g $f ) #( $h $d ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]
