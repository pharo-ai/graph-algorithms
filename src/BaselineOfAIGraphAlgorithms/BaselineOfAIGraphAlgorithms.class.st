Class {
	#name : #BaselineOfAIGraphAlgorithms,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIGraphAlgorithms
}

{ #category : #baselines }
BaselineOfAIGraphAlgorithms >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		
		spec package: 'AI-Algorithms-Graph-Components'.
				
		spec
			package: 'AI-Algorithms-Graph'
			with: [ spec requires: #( 'AI-Algorithms-Graph-Components' ) ]..
		
		spec package: 'AI-Algorithms-Graph-Tests' with: [ 
			spec requires: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' ) ] ].
	
		spec
			package: 'AI-Algorithms-Graph-Generators'
			with: [ spec requires: #( 'AI-Algorithms-Graph' ) ].
		spec
			package: 'AI-Algorithms-Graph-Generators-Tests'
			with: [ spec requires: #( 'AI-Algorithms-Graph-Generators' ) ].

	
	
]

{ #category : #'as yet unclassified' }
BaselineOfAIGraphAlgorithms >> defineGroups: spec [ 

	spec
		group: 'Core' with: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components');
		group: 'Tests' with: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' 'AI-Algorithms-Graph-Tests' ).
	spec
		group: 'GraphGenerators' with: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' 'AI-Algorithms-Graph-Generators' );
		group: 'GraphGeneratorsTests' with: #( 'AI-Algorithms-Graph-Generators' 'AI-Algorithms-Graph-Generators-Tests' ).
	spec
		group: 'All' with: #( 'Core' 'Tests' );
		group: 'default' with: #( 'All' )
]
