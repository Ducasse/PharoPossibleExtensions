Extension { #name : 'RBProgramNodeVisitor' }

{ #category : '*LiteralCollections' }
RBProgramNodeVisitor >> visitLiteralCollectionNode: aLiteralCollectionNode [
	self visitNode:  aLiteralCollectionNode collectionClass.
	aLiteralCollectionNode children do: [ :each | self visitNode: each ]
]
