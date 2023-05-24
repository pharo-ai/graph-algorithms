"
This class represents an edge in the Dinic's Algorithm.
Each edge has a capacity and a flow property.
"
Class {
	#name : #AINetworkFLowEdge,
	#superclass : #AIGraphEdge,
	#instVars : [
		'capacity',
		'flow'
	],
	#category : #'AI-Algorithms-Graph-Components'
}

{ #category : #accessing }
AINetworkFLowEdge >> asTuple [ 
	^{from model. to model. capacity. flow}
]

{ #category : #accessing }
AINetworkFLowEdge >> capacity [
	^capacity
]

{ #category : #accessing }
AINetworkFLowEdge >> capacity: aValue [
	capacity := aValue
]

{ #category : #accessing }
AINetworkFLowEdge >> flow [ 
	^flow

]

{ #category : #accessing }
AINetworkFLowEdge >> flow: anObject [
	flow:=anObject 
]

{ #category : #initialization }
AINetworkFLowEdge >> initialize [ 
	flow:=0
]
