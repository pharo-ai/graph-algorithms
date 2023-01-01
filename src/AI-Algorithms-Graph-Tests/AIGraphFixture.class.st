"
Description
--------------------

I am a facade containing some behavior used by MooseAlgos tests.
"
Class {
	#name : #AIGraphFixture,
	#superclass : #Object,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #fixtures }
AIGraphFixture class >> aseCircuitGraph: builder [

	"https://i.imgur.com/t1S6dG4.jpeg"

	| nodes edges |
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $c $f ) #( $d $b ) #( $d $e ) #( $e $a ) #( $f $g )
	            #( $g $h ) #( $h $g ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> aseCircuitWeightedGraph: builder [

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
AIGraphFixture class >> aseSccGraph: builder [

	| nodes edges |
	nodes := $a to: $e.
	edges := #( #( $a $b ) #( $b $a ) #( $b $c ) #( $b $d ) #( $c $d )
	            #( $d $b ) #( $d $e ) #( $e $a ) ).
	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> aseWeightedCircuitGraph: builder [

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
AIGraphFixture class >> complexCycleGraph2: builder [
	| nodes edges |
	nodes := $a to: $i.
	edges := #( #($a $b) 	#($a $f)
					#($b $e) 	#($b $f)
					#($c $b) 	#($c $a) 	#($c $e) 	#($c $f) 	#($c $g) 	#($c $d)
					#($d $b)
					#($e $b) 	#($e $d) 	#($e $h)
					#($f $b) 	#($f $e) 	#($f $d)
					#($g $b) 	#($g $a) 	#($g $e) 	#($g $f) 	#($g $d) 	#($g $i) ).
	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> complexCycleGraph: builder [

	"https://i.imgur.com/4trPCcb.jpeg"

	| nodes edges |
	nodes := $a to: $h.
	edges := #( #( $a $b ) #( $a $c ) #( $a $g ) #( $b $e ) #( $c $b )
	            #( $c $d ) #( $d $f ) #( $f $c ) #( $g $h ) #( $g $d )
	            #( $h $g ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> complexUndirectedGraph: builder [

	"https://i.imgur.com/qK2zsYb.png"

	| nodes edges |
	nodes := 0 to: 12.
	edges := #( #( 0 7 ) #( 0 11 ) #( 0 8 ) #( 1 9 ) #( 1 10 ) #( 2 3 )
	            #( 2 12 ) #( 3 2 ) #( 3 4 ) #( 3 7 ) #( 4 3 ) #( 5 6 )
	            #( 6 7 ) #( 6 5 ) #( 7 3 ) #( 7 0 ) #( 7 11 ) #( 7 6 )
	            #( 8 9 ) #( 8 10 ) #( 8 0 ) #( 9 1 ) #( 9 8 ) #( 9 12 )
	            #( 10 1 ) #( 10 8 ) #( 11 7 ) #( 11 0 ) #( 12 2 )
	            #( 12 9 ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> complexWeightedGraph2: builder [

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
AIGraphFixture class >> complexWeightedGraph3: builder [

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
AIGraphFixture class >> complexWeightedGraph: builder [

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
AIGraphFixture class >> cycleGraph: builder [

	"https://i.imgur.com/MNtwA56.jpeg"

	| nodes edges |
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $c $a ) #( $d $c ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> dependencyGraph: builder [

	| nodes edges |
	nodes := $a to: $k.
	edges := #( #( $a $b ) #( $a $c ) #( $c $a ) #( $c $k ) #( $d $e )
	            #( $d $g ) #( $d $i ) #( $e $c ) #( $e $f ) #( $f $j )
	            #( $g $f ) #( $g $h ) #( $g $i ) #( $h $j ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> moduleGraph2: builder [

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
AIGraphFixture class >> moduleGraph: builder [

	| nodes edges |
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

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> negativeUnconnectedWeightedGraph: builder [

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
AIGraphFixture class >> negativeWeightedGraph2: builder [

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
AIGraphFixture class >> negativeWeightedGraph: builder [

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
AIGraphFixture class >> nestedCycleGraph: builder [

	"https://i.imgur.com/6lk0pmR.jpeg"

	| nodes edges |
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $b $c ) #( $c $d ) #( $d $e ) #( $e $a )
	            #( $b $e ) #( $e $b ) #( $e $f ) #( $f $g ) #( $g $h )
	            #( $h $f ) #( $g $i ) #( $i $g ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> simpleGraph: builder [

	"https://i.imgur.com/uJwu5xS.jpeg"

	| nodes edges |
	nodes := $a to: $d.
	edges := #( #( $a $b ) #( $b $c ) #( $d $c ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> simpleGraphForHits: builder [

	"https://i.imgur.com/FvqrFbf.png"

	"Note that the socres (auth and hub) obtained by the hits algorithm will difer the scores from the image. This because the scores of the image were rounded several times in each iteartion to be obtained. But the scores must be similar"

	| nodes edges |
	nodes := #( 'N1' 'N2' 'N3' 'N4' ).
	edges := #( #( 'N1' 'N2' ) #( 'N1' 'N3' ) #( 'N1' 'N4' )
	            #( 'N2' 'N3' ) #( 'N2' 'N4' ) #( 'N3' 'N1' )
	            #( 'N3' 'N4' ) #( 'N4' 'N4' ) ).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
AIGraphFixture class >> simpleWeightedGraph: builder [

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

{ #category : #fixtures }
AIGraphFixture class >> stronglyConnectedGraph: graphBuilder [

	"This a graph for 4 strongly connected components "
	"https://i.imgur.com/NA87YUP.png"

	| nodes edges |
	nodes := $a to: $i.
	edges := #( #( $a $b ) #( $a $c ) #( $b $a ) #( $b $d ) #( $c $a )
	            #( $c $d ) #( $d $e ) #( $e $d ) #( $f $b ) #( $f $e )
	            #( $f $h ) #( $g $f ) #( $h $e ) #( $h $g ) #( $i $g )
	            #( $i $h ) #( $i $i ) ).
	graphBuilder nodes: nodes.
	graphBuilder edges: edges from: #first to: #second.
	^ graphBuilder
]

{ #category : #fixtures }
AIGraphFixture class >> stronglyConnectedGraph: graphBuilder withObjects: objects [

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

{ #category : #fixtures }
AIGraphFixture class >> weightedDAG: builder [

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
AIGraphFixture class >> withoutCyclesComplexGraph: builder [

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
AIGraphFixture class >> withoutCyclesComplexWeightedGraph: builder [

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

{ #category : #fixtures }
AIGraphFixture class >> withoutCyclesMediumGraph: builder [

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
