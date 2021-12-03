Extension { #name : #AIGrid2DGenerator }

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIGrid2DGenerator class >> example1 [

	| g |
	g := self new
		     width: 10;
		     height: 10;
		     neighborhood: #moore.
	g run.
	
	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIGrid2DGenerator class >> example2 [

	| g |
	g := self new
		     width: 10;
		     height: 10;
		     neighborhood: #vonNeumann.
	g run.

	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
