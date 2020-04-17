Class {
	#name : #GlovePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'corpus',
		'openCorpusButtton',
		'text'
	],
	#category : #NLP
}

{ #category : #specs }
GlovePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: #text;
			add: #openCorpusButtton;
			yourself)
		yourself
]

{ #category : #initialization }
GlovePresenter >> initializePresenters [

	openCorpusButtton := self newButton
		action: [ UIManager default chooseFullFileNameMatching: #('*') ].
	text := self newText.
	openCorpusButtton label: 'Open corpus'.

]

{ #category : #initialization }
GlovePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
	title: 'Global Vectors for Word Representation (GloVe)';
	initialExtent: 600@50
]

{ #category : #'as yet unclassified' }
GlovePresenter >> oneRow [

	^ SpecLayout composed
		newRow: [ :row | row add: #list; add: #button ];
		yourself

]
