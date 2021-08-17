"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAIAlgorithmsGraph,
	#superclass : #PackageManifest,
	#category : #'AI-Algorithms-Graph-Manifest'
}

{ #category : #'code-critics' }
ManifestAIAlgorithmsGraph class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AITarjan #popStackAndAddNewSccUntil: #false)) #'2021-08-17T12:43:07.085916+02:00') )
]

{ #category : #'code-critics' }
ManifestAIAlgorithmsGraph class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AITarjan #popStackAndAddNewSccUntil: #false)) #'2021-08-17T12:43:10.336858+02:00') )
]
