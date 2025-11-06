!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 19:35:43'!
initializeNamed: aName
	name := aName.
	self initialize.! !

!Account methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 19:59:38'!
name
	^name.! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'JC 11/5/2025 19:14:33'!
initializeNamed: aName
	name := aName.
	self initialize.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'PortfolioSummarizerVisit' stamp: 'JC 11/5/2025 19:56:57'!
visit: aVisitor
	aVisitor visitByPortfolio: self.! !

!Portfolio methodsFor: 'PortfolioSummarizerVisit' stamp: 'JC 11/5/2025 20:02:59'!
visitAccountsWith: aVisitor
	accounts do: [:anAccount | anAccount visit: aVisitor].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 19:14:05'!
named: aName
	^self new initializeNamed: aName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jec 11/2/2025 17:55:02'!
initialize
	super initialize.
	transactions := OrderedCollection new.
	resume := OrderedCollection new.
	transferNet := 0.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'lv 11/6/2025 16:33:20'!
register: aTransaction
	|aTransactionValue| 
	transactions add: aTransaction.
	aTransactionValue := aTransaction value.
	! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'JC 11/5/2025 18:59:18'!
transactions 
	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'visits' stamp: 'JC 11/5/2025 20:06:20'!
visit: aVisitor
	aVisitor visitByReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'visits' stamp: 'JC 11/5/2025 19:53:57'!
visitTransactionsWith: aVisitor
	transactions do: [:aTransaction | aTransaction beingVisitedBy: aVisitor].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 19:34:40'!
named: aName
	^self new initializeNamed: aName.! !


!classDefinition: #AccountSummarizer category: #'Portfolio-Solucion'!
Object subclass: #AccountSummarizer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:06:47'!
initializeFor: anAccount
	^self subclassResponsibility.! !

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:07:38'!
summary 
	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummarizer class' category: #'Portfolio-Solucion'!
AccountSummarizer class
	instanceVariableNames: ''!

!AccountSummarizer class methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:05:56'!
for: anAccount 
	^self new initializeFor: anAccount.! !


!classDefinition: #PortfolioSummarizer category: #'Portfolio-Solucion'!
AccountSummarizer subclass: #PortfolioSummarizer
	instanceVariableNames: 'portfolio summary spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummarizer methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:10:48'!
ensureCorrectIndentation: aBlock
	|oldSpaces|
	oldSpaces := spaces.
	spaces := spaces, '	'.
	aBlock ensure: [spaces := oldSpaces].
	! !

!PortfolioSummarizer methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:07:55'!
summary
	portfolio visit: self.
	^summary.
	! !


!PortfolioSummarizer methodsFor: 'initialization' stamp: 'JC 11/5/2025 20:25:15'!
initializeFor: aPortfolio 
	summary := OrderedCollection new.
	spaces := ''.
	portfolio := aPortfolio.! !


!PortfolioSummarizer methodsFor: 'summary modifications' stamp: 'JC 11/5/2025 20:29:45'!
addNameOf: anAccount
	summary add: spaces, anAccount name.! !

!PortfolioSummarizer methodsFor: 'summary modifications' stamp: 'JC 11/5/2025 21:00:20'!
addSummary: aSummary
	
	aSummary do: [:aSummaryLine | self addToSummary: aSummaryLine].
	! !

!PortfolioSummarizer methodsFor: 'summary modifications' stamp: 'JC 11/5/2025 20:40:30'!
addToSummary: aSummaryLine
	summary add: spaces, aSummaryLine.
	! !


!PortfolioSummarizer methodsFor: 'visits' stamp: 'lv 11/6/2025 16:11:24'!
visitByPortfolio: aPortfolio
	self addNameOf: aPortfolio.
	self ensureCorrectIndentation: [aPortfolio visitAccountsWith: self.
								 self addToSummary: 'Balance = ', aPortfolio balance printString].! !

!PortfolioSummarizer methodsFor: 'visits' stamp: 'lv 11/6/2025 16:10:48'!
visitByReceptiveAccount: aReceptiveAccount
	|accountSummary|
	
	self addNameOf: aReceptiveAccount.
	self ensureCorrectIndentation: [accountSummary := (ReceptiveAccountSummarizer for: aReceptiveAccount) summary.
	self addSummary: accountSummary].
	! !


