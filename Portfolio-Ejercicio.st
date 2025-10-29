!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'transactions financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'lv 10/27/2025 16:46:08'!
transactions
	^transactions copy.! !


!Portfolio methodsFor: 'adding' stamp: 'jec 10/29/2025 16:36:31'!
addFinancialAsset: aFinancialAsset
	(self = aFinancialAsset) ifTrue: [self error: self class addingItselfError].
	(self anySubFinancialAssetsHasOrIs: aFinancialAsset) ifTrue: [self error: self class repeatedFinancialAssetError]
	ifFalse:[
		financialAssets add: aFinancialAsset.
		transactions addAll: aFinancialAsset transactions.
		].
	
	
	
	
		
	
	
	 ! !


!Portfolio methodsFor: 'asserts' stamp: 'jec 10/29/2025 15:42:08'!
anySubFinancialAssetsHasOrIs: aFinancialAsset
	^(financialAssets anySatisfy: [:anotherFinancialAsset | anotherFinancialAsset hasOrIsThisFinancialAsset: aFinancialAsset])! !

!Portfolio methodsFor: 'asserts' stamp: 'lv 10/28/2025 21:42:26'!
hasNoFinancialAssets
	^financialAssets isEmpty.! !

!Portfolio methodsFor: 'asserts' stamp: 'jec 10/29/2025 15:42:08'!
hasOrIsThisFinancialAsset: aFinancialAsset 
	^(aFinancialAsset = self) or: [
		self anySubFinancialAssetsHasOrIs: aFinancialAsset.
		]! !

!Portfolio methodsFor: 'asserts' stamp: 'lv 10/28/2025 21:47:35'!
hasRegistered: aTransaction
	^financialAssets anySatisfy: [
		:aFinancialAsset | aFinancialAsset hasRegistered: aTransaction.
		]! !

!Portfolio methodsFor: 'asserts' stamp: 'lv 10/28/2025 21:44:59'!
hasThisAmountOfFinancialAssets: aNumberOfFinancialAssets
	^ financialAssets size = aNumberOfFinancialAssets! !


!Portfolio methodsFor: 'initialize' stamp: 'lv 10/28/2025 21:38:56'!
initialize
	financialAssets := OrderedCollection new. 
	transactions := OrderedCollection new. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 14:58:43'!
addingItselfError
	^'Can not add portfolio to itself'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lv 10/27/2025 16:25:18'!
repeatedAccountError
	^'This account is already in portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 22:00:22'!
repeatedFinancialAssetError
	^'This financial asset is already in portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:32:50'!
repeatedPortfolioError
	^'This portfolio is already in portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions balanceActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'lv 10/24/2025 21:42:11'!
initialize

	transactions := OrderedCollection new.
	balanceActual:= 0.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'lv 10/24/2025 21:43:59'!
register: aTransaction

	transactions add: aTransaction.
	balanceActual := balanceActual + aTransaction valueForBalance.  
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'lv 10/24/2025 21:41:48'!
balance
	^balanceActual! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:27:22'!
hasOrIsThisFinancialAsset: aFinancialAsset
	^self = aFinancialAsset.! !


!classDefinition: #Transaction category: #'Portfolio-Ejercicio'!
Object subclass: #Transaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transaction methodsFor: 'value' stamp: 'lv 10/24/2025 21:35:51'!
initializeFor: aValue
	value := aValue ! !

!Transaction methodsFor: 'value' stamp: 'lv 10/24/2025 21:34:15'!
value 
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transaction class' category: #'Portfolio-Ejercicio'!
Transaction class
	instanceVariableNames: ''!

!Transaction class methodsFor: 'instance creation' stamp: 'lv 10/24/2025 21:36:26'!
for: aValue

	^ self new initializeFor: aValue ! !

!Transaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
Transaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'lv 10/24/2025 21:31:44'!
valueForBalance
	^ value.! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
Transaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'lv 10/24/2025 21:31:14'!
valueForBalance
	^ value * (-1).! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:42:06'!
test01PortfolioHasNoFinancialAssetsWhenCreated
	self assert: (Portfolio new hasNoFinancialAssets).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:26:32'!
test02AddingAnFinancialAssetShouldAddItInPortfolio
	|portfolio account anotherPortfolio|
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherPortfolio.
	self assert: (portfolio hasThisAmountOfFinancialAssets: 2).
	self assert: (portfolio hasOrIsThisFinancialAsset: account).
	self assert: (portfolio hasOrIsThisFinancialAsset: anotherPortfolio).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:43:43'!
test03APortfolioCanNotHaveRepeatedFinancialAssetsInFirstLevel
	|portfolio account anotherPortfolio|
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherPortfolio.
	
	self should: [portfolio addFinancialAsset: account] raise: Error withMessageText: Portfolio repeatedFinancialAssetError.
	self should: [portfolio addFinancialAsset: anotherPortfolio] raise: Error withMessageText: Portfolio repeatedFinancialAssetError.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:44:20'!
