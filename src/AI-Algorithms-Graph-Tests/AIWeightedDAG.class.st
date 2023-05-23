"
Graph Class:
1. ACyclic
2. Positive Weighted
3. Directed graphs
"
Class {
	#name : #AIWeightedDAG,
	#superclass : #Object,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AIWeightedDAG >> weightedDAG: builder [

	"https://i.imgur.com/D5zMoQI.png"

	| nodes edges |
	nodes := $A to: $G.
	edges := #( #( $A $B 1 ) #( $B $C 5 ) #( $B $E 11 ) #( $B $D 8 )
	            #( $D $E 6 ) #( $E $F 7 ) #( $G $D 4 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AIWeightedDAG >> withoutCyclesComplexWeightedGraph: builder [

	"This is a disconnected graph"

	"https://i.imgur.com/TCBs0if.jpeg"

	| nodes edges |
	nodes := #( $a $b $c $d $e $f $g $h $i $j $k $l $m $n $o $p $q $r $s ).
	edges := #( #( $a $e 6 ) #( $a $g 7 ) #( $b $c 4 ) #( $b $h 10 )
	            #( $c $o 3 ) #( $c $q 2 ) #( $d $f 30 ) #( $d $i 15 )
	            #( $f $i 7 ) #( $g $f 8 ) #( $h $d 2 ) #( $i $r 14 )
	            #( $j $k 7 ) #( $j $l 6 ) #( $l $m 5 ) #( $l $n 3 )
	            #( $o $p 10 ) #( $q $p 1 ) #( $p $s 3 ) #( $r $s 7 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]
