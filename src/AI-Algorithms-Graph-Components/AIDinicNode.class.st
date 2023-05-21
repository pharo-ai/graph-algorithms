Class {
	#name : #AIDinicNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'level',
		'currentIndex'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIDinicNode >> currentIndex [

	^ currentIndex
]

{ #category : #setter }
AIDinicNode >> currentIndex: aValue [

	currentIndex := aValue
]

{ #category : #initialization }
AIDinicNode >> initialize [

	super initialize.
	level := -1.
	currentIndex := 1.
]

{ #category : #accessing }
AIDinicNode >> label [

	^ 'Dinic: '
]

{ #category : #accessing }
AIDinicNode >> level [

	^ level
]

{ #category : #setter }
AIDinicNode >> level: aValue [

	level := aValue
]
