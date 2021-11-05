"
Default representation of a graph vertex (node).
"
Class {
	#name : #AIGraphNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'adjacentNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #'instance creation' }
AIGraphNode class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
AIGraphNode >> adjacentNodes [

	^ adjacentNodes
]

{ #category : #accessing }
AIGraphNode >> adjacentNodes: aNodeList [

	adjacentNodes := aNodeList
]

{ #category : #accessing }
AIGraphNode >> from: sourceNode [
]

{ #category : #accessing }
AIGraphNode >> from: sourceNode edge: anEdge [
]

{ #category : #initialization }
AIGraphNode >> initialize [

	super initialize.
	adjacentNodes := OrderedCollection new
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

	adjacentNodes add: targetNode
]

{ #category : #accessing }
AIGraphNode >> to: targetNode edge: anEdge [
]
