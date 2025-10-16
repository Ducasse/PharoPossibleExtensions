Class {
	#name : 'OCParserLiteralCollectionTest',
	#superclass : 'TestCase',
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testDictionary [

	| compiler dict |
	compiler := OpalCompiler new.
	compiler compilationContext parserClass: OCParserLiteralCollection. 
	dict :=  (compiler evaluate: 
		'{ :Dictionary #a -> 33 . #b -> 44}' ).
	self assert: (dict at: #a)  equals: 33
	
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testDynamicArrayIsWorking [

	self assert: { } equals: #().
	self assert: { 1 . 2 } equals: #(1 2).
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testLiteralSet [

	| compiler |
	compiler := OpalCompiler new.
	compiler compilationContext parserClass: OCParserLiteralCollection. 
	self assert: (compiler evaluate: 
		'{ :Set 1 . 2 . 1}' )
		
		equals: #(1 2) asSet.
	
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testNestedLiteralSet [

	| compiler |
	compiler := OpalCompiler new.
	compiler compilationContext parserClass: OCParserLiteralCollection. 
	self assert: (compiler evaluate: 
		'{ :Set 1 . {  :Set 2 . 2 } . 1}' )
		
		equals:  (Set new add: 1 ; add: (Set new add: 2; add: 2; yourself);  add: 1 ;yourself).
	
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testOrderedCollection [

	| compiler |
	compiler := OpalCompiler new.
	compiler compilationContext parserClass: OCParserLiteralCollection. 
	self assert: (compiler evaluate: 
		'{ :OrderedCollection 1 . 2 . 1 . 3}' )
		
		equals: #(1  2 1 3) asOrderedCollection.
	
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testParseDynamicArrayAgain [

	| arrayNode |
	arrayNode := (OCParserLiteralCollection parseExpression: '{  1 . 2 }').
	self assert: arrayNode class equals: OCArrayNode.
	self assert: arrayNode statements first value equals: 1.
	self assert: arrayNode statements second value equals: 2.
]

{ #category : 'tests' }
OCParserLiteralCollectionTest >> testParseDynamicSet [

	| literalCollectionNode |
	literalCollectionNode := (OCParserLiteralCollection parseExpression: '{ :Set  1 . 2 }').
	self assert: literalCollectionNode class  equals: OCLiteralCollectionNode.
	self assert: literalCollectionNode collectionClass name equals: 'Set'.
	self assert: literalCollectionNode statements first value equals: 1.
	self assert: literalCollectionNode statements second value equals: 2.
]
