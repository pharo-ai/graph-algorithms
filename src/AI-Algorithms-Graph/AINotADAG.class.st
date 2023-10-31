"
I am raised when an algorithm should have run on a DAG but the collection was not a DAG.
"
Class {
	#name : 'AINotADAG',
	#superclass : 'Error',
	#category : 'AI-Algorithms-Graph-Topological Sorting',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Topological Sorting'
}

{ #category : 'accessing' }
AINotADAG >> messageText [

	^ messageText ifNil: [ messageText := 'Not a DAG (Directed Acyclic Graph)' ]
]