!classDefinition: #ReceptiveAccountSummarizer category: #'Portfolio-Solucion'!
AccountSummarizer subclass: #ReceptiveAccountSummarizer
	instanceVariableNames: 'receptiveAccount summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountSummarizer methodsFor: 'initialization' stamp: 'JC 11/5/2025 18:32:19'!
initializeFor: aReceptiveAccount 
	receptiveAccount := aReceptiveAccount.
	summary := OrderedCollection new.! !


!ReceptiveAccountSummarizer methodsFor: 'visits' stamp: 'JC 11/5/2025 18:58:28'!
visitedByDeposit: aDeposit
	summary add: ('Depósito por ', aDeposit value printString, '.').! !

!ReceptiveAccountSummarizer methodsFor: 'visits' stamp: 'JC 11/5/2025 18:58:25'!
visitedByTransferDeposit: aTransferDeposit
	summary add: ('Entrada por transferencia de ', aTransferDeposit value printString, '.').! !

!ReceptiveAccountSummarizer methodsFor: 'visits' stamp: 'JC 11/5/2025 18:58:23'!
visitedByTransferWithdraw: aTransferWithdraw
	summary add: ('Salida por transferencia de ', aTransferWithdraw value printString, '.').! !

!ReceptiveAccountSummarizer methodsFor: 'visits' stamp: 'JC 11/5/2025 18:58:20'!
visitedByWithdraw: aWithdraw
	summary add: ('Extracción por ', aWithdraw value printString, '.').! !


!ReceptiveAccountSummarizer methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
summary
	|accountBalance|
	accountBalance := receptiveAccount balance printString.
	receptiveAccount visitTransactionsWith: self.
	summary add: 'Balance = ',accountBalance.
	^summary.! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'accountSummarizerVisit' stamp: 'JC 11/5/2025 18:52:27'!
beingVisitedBy: aVisitor
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 18:07:59'!
affectForTransferNet
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 18:57:27'!
beingVisitedBy: aVisitor
	aVisitor visitedByDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'associatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:21:27'!
affectBalance: aBalance
	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 18:09:32'!
affectForTransferNet
	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:23:27'!
initializeWithAssociatedTransfer: aTransfer
	associatedTransfer := aTransfer.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'lv 11/4/2025 20:10:27'!
transfer
	^associatedTransfer.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:17:56'!
value
	^ associatedTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: #'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:25:12'!
with: aTransfer
	^self new initializeWithAssociatedTransfer: aTransfer! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:17:06'!
affectBalance: aBalance
	^aBalance + self value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 18:09:44'!
affectForTransferNet
	^self value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:18:58'!
associatedWithdraw
	^associatedTransfer transferWithdraw.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 18:54:00'!
beingVisitedBy: aVisitor
	aVisitor visitedByTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: 'originalWithdraw'!


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:17:37'!
affectBalance: aBalance
	^aBalance - self value.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 18:10:01'!
affectForTransferNet
	^(-1)*(self value).! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:19:06'!
associatedDeposit
	^associatedTransfer transferDeposit.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 18:54:09'!
beingVisitedBy: aVisitor
	aVisitor visitedByTransferWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: 'originalDeposit'!


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'JC 11/5/2025 18:53:30'!
beingVisitedBy: aVisitor
	aVisitor visitedByWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'transferDeposit transferWithdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:27:55'!
hasThisValue: aValue
	^aValue = value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:42:58'!
initializeFrom: transferingAccount to: transferredAccount withAmount: anAmount
	transferDeposit := TransferDeposit with: self.
	transferWithdraw := TransferWithdraw with: self.
	value := anAmount.
	transferingAccount register: transferWithdraw.
	transferredAccount register: transferDeposit.
	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'lv 10/31/2025 21:57:03'!
transferDeposit
	^transferDeposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 15:58:18'!
transferWithdraw
	^transferWithdraw ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 17:18:14'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 15:06:02'!
from: transferingAccount to: transferredAccount withAmount: anAmount
	^self new initializeFrom: transferingAccount to: transferredAccount withAmount: anAmount.! !


!classDefinition: #TransferNetForPortfolio category: #'Portfolio-Solucion'!
Object subclass: #TransferNetForPortfolio
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetForPortfolio methodsFor: 'initialization' stamp: 'lv 11/6/2025 16:45:05'!
initializeFor: aPortfolio 
	portfolio := aPortfolio.! !

