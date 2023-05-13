Class {
	#name : #AIAstar,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'AI-Algorithms-Graph-Shortest path'
}

{ #category : #configuration }
AIAstar >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #accessing }
AIAstar >> end [

	^ end
]

{ #category : #accessing }
AIAstar >> end: endModel [

	end := (self findNode: endModel)
]

{ #category : #running }
AIAstar >> heuristicFrom: startModel to: endModel [
  | pq cameFrom gScore fScore gs fs |
	
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	gScore at: startModel put: 0.
	fScore := Dictionary new.
	fScore at: startModel put: Float infinity .
	
	gs := [ :p | gScore at: p ifAbsent: Float infinity ].
	fs := [ :p | fScore at: p ifAbsent: Float infinity ].
	
	pq := SortedCollection sortUsing: [ :a :b | (fs value: a) < (fs value: b) ].
	pq add: startModel.
	
	[ pq isEmpty ] whileFalse: [ 
		| current  ans |
		current := pq removeFirst.
		
		"Transcript show: current;cr."
		"Transcript show: current outgoingEdges;cr."
      "Transcript show: end;cr."		
		"hook for visualization, call it with current and came from maps"
		"stepHook ifNotNil: [ stepHook value: current value: cameFrom ]."
		
		current = endModel 
			ifTrue: [
      			^ current priority.
      			 ]
			ifFalse: [ 
				current outgoingEdges do: [ :edge |
					| tentative_gScore |
					tentative_gScore := (gs value: current) + (edge weight).
					tentative_gScore < (gs value: (edge to))
						ifTrue: [ 
							"This path to neighbor is better than any previous one. Record it!"
							(edge to) priority: tentative_gScore .
		                cameFrom at: (edge to) put: current.
		                gScore at: (edge to) put: tentative_gScore.
		                fScore at: (edge to) put: tentative_gScore.
		                (pq includes: (edge to)) ifFalse: [ pq add: (edge to) ].
						] 
				].
			].
	].

   ^Float infinity .
]

{ #category : #actions }
AIAstar >> newPriorityQueue [

	"We use the Heap object defined in the SequenceableCollections package."

	^ Heap new
]

{ #category : #configuration }
AIAstar >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : #running }
AIAstar >> pathDistance [
   "Needs to be editted"
	^ self end pathDistance
]

{ #category : #backtracking }
AIAstar >> reconstructPath [

	| path previous |
	"If no path exists between the start and the end node"
	end pathDistance = Float infinity ifTrue: [ ^ #(  ) ].
	path := LinkedList empty.
	previous := end.
	path addFirst: end model.
	[ previous = start ] whileFalse: [
		previous := previous previousNode.
		path addFirst: previous model ].
	^ path
]

{ #category : #actions }
AIAstar >> removeMostPromisingPair: aPriorityQueue [

	^ aPriorityQueue removeFirst
]

{ #category : #initialization }
AIAstar >> reset [

	self nodes do: [ :node |
		node
			pathDistance: Float infinity;
			visited: false;
			previousNode: nil ]
]

{ #category : #running }
AIAstar >> run [

	| pq cameFrom gScore fScore gs fs send |
	
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	gScore at: start put: 0.
	fScore := Dictionary new.
	fScore at: start put: (self heuristicFrom: start to: end).
	"Transcript show: (self heuristicFrom: start to: end);cr."
	
	gs := [ :p | gScore at: p ifAbsent: Float infinity ].
	fs := [ :p | fScore at: p ifAbsent: Float infinity ].
	
	pq := SortedCollection sortUsing: [ :a :b | (fs value: a) < (fs value: b) ].
	pq add: start.
	
	[ pq isEmpty ] whileFalse: [ 
		| current |
		current := pq removeFirst.
		
		"Transcript show: current;cr."
		"Transcript show: current outgoingEdges;cr."
      "Transcript show: end;cr."		
		"hook for visualization, call it with current and came from maps"
		"stepHook ifNotNil: [ stepHook value: current value: cameFrom ]."
		
		current = end 
			ifTrue: [
				| path prev |
				path := OrderedCollection with: current.
			   prev := cameFrom at: current ifAbsent: nil.
			   [ prev isNotNil ] whileTrue: [ 
					path addFirst: prev.
					prev := cameFrom at: prev ifAbsent: nil.
				].
      			^ path.
      			 ]
			ifFalse: [ 
				current outgoingEdges do: [ :edge |
					| tentative_gScore |
					tentative_gScore := (gs value: current) + (edge weight).
					tentative_gScore < (gs value: (edge to))
						ifTrue: [ 
							"This path to neighbor is better than any previous one. Record it!"
							self updateDistance: tentative_gScore of: edge to previousNode: current.
		                cameFrom at: (edge to) put: current.
		                gScore at: (edge to) put: tentative_gScore.
		                fScore at: (edge to) put: tentative_gScore + (self heuristicFrom: (edge to) to: end).
		                "Transcript show: (self heuristicFrom: (edge to) to: end);cr."
		                (pq includes: (edge to)) ifFalse: [ pq add: (edge to) ].
						] 
				].
			].
	].

   send := OrderedCollection new.
   ^send
]

{ #category : #running }
AIAstar >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : #running }
AIAstar >> runFrom: startModel to: endModel [

	self start: startModel.
	self end: endModel.
	^ self run
]

{ #category : #accessing }
AIAstar >> start [

	^ start
]

{ #category : #accessing }
AIAstar >> start: startModel [

	start := (self findNode: startModel).
	start pathDistance: 0
]

{ #category : #private }
AIAstar >> updateDistance: newDistance of: aNode previousNode: previousNode [

	aNode previousNode: previousNode.
	aNode pathDistance: newDistance
]
