"
MalFormalContext mammals2 computeConcepts
"
Class {
	#name : #LatticeFormalContext,
	#superclass : #Object,
	#instVars : [
		'fobjects',
		'fattributes',
		'concepts'
	],
	#category : #'AI-Algorithms-Lattice'
}

{ #category : #examples }
LatticeFormalContext class >> classHierarchy [
	^ self classHierarchy: Smalltalk globals allClasses
]

{ #category : #examples }
LatticeFormalContext class >> classHierarchy: classes [
	^ self new
		with: classes using: #yourself using: [ :each | each allSelectors difference: Object allSelectors ];
		yourself
]

{ #category : #examples }
LatticeFormalContext class >> classHierarchyCollection [
	^ self classHierarchy: Collection withAllSubclasses
]

{ #category : #examples }
LatticeFormalContext class >> classHierarchyInt [
	^ self classHierarchy: Integer withAllSubclasses
]

{ #category : #examples }
LatticeFormalContext class >> mammals [
	"(((		self mammals			)))"
	
	| data names fca |
	data := #(#(#ostrich #(#walks #laysEggs #featheres #warmblooded)) #(#mosquito #(#laysEggs #flies #small)) #(#vulture #(#laysEggs #featheres #warmblooded #flies)) #(#horse #(#walks #warmblooded #suckles)) #(#bat #(#warmblooded #flies #small #suckles)) #(#frog #(#quacks #laysEggs #small)) #(#dove #(#laysEggs #featheres #warmblooded #flies #small)) #(#crocodile #(#walks #laysEggs)) #(#robin #(#laysEggs #featheres #warmblooded #flies #sings #small)) #(#platypus #(#walks #laysEggs #warmblooded #suckles))).
	names := #(#robin #dove #vulture #ostrich #bat #horse #platypus #crocodile #frog #mosquito).
	names := String withAll: (names collect: #first).
	fca := self new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #examples }
LatticeFormalContext class >> mammals2 [
	"(((		self mammals2			)))"
	
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := self new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #examples }
LatticeFormalContext class >> mammals3 [
	"(((		self mammals2			)))"
	
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine)) #(#SuperMan #(#hair #smart #thumbed #marine #fourlegs))).
	fca := self new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #examples }
LatticeFormalContext class >> mammals4 [
	"all objects possessing a particular attribute"
	"(((		self mammals2			)))"
	
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair #hair)) #(#Dolphin #(#smart #marine #hair)) #(#Gibbon #(#hair #smart #thumbed #hair)) #(#Man #(#smart #thumbed #hair)) #(#Whale #(#smart #marine #hair))).
	fca := self new.
	fca with: data using: #first using: #last.
	^fca
]

{ #category : #accessing }
LatticeFormalContext >> attributes [
	
	^fattributes
]

{ #category : #private }
LatticeFormalContext >> computeConcepts [
	
	| algorithm |
	algorithm := MalGanterAlgorithm on: self.
	^algorithm allConcepts
]

{ #category : #accessing }
LatticeFormalContext >> concepts [
	
	^concepts ifNil: [concepts := self computeConcepts]
]

{ #category : #accessing }
LatticeFormalContext >> objects [
	
	^fobjects
]

{ #category : #printing }
LatticeFormalContext >> printOn: stream [
	
	super printOn: stream.
	stream
		space;
		nextPut: $(;
		print: self objects size;
		nextPut: $x;
		print: self attributes size;
		nextPut: $)
]

{ #category : #initialization }
LatticeFormalContext >> with: collection using: foBlock using: faBlock [
	
	| dict fobject fattribute |
	dict := Dictionary new.
	fobjects := "ArrayList"OrderedCollection new.
	fattributes := "ArrayList"OrderedCollection new.
	collection
		do:
			[:eachFo | 
			fobject := MalFCAElement with: (foBlock value: eachFo).
			fobject appendTo: fobjects.
			(faBlock value: eachFo)
				do:
					[:eachFa | 
					fattribute := dict
						at: eachFa
						ifAbsentPut:
							[fattribute := MalFCAElement with: eachFa.
							fattribute appendTo: fattributes].
					fattribute setBit: fobject.
					fobject setBit: fattribute]]
]
