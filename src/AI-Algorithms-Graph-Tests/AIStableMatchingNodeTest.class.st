"
I test the behaviour of AIStableMatchingNode.
"
Class {
	#name : 'AIStableMatchingNodeTest',
	#superclass : 'TestCase',
	#instVars : [
		'a',
		'b',
		'c'
	],
	#category : 'AI-Algorithms-Graph-Tests-Graph Matching Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Graph Matching Tests'
}

{ #category : 'running' }
AIStableMatchingNodeTest >> setUp [

	super setUp.
	
	a := AIStableMatchingNode new.
	b := AIStableMatchingNode new.
	c := AIStableMatchingNode new.

	a preferences: {
			b.
			c }
]

{ #category : 'tests-accessing' }
AIStableMatchingNodeTest >> testNextPreferenceToPropose [
	self
		assert: a nextPreferenceToPropose equals: b;
		assert: a nextPreferenceToPropose equals: c;
		should: [ a nextPreferenceToPropose ] raise: Error
]

{ #category : 'tests-testing' }
AIStableMatchingNodeTest >> testPreferOver [
	self
		assert: (a prefer: b over: c);
		deny: (a prefer: c over: b)
]

{ #category : 'tests-testing' }
AIStableMatchingNodeTest >> testStillHasPreference [
	self
		assert: a stillHasPreference.
	a nextPreferenceToPropose.
	self
		assert: a stillHasPreference.
	a nextPreferenceToPropose.
	self
		deny: a stillHasPreference
]
