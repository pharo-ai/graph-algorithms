"
A SMSolverTest is a test class for testing the behavior of SMSolver
"
Class {
	#name : 'AIStableMatchingAlgorithmTest',
	#superclass : 'TestCase',
	#instVars : [
		'm1',
		'm2',
		'm3',
		'w1',
		'w2',
		'w3',
		'solver'
	],
	#category : 'AI-Algorithms-Graph-Tests-Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
AIStableMatchingAlgorithmTest >> setUp [

	super setUp.
	
	m1 := AIStableMatchingNode new
		      data: 'm1';
		      yourself.
	m2 := AIStableMatchingNode new
		      data: 'm2';
		      yourself.
	m3 := AIStableMatchingNode new
		      data: 'm3';
		      yourself.

	w1 := AIStableMatchingNode new
		      data: 'w1';
		      yourself.
	w2 := AIStableMatchingNode new
		      data: 'w2';
		      yourself.
	w3 := AIStableMatchingNode new
		      data: 'w3';
		      yourself.

	m1 preferences: {
			w3.
			w2.
			w1 }.
	m2 preferences: {
			w2.
			w3.
			w1 }.
	m3 preferences: {
			w1.
			w2.
			w3 }.

	w1 preferences: {
			m1.
			m2.
			m3 }.
	w2 preferences: {
			m2.
			m3.
			m1 }.
	w3 preferences: {
			m1.
			m2.
			m3 }.

	solver := AIStableMatchingAlgorithm new
		          men: {
				          m1.
				          m2.
				          m3 };
		          women: {
				          w1.
				          w2.
				          w3 };
		          yourself
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testDivorce [
	| marriage |
	marriage := AIStableMatchingEdge new man: m1; woman: w1; yourself.
	solver marry: m1 with: w1.
	self assert: (solver marriages includes: marriage).
	
	solver divorce: marriage.
	self deny: (solver marriages includes: marriage)
]

{ #category : 'tests-accessing' }
AIStableMatchingAlgorithmTest >> testFirstManHavingAWomanToProposeTo [
	self
		assert: solver firstManHavingAWomanToProposeTo equals: m1.
	
	m1
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.
	
	self
		assert: solver firstManHavingAWomanToProposeTo equals: m2.
	
	m2
		nextPreferenceToPropose;
		nextPreferenceToPropose;
		nextPreferenceToPropose.
	
	self
		assert: solver firstManHavingAWomanToProposeTo equals: m3.
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testMarryWith [
	| marriage |
	marriage := AIStableMatchingEdge new man: m1; woman: w1; yourself.
	self
		assert: m1 isFree;
		assert: w1 isFree.
	solver marry: m1 with: w1.
	self
		assert: (solver marriages includes: marriage);
		assert: m1 marriage equals: marriage;
		assert: w1 marriage equals: marriage;
		deny: m1 isFree;
		deny: w1 isFree
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testStableMatching [
	solver stableMatching.
	
	{ { m1 . w3 } . { m2 . w2 } . { m3 . w1 } } do: [ :arr |
		self
			assert: (solver marriages anySatisfy: [ :any | any man = arr first and: [ any woman = arr second ] ]) ]
]

{ #category : 'tests-computation' }
AIStableMatchingAlgorithmTest >> testStableMatching2 [
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
		men: {abe.bob.col.dan.ed.fred.gav.hal.ian.jon};
		women: {abi.bea.cath.dee.eve.fay.gay.hope.ivy.jan};
		stableMatching;
		yourself.
	matching := s marriages.
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
	self assert: (matching allSatisfy: [ :any1 | marriages anySatisfy: [ :any2 | any1 man = any2 first and: [ any1 woman = any2 second ] ] ])
]
