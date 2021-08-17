"
Default representation of a graph vertex (node).
"
Class {
	#name : #AIGraphNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #'instance creation' }
AIGraphNode class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
AIGraphNode >> from: sourceNode [
]

{ #category : #accessing }
AIGraphNode >> from: sourceNode edge: anEdge [
]

{ #category : #accessing }
AIGraphNode >> label [

	^ 'Node: '
]

{ #category : #accessing }
AIGraphNode >> model [

	^ model
]

{ #category : #accessing }
AIGraphNode >> model: aModel [

	model := aModel
]

{ #category : #printing }
AIGraphNode >> printOn: stream [

	stream nextPutAll: self label.
	model printOn: stream
]

{ #category : #accessing }
AIGraphNode >> to: targetNode [

	
]

{ #category : #accessing }
AIGraphNode >> to: targetNode edge: anEdge [
]