!TransferNetForPortfolio methodsFor: 'initialization' stamp: 'lv 11/6/2025 16:45:50'!
netValue
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetForPortfolio class' category: #'Portfolio-Solucion'!
TransferNetForPortfolio class
	instanceVariableNames: ''!

!TransferNetForPortfolio class methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:44:50'!
for: aPortfolio 
	^self new initializeFor: aPortfolio! !


!classDefinition: #TransferNetForReceptiveAccount category: #'Portfolio-Solucion'!
Object subclass: #TransferNetForReceptiveAccount
	instanceVariableNames: 'receptiveAccount netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetForReceptiveAccount methodsFor: 'initialization' stamp: 'lv 11/6/2025 16:29:38'!
initializeFor: aReceptiveAccount 
	receptiveAccount := aReceptiveAccount.
	netValue := 0.! !


!TransferNetForReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:34:22'!
netValue
	receptiveAccount visitTransactionsWith: self.
	^netValue.! !

!TransferNetForReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:29:50'!
visitedByDeposit: aDeposit
	! !

!TransferNetForReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:31:30'!
visitedByTransferDeposit: aTransferDeposit
	netValue := netValue + aTransferDeposit value.! !

!TransferNetForReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:31:22'!
visitedByTransferWithdraw: aTransferWithdraw
	netValue := netValue - aTransferWithdraw value.! !

!TransferNetForReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:29:21'!
visitedByWithdraw: aWithdraw
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetForReceptiveAccount class' category: #'Portfolio-Solucion'!
TransferNetForReceptiveAccount class
	instanceVariableNames: ''!

!TransferNetForReceptiveAccount class methodsFor: 'instance creation' stamp: 'lv 11/6/2025 16:20:42'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount! !
!classDefinition: #AccountSummarizerTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #AccountSummarizerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!AccountSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
test01AnAccountWithNoTransactionsDoesNotReportAny
	|account accountReport expectedReport accountSummarizer|
	account := ReceptiveAccount new.
	
	accountSummarizer := ReceptiveAccountSummarizer for: account.
	accountReport := accountSummarizer summary.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Balance = 0'.
	
	self assert: accountReport equals: expectedReport.! !

!AccountSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
test02AnAccountWithOneDepositReportsItCorrectly
	|account accountReport expectedReport deposit accountSummarizer|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	accountSummarizer := ReceptiveAccountSummarizer for: account.
	accountReport := accountSummarizer summary.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Depósito por 100.'.
	expectedReport add: 'Balance = 100'.
	self assert: accountReport equals: expectedReport.! !

!AccountSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
test03AnAccountWithOneDepositReportsItCorrectly
	|account accountReport expectedReport deposit accountSummarizer|
	account := ReceptiveAccount new.
	deposit := Withdraw register: 100 on: account.
	
	accountSummarizer := ReceptiveAccountSummarizer for: account.
	accountReport := accountSummarizer summary.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Extracción por 100.'.
	expectedReport add: 'Balance = -100'.
	self assert: accountReport equals: expectedReport.! !

!AccountSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
test04AccountsInvolvedInTransferReportsItCorrectly
	|transferingAccount transferredAccount transferingAccountReport transferredAccountReport transferingExpectedReport transferredExpectedReport transfer accountSummarizerA accountSummarizerB|	
	transferingAccount := ReceptiveAccount new.
	transferredAccount := ReceptiveAccount new.
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 50.
	
	accountSummarizerA := ReceptiveAccountSummarizer for: transferingAccount.
	accountSummarizerB := ReceptiveAccountSummarizer for: transferredAccount.	
	transferingAccountReport := accountSummarizerA summary.
	transferredAccountReport := accountSummarizerB summary.	
	transferingExpectedReport := OrderedCollection new.
	transferredExpectedReport := OrderedCollection new.
	
	"Transfering account"
	transferingExpectedReport add: 'Salida por transferencia de 50.'.
	transferingExpectedReport add: 'Balance = -50'.
	transferredExpectedReport add: 'Entrada por transferencia de 50.'.
	transferredExpectedReport add: 'Balance = 50'.			
	
	self assert: (transferingAccountReport) equals: transferingExpectedReport.
	self assert: (transferredAccountReport) equals: transferredExpectedReport.! !

!AccountSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:08:31'!
test05AnAccountWithMultipleTransactionsReportsItCorrectly
	|account accountReport expectedReport withdraw deposit anotherWithdraw anotherDeposit transfer accountSummarizer |
	account := ReceptiveAccount new.
	withdraw := Withdraw register: 100 on: account.
	deposit := Deposit register: 100 on: account.
	anotherWithdraw := Withdraw register: 50 on: account.
	anotherDeposit := Deposit register: 50 on: account.
	transfer := Transfer from: ReceptiveAccount new to: account withAmount: 50.
	
	accountSummarizer := ReceptiveAccountSummarizer for: account.
	accountReport := accountSummarizer summary.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Extracción por 100.'.
	expectedReport add: 'Depósito por 100.'.
	expectedReport add: 'Extracción por 50.'.
	expectedReport add: 'Depósito por 50.'.
	expectedReport add: 'Entrada por transferencia de 50.'.
	expectedReport add: 'Balance = 50'.
	self assert: accountReport equals: expectedReport.! !


!classDefinition: #PortfolioSummarizerTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #PortfolioSummarizerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!PortfolioSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:07:55'!
test01AnEmptyPortfolioSummaryShouldBeOnlyBalanceAndName
	|portfolio portfolioSummarizer summary portfolioName|
	portfolioName := 'Portfolio de Inge'.
	portfolio := Portfolio named: portfolioName.
	
	portfolioSummarizer := PortfolioSummarizer for: portfolio.
	
	summary := portfolioSummarizer summary.
	
	self assert: 2 equals: summary size.
	self assert: portfolioName equals: summary first.
	self assert: '	Balance = 0' equals: summary second.
	
	! !

!PortfolioSummarizerTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:07:55'!
test02PortfolioSummarizerWithOnlyAccountsWorksRecursively
	|portfolio portfolioSummarizer portfolioSummary portfolioName account accountName deposit withdraw accountSummary accountSummarizer |
	portfolioName := 'Portfolio de Inge'.
	portfolio := Portfolio named: portfolioName.
	
	accountName := 'Cuenta de Pepe y Darío'.
	account := ReceptiveAccount named: accountName.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio add: account.
		
	portfolioSummarizer := PortfolioSummarizer for: portfolio.
	portfolioSummary := portfolioSummarizer summary.
	
	accountSummarizer := ReceptiveAccountSummarizer for: account.
	accountSummary := accountSummarizer accountSummary.

	
	
	self assert: 6 equals: portfolioSummary size.
	self assert: portfolioName equals: portfolioSummary first.
	self assert: ('	', accountName) equals: portfolioSummary second.
	self assert: ('		', (accountSummary at: 1)) equals: portfolioSummary third.
	self assert: ('		', (accountSummary at: 2)) equals: (portfolioSummary at: 4).
	self assert: ('		Balance = 50') equals: (portfolioSummary at: 5).
	self assert: '	Balance = 50' equals: portfolioSummary last.
	
	! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetForPortfolioTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #TransferNetForPortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!TransferNetForPortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:45:22'!
test01PortfolioWithNoTransfersHasNoNetTransfer
	
	| portfolio transferNetForPortfolio |
	portfolio := Portfolio new.
	transferNetForPortfolio := TransferNetForPortfolio for: portfolio.
	
	self assert: (transferNetForPortfolio netValue) equals: 0.
! !


!classDefinition: #TransferNetForReceptiveAccountTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #TransferNetForReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!TransferNetForReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:21:01'!
test01NetTransferReportWithNoTransferIs0
	|account netValue transferNetVisitor |
	account := ReceptiveAccount new.
	transferNetVisitor := TransferNetForReceptiveAccount for: account.
	netValue := transferNetVisitor netValue.
	self assert: netValue equals: 0.
	! !

!TransferNetForReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:34:02'!
test02NetTransferReportWithOneTransferHasItsValue
	|transferingAccount transferredAccount transfer netValue1 transferNetVisitorAccount1 transferNetVisitorAccount2 netValue2 |
	transferingAccount := ReceptiveAccount new.
	transferredAccount := ReceptiveAccount new.
	
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 50.
	
	transferNetVisitorAccount1 := TransferNetForReceptiveAccount for: transferingAccount.
	netValue1 :=  transferNetVisitorAccount1 netValue.
	
	transferNetVisitorAccount2 := TransferNetForReceptiveAccount for: transferredAccount.
	netValue2 :=  transferNetVisitorAccount2 netValue.
	
	
	self assert: netValue1 equals: -50.
	self assert: netValue2 equals: 50.	! !

