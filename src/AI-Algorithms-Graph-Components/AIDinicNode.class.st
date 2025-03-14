"
This class represents a node in the Dinic's algorithm.
Each node has a level and a currentIndex property.
"
Class {
	#name : 'AIDinicNode',
	#superclass : 'AIGraphNode',
	#instVars : [
		'level',
		'currentIndex'
	],
	#category : 'AI-Algorithms-Graph-Components-Nodes',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
AIDinicNode >> currentIndex [

	^ currentIndex
]

{ #category : 'setter' }
AIDinicNode >> currentIndex: aValue [

	currentIndex := aValue
]

{ #category : 'initialization' }
AIDinicNode >> initialize [

	super initialize.
	level := -1.
	currentIndex := 1.
]

{ #category : 'accessing' }
AIDinicNode >> label [

	^ 'Dinic: '
]

{ #category : 'accessing' }
AIDinicNode >> level [

	^ level
]

{ #category : 'setter' }
AIDinicNode >> level: aValue [

	level := aValue
]
