Extension { #name : 'OCASTTranslator' }

{ #category : '*LiteralCollections' }
OCASTTranslator >> visitLargeLiteralCollectionNode: aLiteralCollectionNode [
	"Long form: generates (CollectionCLass braceStream: N) nextPut: a; nextPut: b; ...; braceArray"
	
	methodBuilder pushLiteralVariable: aLiteralCollectionNode collectionClass binding.
	methodBuilder pushLiteral: aLiteralCollectionNode statements size.
	methodBuilder send: #braceStream:.
	aLiteralCollectionNode statements do: [ :each |
		methodBuilder pushDup.
		self visitNode: each.
		methodBuilder send: #nextPut:.
		methodBuilder popTop.
		].
	methodBuilder send: #braceArray
]

{ #category : '*LiteralCollections' }
OCASTTranslator >> visitLiteralCollectionNode: anArrayNode [

	| elementNodes |

	anArrayNode statements size > 32 ifTrue: [^ self visitLargeLiteralCollectionNode: anArrayNode ].

	elementNodes := anArrayNode children.
	elementNodes do: [:node | self visitNode: node].
	methodBuilder pushConsArray: elementNodes size
]
