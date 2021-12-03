Class {
	#name : #AILatticeTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Lattice-Tests'
}

{ #category : #initialize }
AILatticeTest >> initializeDataMammals [
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #initialize }
AILatticeTest >> initializeDataMammals2 [
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#smart #fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #initialize }
AILatticeTest >> initializeHD [
	"lattice with horizontal decomposition"
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #thumbed)) #(#Man #(#hair #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #initialize }
AILatticeTest >> initializeHD2 [
	"lattice with horizontal decomposition"
	| data fca |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #thumbed)) #(#Man #(#hair #thumbed)) #(#Whale #(#smart #marine)) #(#a #(#b #c))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #tests }
AILatticeTest >> testAllAncestors [
	"ancestors of a node"

	| lattice patterns |
	
	self skip.
	
	lattice := AILattice on: self initializeDataMammals2.
	patterns := ModuleIdentification new lattice: lattice.
	self assert: (patterns allAncestors: (lattice nodes at: 2)) size equals: 2.
	self assert: (patterns allAncestors: (lattice nodes at: 3)) size equals: 1.
	self assert: (((patterns allAncestors: (lattice nodes at: 3)) at: 1) concept attributes at: 1) value equals: #smart
]

{ #category : #tests }
AILatticeTest >> testComplexMammals2 [
	| lattice patterns |
	lattice := AILattice on: self initializeDataMammals2.
	patterns := AILatticePatterns on: lattice.
	self assert: (patterns isSuperConceptSpecialization: lattice top) not.
	self assert: patterns black size equals: 2.
	self assert: patterns grey size equals: 2.
	self assert: patterns full size equals: 3.
	self assert: patterns empty size equals: 3
]

{ #category : #tests }
AILatticeTest >> testLatticeMammals [
	| lattice |
	lattice := AILattice on: self initializeDataMammals.
	self assert: lattice nodes size equals: 8.
	self assert: lattice bottom concept numAttributes equals: 5.
	self assert: lattice top concept numObjects equals: 6.
	self assert: lattice nodes size equals: 8.
	self assert: (lattice top hasDescendant: lattice bottom).
	self assert: lattice bottom descendants isEmpty
]

{ #category : #tests }
AILatticeTest >> testLatticePatterns [
	| lattice patterns |
	lattice := AILattice on: self initializeDataMammals.
	patterns := AILatticePatterns on: lattice.
	self assert: patterns full size equals: 3.
	self assert: patterns black size equals: 1.
	self assert: patterns grey size equals: 2.
	self assert: patterns empty size equals: 2.
	self deny: patterns isTopBlack.
	self assert: (patterns isEmpty: patterns lattice top).
	self deny: patterns isTopGrey.
	self deny: patterns isTopFull.
	self assert: patterns totalConnections equals: 10
]

{ #category : #tests }
AILatticeTest >> testModule [
	| data fca context lattice modules |
	data := #(#(#a #()) #(#b #(1)) #(#c #(1 2)) #(#(#d) #(1 3)) #(#x #(1 5)) #(#(#e) #(1 2 3 5)) #(#(#f) #(1 2 3 4 5))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	lattice := AILattice on: context.
	modules := ModuleIdentification on: lattice.
	self assert: modules size equals: 1.
	self assert: modules first size equals: 5
]

{ #category : #tests }
AILatticeTest >> testModule2 [
	| data fca context lattice modules |
	data := #(#(#a #()) #(#b #(1)) #(#c #(1 2)) #(#(#d) #(1 3)) #(#(#e) #(1 2 3)) #(#(#f) #(1 2 3 4))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	lattice := AILattice on: context.	"(MalLattice new viewLattice: lattice)."
	modules := ModuleIdentification on: lattice.
	self assert: modules size equals: 1.
	self assert: modules first size equals: 4
]

{ #category : #tests }
AILatticeTest >> testPatternsHD [
	"Horizontal Decomposition lattice"

	| lattice patterns |
	lattice := AILattice on: self initializeHD.
	patterns := AILatticePatterns on: lattice.
	self assert: patterns horizontalDecomposition equals: 2.
	self assert: patterns isHorizontalDecomposition.
	self assert: patterns totalConnections equals: 7
]

{ #category : #tests }
AILatticeTest >> testPatternsHD2 [
	"A lattice without Horizontal Decomposition"

	| lattice patterns |
	lattice := AILattice on: self initializeDataMammals.
	patterns := AILatticePatterns on: lattice.
	self assert: patterns isHorizontalDecomposition not.
	self assert: patterns horizontalDecomposition equals: 0
]

{ #category : #tests }
AILatticeTest >> testPatternsHD3 [
	"Horizontal Decomposition lattice"

	| lattice patterns |
	lattice := AILattice on: self initializeHD2.
	patterns := AILatticePatterns on: lattice.
	self assert: patterns horizontalDecomposition equals: 3.
	self assert: patterns isHorizontalDecomposition.
	self assert: patterns totalConnections equals: 9
]

{ #category : #tests }
AILatticeTest >> testPatternsSpecialization [
	"Irreducible specialization"

	| lattice patterns |
	
	self skip.
	
	lattice := AILattice on: self initializeDataMammals.
	patterns := AILatticePatterns on: lattice.
	self assert: (patterns isSuperConceptSpecialization: lattice top) not.
	self
		assert:
			(patterns isSuperConceptSpecialization: (patterns lattice nodes at: 2)).
	self
		assert: (patterns isSubConceptSpecialization: lattice bottom) not.
	self
		assert: (patterns isSubConceptSpecialization: (patterns lattice nodes at: 3)).
	self assert: patterns irreducibleSpecialization values size equals: 0
]
