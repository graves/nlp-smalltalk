Class {
	#name : #Glove,
	#superclass : #Object,
	#category : #NLP
}

{ #category : #'as yet unclassified' }
Glove class >> buildVocabularyFromFileNamed: aFileName [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| vocab |
	vocab :=Vocabulary new.
	aFileName asFileReference readStreamDo: [ :readStream |
		| lineReader  line|
		lineReader := NLPLineReader on: readStream.
			[ (line := lineReader nextLine) isEmpty ]
				whileFalse: [ 
					(line splitOn: ' ') do: [ :word |
						vocab addOrUpdate: word ]
					] ].
	^ vocab
]

{ #category : #'as yet unclassified' }
Glove class >> buildVocabularyFromFileNamed: aFileName threads: anInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| vocab vocabsFut |
	
	vocab := Vocabulary new.
	vocabsFut := self buildVocabularyFuturesFromFileNamed: aFileName threads: anInteger.
	vocabsFut onSuccessDo: [ :vocabs |
		vocabs flattened collect: [ :aVocab | vocab merge: aVocab ].
		vocab ready: true ].
	
	^ vocab
]

{ #category : #'as yet unclassified' }
Glove class >> buildVocabularyFuturesFromFileNamed: aFileName threads: anInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| aRunner fileReference fileSize futures zippedFuts |
	aRunner := TKTNewProcessTaskRunner new.
	
	fileReference := aFileName asFileReference.
	fileSize := fileReference size.
	
	futures := (1 to: anInteger) collect: [ :n |
		| aTask aFuture |
		aTask := [ self buildVocabularyTaskFromFileReference: fileReference thread: n  threads: anInteger fileSize: fileSize ].
		aFuture := aRunner future: aTask .
		aFuture ].
	
	zippedFuts := futures at: 1.
	futures collect: [ :aFut | zippedFuts := zippedFuts zip: aFut ] from: 2 to: (futures size).
	
	^ zippedFuts andThen: [ :result | result flatten ]
]

{ #category : #accessing }
Glove class >> buildVocabularyTaskFromFileReference: aFileReference thread: anInteger threads: nThreads fileSize: fileSize [
	"comment stating purpose of class-side message"

	"scope: class-variables  &  class-instance-variables"

	| vocab startPos endPos |
	vocab := Vocabulary new.
	anInteger = 1
		ifTrue: [ startPos := 0.
			endPos := startPos + (fileSize / nThreads) asFloat ceiling ]
		ifFalse: [ startPos := 1 + ((fileSize / nThreads) * (anInteger - 1)) asFloat ceiling.
			endPos := startPos + (fileSize / nThreads) asFloat ceiling.
			endPos := endPos min: fileSize ].
		
	aFileReference
		readStreamDo: [ :readStream | 
			| lineReader line |
			lineReader := NLPLineReader on: (readStream position: startPos).
			
			[ ((line := lineReader nextLine) isEmpty)
				or: [ (readStream position) >= endPos ] ]
				whileFalse:
					[ 
						| announcer announcement |
						announcer := vocab announcer.
						announcement := VocabularyProgressAnnouncement new.
						announcement := announcement percentDone: (readStream position / endPos).
						announcement thread: anInteger.
						announcer announce: announcement. 
						(line splitOn: ' ') do: [ :word | vocab addOrUpdate: word ] ] 
				].
	^ vocab
]

{ #category : #'as yet unclassified' }
Glove class >> cooccurrenceListFromVocab: aVocabulary options: aGloveOptions [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| coocurrenceDict tokenIds coocurrences|
	coocurrenceDict := OrderPreservingDictionary new.
	tokenIds := aVocabulary wordToId values.

	tokenIds collectWithIndex: [ :tokenId :outerIdx |
		| start end centerId contextIds contextLen|
	
		start := 1 max: (outerIdx - (aGloveOptions windowSize) - 1).
		end := outerIdx.
	
		centerId := tokenIds at: outerIdx.
	
		contextIds := tokenIds copyFrom: start to: end.
		contextLen := contextIds size.
	
		contextIds collectWithIndex: [ :contextId :innerIdx |
			| leftId distance increment pair1 pair2 get|
		
			leftId := contextIds at: innerIdx.
			distance  := contextLen - (innerIdx - 1).
			increment := 1.0 / distance.
			
			pair1 := OrderedIntegerPair withWord1: centerId word2: leftId.
			get := coocurrenceDict at: pair1 ifAbsentPut: [ 0.0 ].
			get := get + increment.
			coocurrenceDict at: pair1 put: get.
			
			pair2 := OrderedIntegerPair withWord1: leftId word2: centerId.
			get := coocurrenceDict at: pair2 ifAbsentPut: [ 0.0 ].
			get := get + increment.
			coocurrenceDict at: pair2 put: get.
	 	].
	].

	coocurrences := coocurrenceDict associations collect: [ :assoc | 
				| pair | 
				pair := assoc key.
				Coocurrence withMain: (pair word1) context: (pair word2)  xij: (assoc value).
				].
			
	^ coocurrences
]

{ #category : #'as yet unclassified' }
Glove class >> nMostSimilarToWord: aString aWordVector: aVector vocab: aVocabulary n: anInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| wordId wordVector mostSimilar idx |
	wordId := (aVocabulary getWordId: aString).
	wordVector := aVector columnAt: wordId.
	idx := 0.
	mostSimilar := aVector columnsCollect: [ :column | 
			| result |
			idx := idx + 1.
			result := wordVector * column.
			IntegerDoublePair withId: idx val: result
			 ].
	mostSimilar := mostSimilar sort reverse.
	
	^ (1 to: anInteger)
			collect: [ :simIdx | aVocabulary getWord: ((mostSimilar at: simIdx) id) ]
		
	
]

{ #category : #accessing }
Glove class >> trainWithVocab: aVocabulary coocurrences: aCoocurrenceList options: aGloveOptions [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"
	| vocabSize w biases gradientSquared gradientSquaredBiases c1 c2 |
	
	vocabSize := aVocabulary size.
	
	w := PMMatrix
		rows: aGloveOptions vectorSize
		columns: vocabSize * 2
		random: 1.0.
	w := w + -0.5.
	w := w * (1.0 / aGloveOptions vectorSize + 1).
	
	biases := PMMatrix rows: 1 columns: vocabSize * 2 random: 1.0.
	biases := biases + -0.5.
	biases := biases * (1.0 / aGloveOptions vectorSize + 1).
	
	gradientSquared := PMMatrix
		onesRows: aGloveOptions vectorSize
		cols: vocabSize * 2.
		
	gradientSquaredBiases := PMMatrix onesRows: 1 cols: vocabSize * 2.
	
	1 to: aGloveOptions iterations do: [ :i | 
		| globalCost coocurrences |
		
		globalCost := 0.0.
		coocurrences := aCoocurrenceList shuffle.
		
		coocurrences
			collect: [ :c | 
				| iMain iContext coocurrence weight vMain vContext 
				gradsqWMain gradsqWContext gradsqBMain gradsqBContext 
				bMain bContext costInner cost gradMain gradContext 
				gradBiasMain gradBiasContext |
				
				iMain := c main.
				iContext := c context.
				coocurrence := c xij.
				
				weight := coocurrence < aGloveOptions xMax
					ifTrue: [ coocurrence / aGloveOptions xMax ** aGloveOptions alpha ]
					ifFalse: [ 1.0 ].
					
				vMain := w columnAt: iMain.
				vContext := w columnAt: vocabSize + iContext.
				
				gradsqWMain := gradientSquared columnAt: iMain.
				gradsqWContext := gradientSquared columnAt: vocabSize + iContext.
				
				gradsqBMain := gradientSquaredBiases at: 1 at: iMain.
				gradsqBContext := gradientSquaredBiases
					at: 1
					at: vocabSize + iContext.
					
				bMain := biases at: 1 at: iMain.
				bContext := biases at: 1 at: vocabSize + iContext.
				
				costInner := vMain * vContext + bMain + bContext - coocurrence ln.
				cost := weight * (costInner ** 2).
				globalCost := globalCost + (0.5 * cost).
				
				gradMain := vContext * costInner.
				gradContext := vMain * costInner.
				gradBiasMain := costInner.
				gradBiasContext := costInner.
				
				vMain := vMain
					- (gradMain / gradsqWMain sqrt * aGloveOptions learningRate).
				w atColumn: iMain put: vMain.
				
				vContext := vContext
					- (gradContext / gradsqWContext sqrt * aGloveOptions learningRate).
				w atColumn: vocabSize + iContext put: vContext.
				
				bMain := (bMain - (aGloveOptions learningRate * gradBiasMain))
					/ gradsqBMain sqrt.
				biases at: 1 at: iMain put: bMain.
				
				bContext := (bContext
					- (aGloveOptions learningRate * gradBiasContext))
					/ gradsqBContext sqrt.
				biases at: 1 at: vocabSize + iContext put: bContext.
				
				gradsqWMain := gradsqWMain + (gradMain * gradMain).
				gradientSquared atColumn: iMain put: gradsqWMain.
				
				gradsqWContext := gradsqWContext + (gradContext * gradContext).
				gradientSquared atColumn: iContext + vocabSize put: gradsqWContext.
				
				gradsqBMain := gradsqBMain + (gradBiasMain * gradBiasMain).
				gradientSquaredBiases at: 1 at: iMain put: gradsqBMain.
				
				gradsqBContext := gradsqBContext
					+ (gradBiasContext * gradBiasContext).
				gradientSquaredBiases
					at: 1
					at: iContext + vocabSize
					put: gradsqBContext 
					
					] 
				].
			
	c1 := PMMatrix rows: (aGloveOptions vectorSize) columns: vocabSize.

	(1 to: vocabSize)
		collect: [ :idx | 
			| c |
			c := w columnAt: idx .
			c1 atColumn: idx put: c
			].
		
	c2 := PMMatrix rows: (aGloveOptions vectorSize) columns: vocabSize.

	((vocabSize + 1) to: (2 * vocabSize))
		collect: [ :idx | 
			| c |
			c := w columnAt: idx .
			c2 atColumn: (idx - vocabSize) put: c
			].
		
	^ (c1 + c2) * 0.5
]