!TransferNetForReceptiveAccountTest methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:40:19'!
test03NetTransferReportWithMultipleTransfersHasCorrectValue
	|transferingAccount transferredAccount netValue1 firstTransfer secondTransfer thirdTransfer netValue2 |
	transferingAccount := ReceptiveAccount new.
	transferredAccount := ReceptiveAccount new.
	
	firstTransfer := Transfer from: transferingAccount to: transferredAccount withAmount: 50.
	secondTransfer := Transfer from: transferingAccount to: transferredAccount withAmount: 100.
	thirdTransfer := Transfer from: transferingAccount to: transferredAccount withAmount: 200.
	
		
	netValue1 := (TransferNetForReceptiveAccount for: transferingAccount) netValue.
	netValue2 := (TransferNetForReceptiveAccount for: transferredAccount) netValue.
	
	
	self assert: netValue1 equals: -350.
	self assert: netValue2 equals: 350.	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetForReceptiveAccountTest class' category: #'Portfolio-Solucion-Test'!
TransferNetForReceptiveAccountTest class
	instanceVariableNames: ''!

!TransferNetForReceptiveAccountTest class methodsFor: 'as yet unclassified' stamp: 'lv 11/6/2025 16:14:03'!
test13NetTransferReportWithNoTransferIs0: aReceptiveAccountTest
	|account actualNetTransfer|
	account := ReceptiveAccount new.
	actualNetTransfer := account transferNet.
	aReceptiveAccountTest assert: actualNetTransfer equals: 0.
	.
	^aReceptiveAccountTest.! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion-Test'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion-Test'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lv 11/4/2025 19:48:53'!
test01ATransferImpactsInEachAccountBalanceCorrectly
	|transferingAccount transferredAccount transfer deposit|
	
	transferingAccount := ReceptiveAccount new.
	deposit := Deposit register: 50 on: transferingAccount.
	transferredAccount := ReceptiveAccount new.
	
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 50.
	
	self assert: (transferredAccount balance) equals: 50.
	self assert: (transferingAccount balance) equals: 0.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lv 11/4/2025 19:54:37'!
test02ATransferRegistersBothWithdrawAndDepositInRespectiveAccounts
	|transferingAccount transferredAccount transfer deposit transferDeposit transferWithdraw |
	
	transferingAccount := ReceptiveAccount new.
	deposit := Deposit register: 50 on: transferingAccount.
	transferredAccount := ReceptiveAccount new.
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 40.
	
	transferWithdraw := transfer transferWithdraw.
	
	self assert: (transferingAccount hasRegistered: transferWithdraw).
	self assert: (transferredAccount hasRegistered: transfer transferDeposit).
	
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jec 11/2/2025 16:38:49'!
test03FromATransferWithdrawCanGoToTransferDepositAndViceversa
	|transferingAccount transferredAccount transfer deposit transferDeposit transferWithdraw|
	transferingAccount := ReceptiveAccount new.
	deposit := Deposit register: 50 on: transferingAccount.
	transferredAccount := ReceptiveAccount new.
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 40.
	
	transferDeposit := transfer transferDeposit.
	transferWithdraw := transfer transferWithdraw.
	
	self assert: transferDeposit associatedWithdraw equals: transferWithdraw.
	self assert: transferWithdraw associatedDeposit equals: transferDeposit.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lv 11/4/2025 20:11:27'!
test04LegsHaveTheSameTransfer
	|transferingAccount transferredAccount transfer deposit|
	transferingAccount := ReceptiveAccount new.
	deposit := Deposit register: 50 on: transferingAccount.
	transferredAccount := ReceptiveAccount new.

	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 40.
	
	self assert: (transfer transferWithdraw transfer) equals: (transfer transferDeposit transfer).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lv 11/4/2025 20:10:41'!
