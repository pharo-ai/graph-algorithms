"
Description
--------------------

I am a Mock class for Mosse Algos tests
"
Class {
	#name : #AIHgTestModelSimple,
	#superclass : #Object,
	#instVars : [
		'model',
		'parent',
		'children',
		'level'
	],
	#category : #'AI-Algorithms-HierarchicalGraph-Tests'
}

{ #category : #accessing }
AIHgTestModelSimple >> children [
	^ children
]

{ #category : #accessing }
AIHgTestModelSimple >> children: anObject [
	children := anObject
]

{ #category : #initialization }
AIHgTestModelSimple >> initialize [
	children := OrderedCollection new
]

{ #category : #testing }
AIHgTestModelSimple >> isLeaf [
	^ children isEmpty.
]

{ #category : #accessing }
AIHgTestModelSimple >> level [
	^ level
]

{ #category : #accessing }
AIHgTestModelSimple >> level: aNumber [
	level := aNumber.
]

{ #category : #accessing }
AIHgTestModelSimple >> model [
	^ model
]

{ #category : #accessing }
AIHgTestModelSimple >> model: anObject [
	model := anObject
]

{ #category : #testing }
AIHgTestModelSimple >> notLeaf [
	^ children notEmpty.
]

{ #category : #accessing }
AIHgTestModelSimple >> parent [
	^ parent
]

{ #category : #accessing }
AIHgTestModelSimple >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
AIHgTestModelSimple >> printOn: aStream [
	aStream
		nextPutAll: 'Test: ';
		nextPutAll: model asString.
]

{ #category : #enumerating }
AIHgTestModelSimple >> recursiveChildren [
	"Returns the whole family tree below myself (excluding myself). "
	^ self recursiveChildren: false.
	
]

{ #category : #enumerating }
AIHgTestModelSimple >> recursiveChildren: withMyself [
	"Returns the whole family tree below myself. 
	If withMyself is true, also add myself to the returning set."
	| result |
	result := Set new.
	
	withMyself ifTrue: [
		result add: self.
	].
	
	self isLeaf ifTrue: [
		^ result.	
	].

	result addAll: children.
	
	children do: [ :each | 
		result addAll: (each recursiveChildren: true). 
	].

	^ result.
]
