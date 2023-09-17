Class {
	#name : #RBScanner2,
	#superclass : #RBScanner,
	#category : #InterrogationMark
}

{ #category : #initialization }
RBScanner2 class >> reset [
	"Since the classificationTable is a class instance variable i.e. there is one per class. We should initialize it. 
	I'm not sure that initialize class method is invoked on each of the class so manually do it for now"
	<script>
	
	self initialize
]

{ #category : #'private - scanning' }
RBScanner2 >> isSelector [

	characterType = #binary
		ifTrue: [ [ characterType = #binary ] whileTrue: [ self step ].
			^ characterType = #eof ].
	characterType ~= #alphabetic
		ifTrue: [ ^ false ].
	^ self isSelectorNonBinary
]

{ #category : #'private - scanning' }
RBScanner2 >> scanKeyword [
	"This scan can actually give odd keywords like a single colon.
	 : is a keyword but it is an impossible one to reach with a call to next.
	 However, a call to next can give an RBMultiKeywordLiteralToken even if the string scanned is like
	 the following : 'keyword:::::::'. Here, each colon is considered a keyword."
	"Of course, a keyword must finish with a colon. That's why arguments are not taken into account."
	
	| outputPosition inputPosition name |
	[currentCharacter = $:] whileTrue:
			[buffer nextPut: currentCharacter.
			outputPosition := buffer position.
			inputPosition := stream position.
			self step.	":"
			[characterType = #alphabetic or: [ currentCharacter = $?] ] whileTrue: [self scanName]].
	buffer position: outputPosition.
	stream position: inputPosition.
	self step.
	name := buffer contents.
	^(name occurrencesOf: $:) == 1
		ifTrue: [RBKeywordToken value: name start: tokenStart]
		ifFalse:
			[RBMultiKeywordLiteralToken
				value: name asSymbol
				start: tokenStart
				stop: tokenStart + name size - 1]
]

{ #category : #'private - scanning' }
RBScanner2 >> scanName [
	[characterType = #alphabetic or: [characterType = #digit or: [ currentCharacter = $? ] ] ] whileTrue:
			[buffer nextPut: currentCharacter.
			self step]
]