test05ATransferKnowsItsValue
	|transferingAccount transferredAccount transfer deposit|
	transferingAccount := ReceptiveAccount new.
	deposit := Deposit register: 50 on: transferingAccount.
	transferredAccount := ReceptiveAccount new.
	transfer := Transfer from: transferingAccount to: transferredAccount withAmount: 40.
	
	self assert: (transfer hasThisValue: 40).! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 56 60 63 53 112 116 104 110 108 17 124 117 112 127 17 115 112 117 124 127 52 110 117 124 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 84 104 121 39 57 58 39 57 55 57 60 39 56 56 65 57 61 65 59 63 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 93 84 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 91 111 124 39 84 104 121 39 57 55 39 56 59 65 56 55 65 60 64 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 64 58 59 104 60 58 106 58 105 39 87 115 124 110 112 117 122 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 149 27 109 17 56 55 53 56 59 57 53 57 55 53 56 55 57 17 115 124 125 104 117 52 80 107 108 104 87 104 107 52 90 115 112 116 52 58 52 56 59 80 72 85 63 17 115 124 125 104 117 52 80 107 108 104 87 104 107 52 90 115 112 116 52 58 52 56 59 80 72 85 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 55 91 56 59 65 60 61 65 58 59 53 58 59 56 63 55 64 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 56 52 119 58 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 64 60 61 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 59 65 58 59 65 56 61 53 64 59 57 58 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 73 104 105 128 90 123 108 119 122 58 64 56 83 112 117 124 127 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 91 75 75 73 104 105 128 90 123 108 119 122 78 104 116 108 79 124 117 107 121 108 107 75 118 118 121 122 53 122 123 17 61 55 62 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 60 65 57 61 65 58 57 53 64 59 57 58 58 59 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 64 64 58 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 60 65 57 62 65 56 62 53 62 55 56 61 61 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 56 52 119 58 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 84 104 121 122 89 118 125 108 121 53 122 123 17 57 55 61 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 57 56 65 55 64 65 55 61 53 63 64 57 58 63 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 119 118 121 123 109 118 115 112 118 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 60 60 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 58 56 91 56 60 65 55 64 65 55 55 53 63 55 56 64 57 56 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 57 52 119 58 52 119 118 121 123 109 118 115 112 118 52 56 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 53 122 123 17 57 64 60 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 55 61 91 56 60 65 55 56 65 55 62 53 61 61 64 63 64 58 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 52 90 118 115 124 106 112 118 117 53 122 123 17 59 62 60 55 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 55 61 91 56 60 65 55 56 65 59 63 53 61 59 64 63 57 64 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 53 122 123 17 59 61 59 62 61 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 55 91 57 55 65 55 57 65 58 57 53 62 58 60 60 63 58 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 57 62 63 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 55 91 57 56 65 59 57 65 59 58 53 63 58 59 57 56 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 56 57 53 122 123 17 57 58 56 63 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 56 91 56 61 65 57 58 65 59 59 53 62 63 62 63 59 56 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 111 104 122 123 104 56 59 53 122 123 17 57 58 56 64 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 56 64 65 56 59 53 59 62 63 59 61 63 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 57 56 65 56 61 53 57 58 57 60 60 56 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 57 57 65 59 59 53 56 63 63 60 63 64 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 57 65 55 57 65 60 62 53 64 60 63 56 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 58 57 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 57 65 55 58 65 55 63 53 61 56 56 59 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 58 57 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 57 57 65 55 55 65 58 55 53 56 56 64 55 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 61 59 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 58 55 91 56 59 65 60 60 65 58 57 53 56 59 62 58 60 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 119 118 121 123 109 118 115 112 118 58 55 118 106 123 17 56 59 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 58 55 91 56 59 65 60 60 65 60 63 53 61 57 58 56 61 59 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 58 55 118 106 123 53 122 123 17 56 59 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 58 56 91 56 60 65 56 56 65 59 55 53 62 59 61 58 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 57 52 119 58 52 119 118 121 123 109 118 115 112 118 52 56 52 106 104 109 108 105 104 122 108 63 46 54 87 118 121 123 109 118 115 112 118 53 122 123 17 56 63 55 55 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 58 56 91 56 60 65 56 57 65 58 56 53 57 60 57 64 60 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 57 52 119 58 52 119 118 121 123 109 118 115 112 118 52 56 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 53 122 123 17 56 63 55 55 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 55 61 91 56 60 65 57 64 65 58 63 53 59 57 64 60 61 63 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 61 117 118 125 53 122 123 17 59 57 55 62 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 55 61 91 56 62 65 55 64 65 60 57 53 60 55 59 63 57 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 72 106 123 124 104 115 112 129 104 107 118 61 117 118 125 53 122 123 17 59 61 58 58 63 17 52 52 52 52 52 52 52 52 52 52 17 17))!