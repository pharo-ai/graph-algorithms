"
Description
--------------------

I am a Mock class for Mosse Algos tests
"
Class {
	#name : #AIHgTestEdge,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : #'AI-Algorithms-HierarchicalGraph-Tests'
}

{ #category : #'instance creation' }
AIHgTestEdge class >> from: from to: to [
	^ self new from: from; to: to; yourself.
]

{ #category : #accessing }
AIHgTestEdge >> from [
	^ from
]

{ #category : #accessing }
AIHgTestEdge >> from: anObject [
	from := anObject
]

{ #category : #accessing }
AIHgTestEdge >> to [
	^ to
]

{ #category : #accessing }
AIHgTestEdge >> to: anObject [
	to := anObject
]
