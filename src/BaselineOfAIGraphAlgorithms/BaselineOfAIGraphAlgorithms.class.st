"
Baseline of the project
"
Class {
	#name : #BaselineOfAIGraphAlgorithms,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIGraphAlgorithms
}

{ #category : #baselines }
BaselineOfAIGraphAlgorithms >> baseline: spec [

	<baseline>
	spec for: #common do: [

		"External dependencies"
		spec
    		baseline: 'AIExternalPolyMath'
			with: [ spec repository: 'github://pharo-ai/external-dependencies' ].
		
		"Packages"
		spec package: 'AI-Algorithms-Graph-Components'.
		spec
			package: 'AI-Algorithms-Graph'
			with: [ spec requires: #( 'AI-Algorithms-Graph-Components' ) ].
		spec
		   package: 'AI-Algorithms-Graph-Tests'
			with: [ spec requires: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' ) ].
		spec
			package: 'AI-Algorithms-Graph-Generators'
			with: [ spec requires: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' 'AIExternalPolyMath' ) ].
		spec
			package: 'AI-Algorithms-Graph-Generators-Tests'
			with: [ spec requires: #( 'AI-Algorithms-Graph-Generators' ) ].
		spec
			package: 'AI-Algorithms-Graph-Generators-Examples'
			with: [ spec requires: #( 'AI-Algorithms-Graph-Generators' ) ].
		
		"Define groups"
		spec
			group: 'Core' with: #( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components');
			group: 'Tests' with: #( 'AI-Algorithms-Graph-Tests' ).
		spec
			group: 'GraphGenerators'
			with: #( 'AI-Algorithms-Graph-Generators' );
			group: 'GraphGeneratorsTests'
			with: #( 'AI-Algorithms-Graph-Generators-Tests' ).
		
		spec group: 'default' with: #( 'Core' 'Tests' ).
		spec group: 'full' with: #( 'default' 'GraphGenerators' 'GraphGeneratorsTests' ) ]
]
