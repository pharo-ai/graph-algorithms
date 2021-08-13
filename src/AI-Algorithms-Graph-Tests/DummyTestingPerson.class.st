"
I am a class only used by the Tests of graph algorithms. I am used to test if the graph algorithms work well with complex objects as nodes too, not only nodes that are characters. I only provide an array of persons object to test.
"
Class {
	#name : #DummyTestingPerson,
	#superclass : #Object,
	#instVars : [
		'name',
		'lastname',
		'id'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #testing }
DummyTestingPerson class >> generateNinePersonArray [

	| person1 person2 person3 person4 person5 person6 person7 person8 person9 |
	person1 := self new id: 1; name: 'John'; lastname: 'Doe'.
	person2 := self new id: 2; name: 'Charly'; lastname: 'Garcia'.
	person3 := self new id: 3; name: 'Janie'; lastname: 'Smith'.
	person4 := self new id: 4; name: 'William'; lastname: 'Jhonson'.
	person5 := self new id: 5; name: 'Joe'; lastname: 'Bloggs'.
	person6 := self new id: 6; name: 'Karen'; lastname: 'Bob'.
	person7 := self new id: 7; name: 'Stella'; lastname: 'Artois'.
	person8 := self new id: 8; name: 'Ingmar'; lastname: 'Bergman'.
	person9 := self new id: 9; name: 'Luis'; lastname: 'Spinetta'.
	^ { person1 . person2 . person3 . person4 . person5 . person6 . person7 . person8 . person9 }
]

{ #category : #accessing }
DummyTestingPerson >> id [

	^ id
]

{ #category : #accessing }
DummyTestingPerson >> id: anObject [

	id := anObject
]

{ #category : #accessing }
DummyTestingPerson >> lastname [

	^ lastname
]

{ #category : #accessing }
DummyTestingPerson >> lastname: anObject [

	lastname := anObject
]

{ #category : #accessing }
DummyTestingPerson >> name [

	^ name
]

{ #category : #accessing }
DummyTestingPerson >> name: anObject [

	name := anObject
]
