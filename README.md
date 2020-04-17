# nlp-smalltalk
## Global Vectors for Word Representation (GloVe) in Smalltalk

```smalltalk
| jawn vocab options coocurrences averages mostSimilar |
vocab := Glove buildVocabularyFromFileNamed: 'C:\Users\tg\Documents\bible-normalized-minus-stop.txt' threads: 4.
[ vocab ready ] whileFalse: [ 2 seconds wait ].
options := GloveOptions new.
options := options vectorSize: 200.
options := options windowSize: 5.
options := options alpha: 0.75.
coocurrences := Glove cooccurrenceListFromVocab: vocab options: options.
averages := (Glove trainWithVocab: vocab coocurrences: coocurrences options: options).

mostSimilar := Glove nMostSimilarToWord: 'egypt' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'jesus' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'god' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'famine' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'john' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'noah' aWordVector: averages vocab: vocab n: 10.
mostSimilar := Glove nMostSimilarToWord: 'sin' aWordVector: averages vocab: vocab n: 10.
```

### WIP
