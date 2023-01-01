"
Node used by the MalReducedGraph algorithm.
It has an additional instance variable to track merged nodes.
"
Class {
	#name : #AIReducedGraphNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'mergedNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIReducedGraphNode >> label [

	^ 'Merged nodes: '
]

{ #category : #accessing }
AIReducedGraphNode >> mergedNodes [
	^ mergedNodes
]

{ #category : #setting }
AIReducedGraphNode >> mergedNodes: aNodeList [
	mergedNodes := aNodeList
]

{ #category : #printing }
AIReducedGraphNode >> printOn: stream [

	stream nextPutAll: self label.
	model isCollection
		ifTrue: [
			model
				do: [ :node | node printOn: stream ]
				separatedBy: [ stream << ', ' ] ]
		ifFalse: [ model printOn: stream ]
]