test04APortfolioCanNotAddItself
	|portfolio|
	portfolio := Portfolio new.
	self should: [portfolio addFinancialAsset: portfolio] raise: Error withMessageText: Portfolio addingItselfError.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:44:25'!
test05CanNotAddAccountAlreadyInSubPortfolio
	|portfolio anotherPortfolio account|
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	anotherPortfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherPortfolio.
	self should: [portfolio addFinancialAsset: account] raise: Error withMessageText: Portfolio repeatedFinancialAssetError.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 15:45:27'!
test06CanNotAddAccountAlreadyInSubSubPortfolio
	|firstPortfolio secondPortfolio thirdPortfolio account|
	firstPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	thirdPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	thirdPortfolio addFinancialAsset: account.
	secondPortfolio addFinancialAsset: thirdPortfolio.
	firstPortfolio addFinancialAsset: secondPortfolio.
	
	self should: [firstPortfolio addFinancialAsset: account] raise: Error withMessageText: Portfolio repeatedFinancialAssetError.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:24:58'!
test07PortfolioKnowsRegisteredTransactionsFromItsAccounts
	|firstPortfolio account deposit withdraw|
	firstPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	firstPortfolio addFinancialAsset: account.
	
	self assert: (firstPortfolio hasRegistered: deposit).
	self assert: (firstPortfolio hasRegistered: withdraw)	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:27:10'!
test08PortfolioDoesNotKnowNotRegisteredTransactions
	|firstPortfolio account deposit withdraw|
	firstPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw for: 50.
	
	firstPortfolio addFinancialAsset: account.
	
	self assert: (firstPortfolio hasRegistered: deposit).
	self deny: (firstPortfolio hasRegistered: withdraw)	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:30:38'!
test09PortfolioKnowsRegisteredTransactionsFromItsPortfolios
	|firstPortfolio secondPortfolio account deposit withdraw|
	firstPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 100 on: account.
	
	secondPortfolio addFinancialAsset: account.
	firstPortfolio addFinancialAsset: secondPortfolio.
	
	self assert: (firstPortfolio hasRegistered: deposit).
	self assert: (firstPortfolio hasRegistered: withdraw)	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:33:02'!
test10AnEmptyHasNoTransactions
	self assert: (Portfolio new transactions) isEmpty.
 	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:35:18'!
test11PortfolioWithOneAccountKnowsItsTransactions
	|portfolio account deposit withdraw|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account. 	
	
	portfolio := Portfolio new.
	portfolio addFinancialAsset: account.
	
	self assert: ((portfolio transactions) size = 2).
	self assert: ((portfolio transactions) includes: deposit).
	self assert: ((portfolio transactions) includes: withdraw)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:40:23'!
test12PortfolioWithMultipleAccountsKnowsItsTransactions
	|portfolio account deposit withdraw anotherAccount anotherDeposit anotherWithdraw|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account. 	
	anotherAccount := ReceptiveAccount new.
	anotherDeposit := Deposit register: 50 on: account.
	anotherWithdraw := Withdraw register: 25 on: account.	
	portfolio := Portfolio new.
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherAccount.
	self assert: ((portfolio transactions) size = 4).
	self assert: ((portfolio transactions) includes: deposit).
	self assert: ((portfolio transactions) includes: withdraw).
	self assert: ((portfolio transactions) includes: anotherDeposit).
	self assert: ((portfolio transactions) includes: anotherWithdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'jec 10/29/2025 16:42:08'!
test13PortfolioWithPortfoliosKnowsItsTransactions
	|portfolio account deposit withdraw anotherPortfolio|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account. 	
	anotherPortfolio := Portfolio new.
	portfolio := Portfolio new.
	anotherPortfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherPortfolio.
	self assert: ((portfolio transactions) size = 2).
	self assert: ((portfolio transactions) includes: deposit).
	self assert: ((portfolio transactions) includes: withdraw).
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 113 124 104 117 108 115 112 104 122 106 104 105 121 108 121 104 54 92 73 72 54 57 74 57 55 57 60 54 112 117 110 108 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 113 124 104 117 108 115 112 104 122 106 104 105 121 108 121 104 54 92 73 72 54 57 74 57 55 57 60 54 112 117 110 108 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 149 19 208 17 56 55 53 56 59 57 53 56 57 53 57 55 56 17 108 115 112 104 122 52 119 106 17 108 115 112 104 122 52 119 106 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 64 91 56 59 65 58 58 65 60 63 53 62 57 57 62 64 63 52 55 58 65 55 55 17 54 111 118 116 108 54 113 124 104 117 108 115 112 104 122 106 104 105 121 108 121 104 54 92 73 72 54 57 74 57 55 57 60 54 112 117 110 108 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 87 118 121 123 109 118 115 112 118 53 122 123 17 57 58 62 59 59 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 64 91 56 61 65 59 60 65 55 62 53 55 59 57 57 62 62 52 55 58 65 55 55 17 54 111 118 116 108 54 113 124 104 117 108 115 112 104 122 106 104 105 121 108 121 104 54 92 73 72 54 57 74 57 55 57 60 54 112 117 110 108 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 56 59 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 17))!