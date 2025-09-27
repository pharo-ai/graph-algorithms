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
	#category : 'AI-Algorithms-Graph-Tests-Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
AIStableMatchingAlgorithmTest >> setUp [

	super setUp.
	
	a1 := AIStableMatchingNode new
		      data: 'm1';
		      yourself.
	a2 := AIStableMatchingNode new
		      data: 'm2';
		      yourself.
	a3 := AIStableMatchingNode new
		      data: 'm3';
		      yourself.

	b1 := AIStableMatchingNode new
		      data: 'w1';
		      yourself.
	b2 := AIStableMatchingNode new
		      data: 'w2';
		      yourself.
	b3 := AIStableMatchingNode new
		      data: 'w3';
		      yourself.

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

	algorithm := AIStableMatchingAlgorithm new
		          groupA: {
				          a1.
				          a2.
				          a3 };
		          groupB: {
				          b1.
				          b2.
				          b3 };
		          yourself
]

{ #category : 'tests-accessing' }
AIStableMatchingAlgorithmTest >> testFirstInGroupAHavingAMatchingToProposeTo [
	self
		assert: algorithm firstInGroupAHavingAMatchingToProposeTo equals: a1.
	
	a1
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.
	
	self
		assert: algorithm firstInGroupAHavingAMatchingToProposeTo equals: a2.
	
	a2
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.
	
	self
		assert: algorithm firstInGroupAHavingAMatchingToProposeTo equals: a3.
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testMatchWith [
	| matchingEdge |
	matchingEdge := AIStableMatchingEdge new nodeOfGroupA: a1; nodeOfGroupB: b1; yourself.
	self
		assert: a1 isFree;
		assert: b1 isFree.
	algorithm match: a1 with: b1.
	self
		assert: (algorithm stableMatching includes: matchingEdge);
		assert: a1 marriage equals: matchingEdge;
		assert: b1 marriage equals: matchingEdge;
		deny: a1 isFree;
		deny: b1 isFree
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testStableMarriage [
	| abe bob col dan ed fred gav hal ian jon abi bea cath dee eve fay gay hope ivy jan s matching marriages |
	abe := AIStableMatchingNode new
		data: 'abe';
		yourself.
	bob := AIStableMatchingNode new
		data: 'bob';
		yourself.
	col := AIStableMatchingNode new
		data: 'col';
		yourself.
	dan := AIStableMatchingNode new
		data: 'dan';
		yourself.
	ed := AIStableMatchingNode new
		data: 'ed';
		yourself.
	fred := AIStableMatchingNode new
		data: 'fred';
		yourself.
	gav := AIStableMatchingNode new
		data: 'gav';
		yourself.
	hal := AIStableMatchingNode new
		data: 'hal';
		yourself.
	ian := AIStableMatchingNode new
		data: 'ian';
		yourself.
	jon := AIStableMatchingNode new
		data: 'jon';
		yourself.
	abi := AIStableMatchingNode new
		data: 'abi';
		yourself.
	bea := AIStableMatchingNode new
		data: 'bea';
		yourself.
	cath := AIStableMatchingNode new
		data: 'cath';
		yourself.
	dee := AIStableMatchingNode new
		data: 'dee';
		yourself.
	eve := AIStableMatchingNode new
		data: 'eve';
		yourself.
	fay := AIStableMatchingNode new
		data: 'fay';
		yourself.
	gay := AIStableMatchingNode new
		data: 'gay';
		yourself.
	hope := AIStableMatchingNode new
		data: 'hope';
		yourself.
	ivy := AIStableMatchingNode new
		data: 'ivy';
		yourself.
	jan := AIStableMatchingNode new
		data: 'jan';
		yourself.
    abe
        preferences: {abi.eve.cath.ivy.jan.dee.fay.bea.hope.gay}.
    bob
        preferences: {cath.hope.abi.dee.eve.fay.bea.jan.ivy.gay}.
    col
        preferences: {hope.eve.abi.dee.bea.fay.ivy.gay.cath.jan}.
    dan
        preferences: {ivy.fay.dee.gay.hope.eve.jan.bea.cath.abi}.
    ed
        preferences: {jan.dee.bea.cath.fay.eve.abi.ivy.hope.gay}.
    fred
        preferences: {bea.abi.dee.gay.eve.ivy.cath.jan.hope.fay}.
    gav
        preferences: {gay.eve.ivy.bea.cath.abi.dee.hope.jan.fay}.
    hal
        preferences: {abi.eve.hope.fay.ivy.cath.jan.bea.gay.dee}.
    ian
        preferences: {hope.cath.dee.gay.bea.abi.fay.ivy.jan.eve}.
    jon
        preferences: {abi.fay.jan.gay.eve.bea.dee.cath.ivy.hope}.
    abi
        preferences: {bob.fred.jon.gav.ian.abe.dan.ed.col.hal}.
    bea
        preferences: {bob.abe.col.fred.gav.dan.ian.ed.jon.hal}.
    cath
        preferences: {fred.bob.ed.gav.hal.col.ian.abe.dan.jon}.
    dee
        preferences: {fred.jon.col.abe.ian.hal.gav.dan.bob.ed}.
    eve
        preferences: {jon.hal.fred.dan.abe.gav.col.ed.ian.bob}.
    fay
        preferences: {bob.abe.ed.ian.jon.dan.fred.gav.col.hal}.
    gay
        preferences: {jon.gav.hal.fred.bob.abe.col.ed.dan.ian}.
    hope
        preferences: {gav.jon.bob.abe.ian.dan.hal.ed.col.fred}.
	ivy
		preferences: {ian.col.hal.gav.fred.bob.abe.ed.	jon.dan}.
	jan
		preferences: {ed.hal.gav.abe.bob.jon.col.ian.fred.dan}.
	s := AIStableMatchingAlgorithm new
		groupA: {abe.bob.col.dan.ed.fred.gav.hal.ian.jon};
		groupB: {abi.bea.cath.dee.eve.fay.gay.hope.ivy.jan};
		run;
		yourself.
	matching := s stableMatching.
	marriages := {
		{ jon . abi }.
		{ fred . bea }.
		{ bob . cath }.
		{ col . dee }.
		{ hal . eve }.
		{ dan . fay }.
		{ gav . gay }.
		{ ian . hope }.
		{ abe . ivy }.
		{ ed . jan } }.
	self assert: (matching allSatisfy: [ :any1 | marriages anySatisfy: [ :any2 | any1 nodeOfGroupA = any2 first and: [ any1 nodeOfGroupB = any2 second ] ] ])
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testStableMatching [
	algorithm run.
	
	{ { a1 . b3 } . { a2 . b2 } . { a3 . b1 } } do: [ :arr |
		self
			assert: (algorithm stableMatching anySatisfy: [ :any | any nodeOfGroupA = arr first and: [ any nodeOfGroupB = arr second ] ]) ]
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testUnmatch [
	| matchingEdge |
	matchingEdge := AIStableMatchingEdge new nodeOfGroupA: a1; nodeOfGroupB: b1; yourself.
	algorithm match: a1 with: b1.
	self assert: (algorithm stableMatching includes: matchingEdge).
	
	algorithm unmatch: matchingEdge.
	self deny: (algorithm stableMatching includes: matchingEdge)
]
