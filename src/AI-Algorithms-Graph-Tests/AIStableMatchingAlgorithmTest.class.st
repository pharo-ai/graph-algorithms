"
I test the behavior of AIStableMatchingAlgorithm.
"
Class {
	#name : 'AIStableMatchingAlgorithmTest',
	#superclass : 'TestCase',
	#instVars : [
		'algorithm',
		'a1',
		'a2',
		'a3',
		'b1',
		'b2',
		'b3'
	],
	#category : 'AI-Algorithms-Graph-Tests-Graph Matching Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Graph Matching Tests'
}

{ #category : 'fixtures' }
AIStableMatchingAlgorithmTest >> abc_xyzBipartitionWithPreferences [
	"Example taken from https://en.wikipedia.org/wiki/Stable_matching_problem#Different_stable_matchings"

	| a b c x y z |
	a := AIStableMatchingNode with: 'a'.
	b := AIStableMatchingNode with: 'b'.
	c := AIStableMatchingNode with: 'c'.
	x := AIStableMatchingNode with: 'x'.
	y := AIStableMatchingNode with: 'y'.
	z := AIStableMatchingNode with: 'z'.

	a preferences: { y. x. z }.
	b preferences: { z. y. x }.
	c preferences: { x. z. y }.
	x preferences: { b. a. c }.
	y preferences: { c. b. a }.
	z preferences: { a. c. b }.
			
  ^ Array with: { a . b . c } with: { x . y . z }


]

{ #category : 'running' }
AIStableMatchingAlgorithmTest >> setUp [

	super setUp.

	a1 := AIStableMatchingNode with: 'a1'.
	a2 := AIStableMatchingNode with: 'a2'.
	a3 := AIStableMatchingNode with: 'a3'.

	b1 := AIStableMatchingNode with: 'b1'.
	b2 := AIStableMatchingNode with: 'b2'.
	b3 := AIStableMatchingNode with: 'b3'.

	a1 preferences: {
			b3.
			b2.
			b1 }.
	a2 preferences: {
			b2.
			b3.
			b1 }.
	a3 preferences: {
			b1.
			b2.
			b3 }.

	b1 preferences: {
			a1.
			a2.
			a3 }.
	b2 preferences: {
			a2.
			a3.
			a1 }.
	b3 preferences: {
			a1.
			a2.
			a3 }.

	algorithm := AIStableMatchingAlgorithm
		             groupA: {
				             a1.
				             a2.
				             a3 }
		             groupB: {
				             b1.
				             b2.
				             b3 }
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testBestMatchingForABC [

	| abc xyz algorithmFavouringABC bestStableMatchingForGroupABC |
	abc := self abc_xyzBipartitionWithPreferences first.
	xyz := self abc_xyzBipartitionWithPreferences second.
	algorithmFavouringABC := (AIStableMatchingAlgorithm
		                          groupA: abc
		                          groupB: xyz) run.
	bestStableMatchingForGroupABC := Set
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: abc first
				                                  contenderInGroupB: xyz second)
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: abc second
				                                  contenderInGroupB: xyz third)
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: abc third
				                                  contenderInGroupB: xyz first).
	self
		assert: (algorithmFavouringABC stableMatching collect: [ :each | each asTuple ])
		equals: (bestStableMatchingForGroupABC collect: [ :each | each asTuple ])
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testBestMatchingForXYZ [

	| abc xyz algorithmFavouringXYZ bestStableMatchingForGroupXYZ |
	abc := self abc_xyzBipartitionWithPreferences first.
	xyz := self abc_xyzBipartitionWithPreferences second.
	algorithmFavouringXYZ := (AIStableMatchingAlgorithm
		                          groupA: xyz
		                          groupB: abc) run.
	bestStableMatchingForGroupXYZ := Set
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: xyz third
				                                  contenderInGroupB: abc first)
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: xyz first
				                                  contenderInGroupB: abc second)
		                                 with: (AIStableMatchingEdge
				                                  contenderInGroupA: xyz second
				                                  contenderInGroupB: abc third).
	self
		assert: (algorithmFavouringXYZ stableMatching collect: [ :each | each asTuple ])
		equals: (bestStableMatchingForGroupXYZ collect: [ :each | each asTuple ])
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testFirstContenderInGroupAHavingAMatchingToProposeTo [

	self
		assert: algorithm nextProposer
		equals: a1.

	a1
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.

	self
		assert: algorithm nextProposer
		equals: a2.

	a2
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.

	self
		assert: algorithm nextProposer
		equals: a3
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testMatchWith [

	| matchingEdge |
	matchingEdge := AIStableMatchingEdge
		                contenderInGroupA: a1
		                contenderInGroupB: b1.
	self
		assert: a1 isFree;
		assert: b1 isFree.
	algorithm matchContenderInGroupA: a1 withContenderInGroupB: b1.
	self
		assert: (algorithm stableMatching includes: matchingEdge);
		assert: a1 pairing equals: matchingEdge;
		assert: b1 pairing equals: matchingEdge;
		deny: a1 isFree;
		deny: b1 isFree
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testStableMarriageExample [

	| abe bob col dan ed fred gav hal ian jon abi bea cath dee eve fay gay hope ivy jan s matching marriages |
	abe := AIStableMatchingNode with: 'abe'.
	bob := AIStableMatchingNode with: 'bob'.
	col := AIStableMatchingNode with: 'col'.
	dan := AIStableMatchingNode with: 'dan'.
	ed := AIStableMatchingNode with: 'ed'.
	fred := AIStableMatchingNode with: 'fred'.
	gav := AIStableMatchingNode with: 'gav'.
	hal := AIStableMatchingNode with: 'hal'.
	ian := AIStableMatchingNode with: 'ian'.
	jon := AIStableMatchingNode with: 'jon'.
	abi := AIStableMatchingNode with: 'abi'.
	bea := AIStableMatchingNode with: 'bea'.
	cath := AIStableMatchingNode with: 'cath'.
	dee := AIStableMatchingNode with: 'dee'.
	eve := AIStableMatchingNode with: 'eve'.
	fay := AIStableMatchingNode with: 'fay'.
	gay := AIStableMatchingNode with: 'gay'.
	hope := AIStableMatchingNode with: 'hope'.
	ivy := AIStableMatchingNode with: 'ivy'.
	jan := AIStableMatchingNode with: 'jan'.

	abe preferences: {
			abi.
			eve.
			cath.
			ivy.
			jan.
			dee.
			fay.
			bea.
			hope.
			gay }.
	bob preferences: {
			cath.
			hope.
			abi.
			dee.
			eve.
			fay.
			bea.
			jan.
			ivy.
			gay }.
	col preferences: {
			hope.
			eve.
			abi.
			dee.
			bea.
			fay.
			ivy.
			gay.
			cath.
			jan }.
	dan preferences: {
			ivy.
			fay.
			dee.
			gay.
			hope.
			eve.
			jan.
			bea.
			cath.
			abi }.
	ed preferences: {
			jan.
			dee.
			bea.
			cath.
			fay.
			eve.
			abi.
			ivy.
			hope.
			gay }.
	fred preferences: {
			bea.
			abi.
			dee.
			gay.
			eve.
			ivy.
			cath.
			jan.
			hope.
			fay }.
	gav preferences: {
			gay.
			eve.
			ivy.
			bea.
			cath.
			abi.
			dee.
			hope.
			jan.
			fay }.
	hal preferences: {
			abi.
			eve.
			hope.
			fay.
			ivy.
			cath.
			jan.
			bea.
			gay.
			dee }.
	ian preferences: {
			hope.
			cath.
			dee.
			gay.
			bea.
			abi.
			fay.
			ivy.
			jan.
			eve }.
	jon preferences: {
			abi.
			fay.
			jan.
			gay.
			eve.
			bea.
			dee.
			cath.
			ivy.
			hope }.
	abi preferences: {
			bob.
			fred.
			jon.
			gav.
			ian.
			abe.
			dan.
			ed.
			col.
			hal }.
	bea preferences: {
			bob.
			abe.
			col.
			fred.
			gav.
			dan.
			ian.
			ed.
			jon.
			hal }.
	cath preferences: {
			fred.
			bob.
			ed.
			gav.
			hal.
			col.
			ian.
			abe.
			dan.
			jon }.
	dee preferences: {
			fred.
			jon.
			col.
			abe.
			ian.
			hal.
			gav.
			dan.
			bob.
			ed }.
	eve preferences: {
			jon.
			hal.
			fred.
			dan.
			abe.
			gav.
			col.
			ed.
			ian.
			bob }.
	fay preferences: {
			bob.
			abe.
			ed.
			ian.
			jon.
			dan.
			fred.
			gav.
			col.
			hal }.
	gay preferences: {
			jon.
			gav.
			hal.
			fred.
			bob.
			abe.
			col.
			ed.
			dan.
			ian }.
	hope preferences: {
			gav.
			jon.
			bob.
			abe.
			ian.
			dan.
			hal.
			ed.
			col.
			fred }.
	ivy preferences: {
			ian.
			col.
			hal.
			gav.
			fred.
			bob.
			abe.
			ed.
			jon.
			dan }.
	jan preferences: {
			ed.
			hal.
			gav.
			abe.
			bob.
			jon.
			col.
			ian.
			fred.
			dan }.
	s := AIStableMatchingAlgorithm
		     groupA: {
				     abe.
				     bob.
				     col.
				     dan.
				     ed.
				     fred.
				     gav.
				     hal.
				     ian.
				     jon }
		     groupB: {
				     abi.
				     bea.
				     cath.
				     dee.
				     eve.
				     fay.
				     gay.
				     hope.
				     ivy.
				     jan }.
	s run.
	matching := s stableMatching.
	marriages := {
		             {
			             jon.
			             abi }.
		             {
			             fred.
			             bea }.
		             {
			             bob.
			             cath }.
		             {
			             col.
			             dee }.
		             {
			             hal.
			             eve }.
		             {
			             dan.
			             fay }.
		             {
			             gav.
			             gay }.
		             {
			             ian.
			             hope }.
		             {
			             abe.
			             ivy }.
		             {
			             ed.
			             jan } }.
	self assert: (matching allSatisfy: [ :any1 |
				 marriages anySatisfy: [ :any2 |
					 any1 contenderInGroupA = any2 first and: [
						 any1 contenderInGroupB = any2 second ] ] ])
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testStableMatching [

	algorithm run.

	{
		{
			a1.
			b3 }.
		{
			a2.
			b2 }.
		{
			a3.
			b1 } } do: [ :arr |
			self assert: (algorithm stableMatching anySatisfy: [ :any |
					 any contenderInGroupA = arr first and: [
						 any contenderInGroupB = arr second ] ]) ]
]

{ #category : 'tests' }
AIStableMatchingAlgorithmTest >> testUnmatch [

	| matchingEdge |
	matchingEdge := AIStableMatchingEdge
		                contenderInGroupA: a1
		                contenderInGroupB: b1.
	algorithm matchContenderInGroupA: a1 withContenderInGroupB: b1.
	self assert: (algorithm stableMatching includes: matchingEdge).

	algorithm unmatch: matchingEdge.
	self deny: (algorithm stableMatching includes: matchingEdge)
]
