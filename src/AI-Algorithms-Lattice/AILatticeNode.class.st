Class {
	#name : #AILatticeNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'descendants',
		'labels',
		'anscentorLabel'
	],
	#category : #'AI-Algorithms-Lattice'
}

{ #category : #'instance creation' }
AILatticeNode class >> withNew: concept [
	^ (self with: concept)
		concept: concept;
		yourself
]

{ #category : #ancestorsLabel }
AILatticeNode >> addAncestorLabel: aCollection [
	anscentorLabel ifNil: [ anscentorLabel := OrderedCollection new ].
	aCollection ifNotEmpty: [ :aNode | anscentorLabel add: aNode ]
]

{ #category : #accessing }
AILatticeNode >> addDescendant: aNode [
	descendants ifNil: [ descendants := OrderedCollection new ].
	descendants add: aNode.
]

{ #category : #enumerating }
AILatticeNode >> allDescendants: aNode [
	|myDescendants|
	myDescendants := OrderedCollection new.
	self descendantsDo: [:each | (each = aNode) ifFalse: [myDescendants add: each]].
	^myDescendants
]

{ #category : #ancestorsLabel }
AILatticeNode >> anscentorLabel [
	anscentorLabel ifNil: [^OrderedCollection new].
	^ (anscentorLabel flatCollect: [:each | each]) asSet.
]

{ #category : #construction }
AILatticeNode >> computeLabel [
	|desObjs desAttribs|
	desObjs := self descendants flatCollect: [:aDes | aDes concept objects].
	desAttribs := self descendants flatCollect: [:aDes | aDes concept attributes].
	self labels: (Array with: (self labelAttributes: desAttribs) with: (self labelObjects: desObjs)).
]

{ #category : #accessing }
AILatticeNode >> concept [
	
	^model
]

{ #category : #accessing }
AILatticeNode >> concept: anObject [
	
	model := anObject
]

{ #category : #enumerating }
AILatticeNode >> descendants [
	^descendants ifNil: OrderedCollection new.
]

{ #category : #enumerating }
AILatticeNode >> descendantsDo: aBlock [

	self descendants  do: aBlock.
	self descendants do: [ :each |
		each descendantsDo: aBlock ]
]

{ #category : #enumerating }
AILatticeNode >> hasDescendant: aNode [
	self descendantsDo: [:each | each = aNode ifTrue: [^true]].
	^false
]

{ #category : #construction }
AILatticeNode >> labelAttributes: aCollection [
	|attribs|
	"self concept objects size =1 ifTrue: [self halt]."
	attribs := (self myAttribLabel asSet) intersection: (aCollection asSet).
	self descendants do: [:aDes | aDes addAncestorLabel: (attribs union:self anscentorLabel)  ].
	^attribs 
]

{ #category : #construction }
AILatticeNode >> labelObjects: aCollection [
	^self concept objects difference: (aCollection)
]

{ #category : #accessing }
AILatticeNode >> labels [
	^labels ifNil: [^OrderedCollection new].
]

{ #category : #accessing }
AILatticeNode >> labels: aLabel [
	labels := aLabel.
]

{ #category : #accessing }
AILatticeNode >> layer [
	
	^self concept numAttributes
]

{ #category : #construction }
AILatticeNode >> maybeAppendChild: aNode [

	"Creates layers of concepts for all concepts except top and bottom"
	[self layer < aNode layer] assert.
	(self hasDescendant: aNode)
		ifFalse:
			[(aNode concept intent allMask: self concept intent)
				ifTrue: [self addDescendant: aNode]]
]

{ #category : #ancestorsLabel }
AILatticeNode >> myAttribLabel [
	^ self anscentorLabel ifEmpty: [ self concept attributes ] ifNotEmpty: [ :label | self concept attributes asSet difference: label asSet ]
]

{ #category : #printing }
AILatticeNode >> printString [
	^self labels first printString, self labels last printString
]

{ #category : #construction }
AILatticeNode >> removeDescendant: aCollection [
	descendants ifNotEmpty: [ aCollection do: [ :aNode | descendants remove: aNode ] ]
]
