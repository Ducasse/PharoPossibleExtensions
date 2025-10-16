Class {
	#name : 'OCParserLiteralCollection',
	#superclass : 'OCParser',
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'private - parsing' }
OCParserLiteralCollection >> literalCollectionNodeClass [
	^ OCLiteralCollectionNode 
]

{ #category : 'private - parsing' }
OCParserLiteralCollection >> parseArrayable [
	"We have { and it can be { 1 . 2} or {:Set 1. 2. }"
	
	^ (self nextToken value = $:)
			ifFalse: [ self parseArray ]
			ifTrue: [ self parseLiteralCollection ]
	
]

{ #category : 'private - parsing' }
OCParserLiteralCollection >> parseLiteralCollection [
	":Set 1. 2 . 3 }"
	
	| startToken node |
	startToken := currentToken.
	self step.
	node := self literalCollectionNodeClass new.
	node left: startToken start.
	self step.
	node collectionClass: self parseVariableNode.
	
	self parseStatementList: false  into: node untilAnyCloserOf: '}'.
	(currentToken isSpecial: $})
		ifFalse: [ ^ self parseEnglobingError: node statements with: startToken errorMessage: '''}'' expected'].
	node right: currentToken start.
	self step.
	^ node
]

{ #category : 'private - parsing' }
OCParserLiteralCollection >> parsePrimitiveObject [
	| errorNode |
	currentToken isIdentifier ifTrue: [^self parsePrimitiveIdentifier].
	currentToken isLiteralToken ifTrue: [^self parsePrimitiveLiteral].
	currentToken isLiteralArrayToken
		ifTrue:
			[^currentToken isForByteArray
				ifTrue: [self parseLiteralByteArray]
				ifFalse: [self parseLiteralArray]].
	(currentToken isSpecial and: ('[({' includes: currentToken value))
		ifTrue:
			[currentToken value = $[ ifTrue: [^self saveCommentsDuring:[self parseBlock]].
			currentToken value = $( ifTrue: [^self parseParenthesizedExpression].
			currentToken value = ${ ifTrue: [^self parseArrayable]].

	"Annotations are implemented as a magic receiver '@'"
	(currentToken isBinary: #@) ifTrue: [
		| position |
		position := currentToken start.
		self step. "@"
		^ RBAnnotationMarkNode new start: position ].

	":id is only acceptable at the begin of a block. So just consume them as unexpected"
	((currentToken isSpecial: $:) and: [ self nextToken isIdentifier ])
		ifTrue: [
			| start |
			start := currentToken start.
			self step. ":"
			errorNode := OCParseErrorNode new
				             errorMessage: 'Unexpected block parameter';
				             start: start;
				             errorPosition: start;
				             stop: currentToken stop;
				             value: ':' , currentToken value.
			self step. "identifier"
			^ errorNode ].

	errorNode := self parseErrorNode: 'Variable or expression expected'.
	^errorNode
]
