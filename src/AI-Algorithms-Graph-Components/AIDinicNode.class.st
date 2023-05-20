Class {
	#name : #AIDinicNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'level'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #initialization }
AIDinicNode >> initialize [

	super initialize.
	level := -1
]

{ #category : #accessing }
AIDinicNode >> label [

	^ 'Dinic: '
]

{ #category : #accessing }
AIDinicNode >> level [

	^ level
]

{ #category : #accessing }
AIDinicNode >> level: aValue [

	level := aValue
]
