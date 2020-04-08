Class {
	#name : #WAMOBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'packagesTable',
		'instancesTable',
		'instances'
	],
	#category : #WAMO
}

{ #category : #specs }
WAMOBrowser class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		add: #packagesTable;
		add: #instancesTable;
		yourself
]

{ #category : #'instance creation' }
WAMOBrowser class >> open [
	<script>

	^ self new openWithSpec
]

{ #category : #actions }
WAMOBrowser >> doCount [
	| allClasses |
	
	allClasses := Smalltalk allClasses.
	instances := OrderedCollection new: allClasses size.
	allClasses 
		do: [ :each | instances add: each -> (each allInstances size)  ] 
		displayingProgress: [ :each | each name ] 
		every: 0.
	packagesTable items: (instances groupedBy: [ :anAssoc | anAssoc key package ]) associations
]

{ #category : #initialization }
WAMOBrowser >> initialize [

	super initialize

]

{ #category : #initialization }
WAMOBrowser >> initializePresenters [

	packagesTable := self newTable
		items: ((instances ifNil: [ #() ]) groupedBy: [ :each | each key package ]) associations;
		addColumn: (SpStringTableColumn title: 'Package' evaluated: [ :a | a key name ]);
		addColumn: (SpStringTableColumn title: 'Instances' evaluated: [ :a | a value sum: #value ]);
		yourself.
		
	instancesTable := self newTable
		addColumn: (SpStringTableColumn title: 'Class' evaluated: [ :a | a key name ]);
		addColumn: (SpStringTableColumn title: 'Instances' evaluated: [ :a | a value ]);
		yourself.
		
	
	packagesTable transmitTo: instancesTable transform: #value
]

{ #category : #initialization }
WAMOBrowser >> initializeWindow: aWindowPresenter [ 

	aWindowPresenter 
		title: 'Wind instance inspector';
		initialExtent: 800@600;
		toolBar: (self newToolBar
 			addItem: (SpToolBarButtonPresenter new
				label: 'Go';
				icon: (self iconNamed: #smallFind);
				help: 'Count instances';
				action: [ self doCount ];
				yourself);
			yourself)
]

{ #category : #'accessing model' }
WAMOBrowser >> setModelBeforeInitialization: aCollectionOfAssociations [

	instances := aCollectionOfAssociations
]
