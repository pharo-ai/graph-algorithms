"
Graph Class:
1. Cyclic
2. 3 negative Weighted, rest positive
3. Directed graphs
"
Class {
	#name : #AICyclicWeightedGraph,
	#superclass : #Object,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AICyclicWeightedGraph >> aseCircuitWeightedGraph: builder [

	"This is the same graph, but with weights of 1 to all edges"
	"https://i.imgur.com/t1S6dG4.jpeg"

	| nodes edges |
	nodes := $a to: $h.
	edges := #( #( $a $b 1 ) #( $b $a 1 ) #( $b $c 1 ) #( $b $d 1 ) #( $c $d 1 )
	            #( $c $f 1 ) #( $d $b 1 ) #( $d $e 1 ) #( $e $a 1 ) #( $f $g 1 )
	            #( $g $h 1 ) #( $h $g 1 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> aseWeightedCircuitGraph: builder [

	| nodes edges |
	nodes := $a to: $h.
	edges := #( #( $a $b 1 ) #( $b $a 1 ) #( $b $c 1 ) #( $b $d 1 )
	            #( $c $d 1 ) #( $c $f 1 ) #( $d $b 1 ) #( $d $e 1 )
	            #( $e $a 1 ) #( $f $g 1 ) #( $g $h 1 ) #( $h $g 1 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> complexWeightedGraph2: builder [

	"https://i.imgur.com/Syyd7YI.png"

	| nodes edges |
	nodes := 0 to: 5.
	edges := #( #( 0 1 5 ) #( 0 2 1 ) #( 1 2 2 ) #( 1 4 20 ) #( 1 3 3 )
	            #( 2 1 3 ) #( 2 4 12 ) #( 3 2 3 ) #( 3 4 2 ) #( 3 5 6 )
	            #( 4 5 1 ) ).
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> complexWeightedGraph3: builder [

	"https://i.imgur.com/0kgPUQM.png"

	| nodes edges |
	nodes := $a to: $e.
	edges := #( #( $a $b 6 ) #( $a $d 1 ) #( $b $a 6 ) #( $b $c 5 )
	            #( $b $d 2 ) #( $b $e 2 ) #( $c $b 5 ) #( $c $e 5 )
	            #( $d $a 1 ) #( $d $b 2 ) #( $d $e 1 ) #( $e $b 2 )
	            #( $e $c 5 ) #( $e $d 1 ) ).
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> complexWeightedGraph4: builder [
	"https://imgur.com/Szd19hW"

	| nodes edges |
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
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> complexWeightedGraph: builder [

	"https://i.imgur.com/LAy4W3Z.jpeg"

	| nodes edges |
	nodes := $a to: $s.
	edges := #( #( $a $b 30 ) #( $b $s 1 ) #( $b $p 4 ) #( $b $c 30 )
	            #( $d $e 30 ) #( $d $f 20 ) #( $d $j 10 ) #( $e $a 15 )
	            #( $f $m 8 ) #( $g $h 20 ) #( $g $r 3 ) #( $i $a 14 )
	            #( $i $k 4 ) #( $i $d 3 ) #( $j $q 5 ) #( $k $l 10 )
	            #( $k $g 5 ) #( $m $n 7 ) #( $m $o 6 ) #( $n $c 5 )
	            #( $p $b 5 ) #( $q $i 4 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> negativeUnconnectedWeightedGraph: builder [

	"https://i.imgur.com/EKPxvx7.png"

	| nodes edges |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 6 7 -50 ) ).
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> negativeWeightedGraph2: builder [

	"https://i.imgur.com/R3EV1pl.png"

	| nodes edges |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 6 7 -50 ) #( 8 7 -18 ) ).
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> negativeWeightedGraph: builder [

	"https://i.imgur.com/GsnrKtx.png"

	| nodes edges |
	nodes := 0 to: 9.
	edges := #( #( 0 1 5 ) #( 1 2 20 ) #( 1 6 60 ) #( 1 5 30 )
	            #( 2 3 10 ) #( 2 4 75 ) #( 3 2 -15 ) #( 4 9 100 )
	            #( 5 4 25 ) #( 5 6 5 ) #( 5 8 50 ) #( 6 7 -50 )
	            #( 7 8 -10 ) ).
	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> simpleWeightedGraph2: builder [
	"https://imgur.com/6Mjdngn"

	| nodes edges |
	nodes := 1 to: 5.
	edges := #( #( 1 2 3 ) #( 1 4 7 ) #( 1 5 8 ) #( 2 1 3 ) #( 2 3 1 )
	            #( 2 4 4 ) #( 3 2 1 ) #( 3 4 2 ) #( 4 1 7 ) #( 4 2 4 )
	            #( 4 3 2 ) #( 4 5 3 ) #( 5 1 8 ) #( 5 4 3 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]

{ #category : #fixtures }
AICyclicWeightedGraph >> simpleWeightedGraph: builder [

	"https://i.imgur.com/AQTX2hz.jpeg"

	| nodes edges |
	nodes := 1 to: 5.
	edges := #( #( 1 2 5 ) #( 1 3 4 ) #( 2 3 2 ) #( 3 4 5 ) #( 2 4 3 )
	            #( 4 5 1 ) #( 5 1 2 ) #( 1 5 3 ) ).

	builder nodes: nodes.
	builder
		edges: edges
		from: #first
		to: #second
		weight: #third.
	^ builder
]
