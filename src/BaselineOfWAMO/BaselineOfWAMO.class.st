Class {
	#name : #BaselineOfWAMO,
	#superclass : #BaselineOf,
	#category : #BaselineOfWAMO
}

{ #category : #baselines }
BaselineOfWAMO >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec package: #'WAMO' ].
	
]
