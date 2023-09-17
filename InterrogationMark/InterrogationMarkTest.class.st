Class {
	#name : #InterrogationMarkTest,
	#superclass : #TestCase,
	#category : #InterrogationMark
}

{ #category : #tests }
InterrogationMarkTest >> testExpressionCannotStartWithInterrogrationMark [
	|scan |
	RBScanner2 reset.
	scan := (RBScanner2 on:  'x ?foo' readStream).
	self assert: scan next value equals: 'x'.
	self assert: scan next  value equals: '?'.
	self assert: scan next  value equals: 'foo'.
	
]

{ #category : #tests }
InterrogationMarkTest >> testExpressionNoSpace [
	|scan |
	RBScanner2 reset.
	scan := (RBScanner2 on:  'x handles?:arg' readStream).
	self assert: scan next value equals: 'x'.
	self assert: scan next  value equals: 'handles?:'.
	self assert: scan next value equals: 'arg'.
]

{ #category : #tests }
InterrogationMarkTest >> testExpressionThree [
	|scan |
	RBScanner2 reset.
	scan := (RBScanner2 on:  'x? handles?: arg?' readStream).
	self assert: scan next value equals: 'x?'.
	self assert: scan next  value equals: 'handles?:'.
	self assert: scan next value equals: 'arg?'.
]

{ #category : #tests }
InterrogationMarkTest >> testExpressionTwo [
	|scan |
	RBScanner2 reset.
	scan := (RBScanner2 on:  'x handles?: arg' readStream).
	self assert: scan next value equals: 'x'.
	self assert: scan next  value equals: 'handles?:'.
	self assert: scan next value equals: 'arg'.
]

{ #category : #tests }
InterrogationMarkTest >> testInterrogationAsPartOfSelector [
	
	RBScanner2 reset.
	self shouldnt: [ RBParser2 parseExpression: 'x handles?: arg'] raise: Error.
	self shouldnt: [ RBParser2 parseExpression: 'x ? arg'] raise: Error.
]

{ #category : #tests }
InterrogationMarkTest >> testIsSelector [
	
	RBScanner2 reset.
	self assert: (RBScanner2 isSelector: 'handles?:').
	self assert: (RBScanner2 isSelector: 'ha?ndles?:').
	
]

{ #category : #tests }
InterrogationMarkTest >> testIsSelectorNot [
	
	RBScanner2 reset.
	self deny: (RBScanner2 isSelector: '?foo').
	self deny: (RBScanner2 isSelector: '? foo').
]

{ #category : #tests }
InterrogationMarkTest >> testNumArgs [

	String initialize.
	self assert: 'handles?:' numArgs equals: 1.
	self assert: 'handles?:arg:' numArgs equals: 2.
	self assert: '_handles?:arg:' numArgs equals: 2.
	self assert: '+' numArgs equals: 1.
	self assert: '?' numArgs equals: 1.
]

{ #category : #tests }
InterrogationMarkTest >> testParser [
	
	RBScanner2 reset.
	self shouldnt: [ RBParser2 parseExpression: 'x handles?: arg'] raise: Error.
	self shouldnt: [ RBParser2 parseExpression: 'x ? arg'] raise: Error.
]

{ #category : #tests }
InterrogationMarkTest >> testScanKeyword [
	|scan |
	RBScanner2 reset.
	self assert: (RBScanner2 on:  'handles?:' readStream) next value equals: 'handles?:'.
	self assert: (RBScanner2 on:  'x handles?: arg' readStream) next value equals: 'x'.
	scan := (RBScanner2 on:  'x handles?: arg' readStream).
	self assert: (scan next ; next ; next) value equals: 'arg'.
]
