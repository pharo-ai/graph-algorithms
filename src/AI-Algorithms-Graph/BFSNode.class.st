Class {
	#name : #BFSNode,
	#superclass : #AIGraphNode,
	#traits : 'MalTEdgeNode - {#previousEdges. #from:edge:}',
	#classTraits : 'MalTEdgeNode classTrait',
	#instVars : [
		'nextEdges',
		'firstDepth'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
BFSNode >> firstDepth [
	^ firstDepth
]

{ #category : #accessing }
BFSNode >> firstDepth: anObject [
	firstDepth := anObject
]

{ #category : #initialization }
BFSNode >> initialize [ 

	nextEdges := OrderedCollection new.

]

{ #category : #accessing }
BFSNode >> nextEdges [

	^ nextEdges 
]

{ #category : #setting }
BFSNode >> notVisited [

	firstDepth := nil
]

{ #category : #testing }
BFSNode >> visited [

	^ firstDepth notNil
]
