Class {
	#name : #Word,
	#superclass : #Magnitude,
	#instVars : [
		'text',
		'id',
		'frequency'
	],
	#category : #NLP
}

{ #category : #accessing }
Word >> < aWord [

	^ self hash < aWord hash
]

{ #category : #accessing }
Word >> = anObject [

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self hash = anObject hash.
]

{ #category : #accessing }
Word >> hash [

	| temp aHash |
	temp := 7.
	aHash := temp * 37 + (text hash).
	^ aHash
]

{ #category : #accessing }
Word >> text [

	^ text
]

{ #category : #accessing }
Word >> text: aString [

	text := aString
]
