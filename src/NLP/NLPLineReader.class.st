Class {
	#name : #NLPLineReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'buffer',
		'position',
		'limit'
	],
	#category : #NLP
}

{ #category : #'instance creation' }
NLPLineReader class >> on: stream [
	^ self new
		on: stream;
		yourself
]

{ #category : #private }
NLPLineReader >> growBuffer [
	| newBuffer |
	buffer size >= limit 
		ifTrue: [
			(ZnLineTooLong limit: limit) signal ].
	newBuffer := String new: buffer size * 2.
	newBuffer replaceFrom: 1 to: buffer size with: buffer.
	buffer := newBuffer 
]

{ #category : #accessing }
NLPLineReader >> limit: size [
	limit := size
]

{ #category : #accessing }
NLPLineReader >> nextLine [
	self reset.
	[ self processNext isNil ] whileFalse.
	^ buffer copyFrom: 1 to: position 
]

{ #category : #'initialize-release' }
NLPLineReader >> on: readStream [
	stream := readStream.
	buffer := String new: 116000.
	self 
		limit: 1048576; 
		reset
]

{ #category : #private }
NLPLineReader >> processNext [
	| item |
	stream atEnd ifTrue: [ ^ nil ].
	(item := stream next) ifNil: [ ^ nil ].
	stream isBinary ifTrue: [ item := item asCharacter ].
	item == Character lf
		ifTrue: [
			(position > 0 and: [ (buffer at: position) == Character cr ])
				ifTrue: [
					position := position - 1.
					^ nil ] ].
	self store: item.
	^ item
			
	
]

{ #category : #initialization }
NLPLineReader >> reset [
	position := 0
]

{ #category : #private }
NLPLineReader >> store: item [
	position >= buffer size ifTrue: [ self growBuffer ].
	position := position + 1.
	buffer at: position put: item		
	
]
