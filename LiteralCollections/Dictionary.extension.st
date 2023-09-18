Extension { #name : 'Dictionary' }

{ #category : '*LiteralCollections' }
Dictionary class >> withAll: anArrayOfAssociations [
	"Answer an instance of me containing the same associations as the argument.
	If the same key appears twice, the last one enumerated will win"

	"(Dictionary withAll: {1->#a. 2->#b. 3->#c}) >>> ({1->#a. 2->#b. 3->#c} asDictionary)"

	| newDictionary |
	newDictionary := self new: anArrayOfAssociations size.
	anArrayOfAssociations associationsDo: [:x |newDictionary add: x].
	^ newDictionary
]
