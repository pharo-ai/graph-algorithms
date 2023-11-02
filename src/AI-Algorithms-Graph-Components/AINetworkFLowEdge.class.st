"
This class represents an edge in the Dinic's Algorithm.
Each edge has a capacity and a flow property.
"
Class {
	#name : #AINetworkFlowEdge,
	#superclass : #AIGraphEdge,
	#instVars : [
		'capacity',
		'flow'
	],
	#category : #'AI-Algorithms-Graph-Components'
}

{ #category : #accessing }
AINetworkFlowEdge >> asTuple [ 
	^{from model. to model. capacity. flow}
]

{ #category : #accessing }
AINetworkFlowEdge >> capacity [
	^capacity
]

{ #category : #accessing }
AINetworkFlowEdge >> capacity: aValue [
	capacity := aValue
]

{ #category : #accessing }
AINetworkFlowEdge >> flow [ 
	^flow

]

{ #category : #accessing }
AINetworkFlowEdge >> flow: anObject [
	flow:=anObject 
]

{ #category : #initialization }
AINetworkFlowEdge >> initialize [ 
	flow:=0
]
