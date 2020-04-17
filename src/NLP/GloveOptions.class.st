Class {
	#name : #GloveOptions,
	#superclass : #Object,
	#instVars : [
		'xMax',
		'learningRate',
		'alpha',
		'vectorSize',
		'iterations',
		'windowSize',
		'minCount',
		'debug'
	],
	#category : #NLP
}

{ #category : #accessing }
GloveOptions >> alpha [
	^ alpha
]

{ #category : #accessing }
GloveOptions >> alpha: anObject [
	alpha := anObject
]

{ #category : #accessing }
GloveOptions >> debug [
	^ debug
]

{ #category : #accessing }
GloveOptions >> debug: anObject [
	debug := anObject
]

{ #category : #initialization }
GloveOptions >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	
	self xMax: 100.0.
	self learningRate: 0.05.
	self alpha: 0.75.
	self vectorSize: 10.
	self iterations: 25.
	self windowSize: 5.
	self minCount: 0.
	self debug: false.
]

{ #category : #accessing }
GloveOptions >> iterations [
	^ iterations
]

{ #category : #accessing }
GloveOptions >> iterations: anObject [
	iterations := anObject
]

{ #category : #accessing }
GloveOptions >> learningRate [
	^ learningRate
]

{ #category : #accessing }
GloveOptions >> learningRate: anObject [
	learningRate := anObject
]

{ #category : #accessing }
GloveOptions >> minCount [
	^ minCount
]

{ #category : #accessing }
GloveOptions >> minCount: anObject [
	minCount := anObject
]

{ #category : #accessing }
GloveOptions >> vectorSize [
	^ vectorSize
]

{ #category : #accessing }
GloveOptions >> vectorSize: anObject [
	vectorSize := anObject
]

{ #category : #accessing }
GloveOptions >> windowSize [
	^ windowSize
]

{ #category : #accessing }
GloveOptions >> windowSize: anObject [
	windowSize := anObject
]

{ #category : #accessing }
GloveOptions >> xMax [
	^ xMax
]

{ #category : #accessing }
GloveOptions >> xMax: anObject [
	xMax := anObject
]
