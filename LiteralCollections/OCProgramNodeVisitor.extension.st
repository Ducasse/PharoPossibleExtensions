Extension { #name : 'OCProgramNodeVisitor' }

{ #category : '*LiteralCollections' }
OCProgramNodeVisitor >> visitLiteralCollectionNode: aLiteralCollectionNode [
	self visitNode:  aLiteralCollectionNode collectionClass.
	aLiteralCollectionNode children do: [ :each | self visitNode: each ]
]
