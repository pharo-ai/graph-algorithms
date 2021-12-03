Class {
	#name : #AIHgPerformanceTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-HierarchicalGraph-Tests'
}

{ #category : #tests }
AIHgPerformanceTest >> testConstructingLargeHiGraphBottomUp [
	| hg rootNodes levels leafNodes profiler "result" |
	
	"(1 to: 1) do: [ :i |"

	rootNodes := OrderedCollection new.
	leafNodes := OrderedCollection new.
	levels := 11.
	
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	rootNodes do: [ :model | AIHierarchicalGraphTest new recursiveStringFactory: model in: leafNodes to: levels ].
	
	profiler := TimeProfiler new.
	"result := "profiler runBlock: [	

		hg := AIHierarchicalGraph with: leafNodes.
	
		hg aggregation: [ :model |  
			(model size > 1) 
			ifTrue: [ model truncateTo: (model size - 1). ]
			ifFalse: [ nil ].
		].
	].

	"Transcript show: '#propEdges: ', hg edgesPropagated size asString, '; '.
	
	profiler rootTallyItems do: [ :t |
		Transcript show: t method selector, ' ', t tally asString, '; '.
	].

	Transcript show: 'total: ', profiler tally asString, ';'; cr."
	
	"profiler open.
	profiler showResult: result."
	"hg explore."
 	"]."
]

{ #category : #tests }
AIHgPerformanceTest >> testConstructingLargeHiGraphTopDown [
	| hg rootNodes profiler children levels "result" |

	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	levels := 11.
	
	profiler := TimeProfiler new.
	"result := "profiler runBlock: [	
	
		hg := AIHierarchicalGraph with: rootNodes.
		hg topDown: [ :model |  
			(model size < levels) 
			ifTrue: [
				children := OrderedCollection new.
				children add: (model, 'a').
				children add: (model, 'b').
				children add: (model, 'c').
				children.
			]
		].
	].

	"profiler open.
	profiler showResult: result."
	"hg explore."
 	"]."
]
