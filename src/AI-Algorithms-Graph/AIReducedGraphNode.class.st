"
Node used by the MalReducedGraph algorithm.
It has an additional instance variable to track merged nodes.
"
Class {
	#name : #AIReducedGraphNode,
	#superclass : #MalNodeWithPreviousAndNext,
	#instVars : [
		'mergedNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
AIReducedGraphNode >> label [
	^ ''
]

{ #category : #accessing }
AIReducedGraphNode >> mergedNodes [
	^ mergedNodes
]

{ #category : #setting }
AIReducedGraphNode >> mergedNodes: aNodeList [
	mergedNodes := aNodeList
]
