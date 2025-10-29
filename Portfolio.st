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

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 22:12:37'!
addFinancialAsset: aFinancialAsset
	
	(financialAssets do: [: aSubFinancialAsset |  
								(aSubFinancialAsset isKindOf: Portfolio) ifTrue: [
									((aSubFinancialAsset hasThisFinancialAsset: aFinancialAsset) or:
										[aSubFinancialAsset = aFinancialAsset]
									 ) ifTrue: [
										^self error: self class repeatedFinancialAssetError.
										]
									]
								ifFalse: [
									(aSubFinancialAsset = aFinancialAsset) ifTrue: [
										^self error: self class repeatedFinancialAssetError ]
									]						
								]).
	financialAssets addLast: aFinancialAsset.
	transactions addAll: (aFinancialAsset transactions)
		
	
	
	 ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:42:26'!
hasNoFinancialAssets
	^financialAssets isEmpty.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:47:35'!
hasRegistered: aTransaction
	^financialAssets anySatisfy: [
		:aFinancialAsset | aFinancialAsset hasRegistered: aTransaction.
		]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:44:59'!
hasThisAmountOfFinancialAssets: aNumberOfFinancialAssets
	^ financialAssets size = aNumberOfFinancialAssets! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:45:32'!
hasThisFinancialAsset: aFinancialAsset 
	^financialAssets includes: aFinancialAsset ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:38:56'!
initialize
	financialAssets := OrderedCollection new. 
	transactions := OrderedCollection new. ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lv 10/27/2025 16:46:08'!
transactions
	^transactions copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:43:42'!
test02AddingAnAccountShouldAppearInPortfolioAccounts
	|portfolio account|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addFinancialAsset: account.
	self assert: (portfolio hasThisAmountOfFinancialAssets: 1).
	self assert: (portfolio hasThisFinancialAsset: account).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 22:01:09'!
test03APortfolioCanNotHaveRepeatedFinancialAssets
	|portfolio account anotherPortfolio|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherPortfolio := Portfolio new.
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: anotherPortfolio.
	
	self should: [ portfolio addFinancialAsset: account ] 
		raise: Error
		withExceptionDo:[: anException |  self assert: (anException messageText = Portfolio 
			repeatedFinancialAssetError )].
		
	self should: [ portfolio addFinancialAsset: anotherPortfolio ] 
		raise: Error
		withExceptionDo:[: anException |  self assert: (anException messageText = Portfolio repeatedFinancialAssetError ) ].
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:46:55'!
test04PortfolioDoesNotKnowsNotRegisteredTransactionsFromItsAccounts 
	|portfolio account deposit withdraw|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	withdraw := Withdraw for: 50 .
	
	portfolio addFinancialAsset: account.
	
	self deny: (portfolio hasRegistered: deposit). 
	self deny: (portfolio hasRegistered: withdraw). 
	 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:47:53'!
test05PortfolioKnowsRegisteredTransactionsFromOneAccount 
	|portfolio account deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio addFinancialAsset: account.
	
	self assert: (portfolio hasRegistered: deposit). 
	self assert: (portfolio hasRegistered: withdraw). 
	 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:48:18'!
test06PortfolioWithMultipleAccountsDoesNotKnowNotRegisteredTransactionsFromItsAccounts 
	|portfolio account account2 deposit withdraw|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw for: 50 .
	
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: account2.
	self deny: (portfolio hasRegistered: withdraw). 
	 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:48:37'!
test07PortfolioWithMultipleAccountsKnowsRegisteredTransactionsFromOneAccount 
	|portfolio account account2 deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account2.
	withdraw := Withdraw register: 50 on: account2.
	
	portfolio addFinancialAsset: account.
	portfolio addFinancialAsset: account2.
	
	self assert: (portfolio hasRegistered: deposit). 
	self assert: (portfolio hasRegistered: withdraw). 
	 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/27/2025 16:30:57'!
test08PortfolioWithoutAccountsHasNoTransactions
	| portfolio |
	portfolio := Portfolio new. 
	self assert: ((portfolio transactions) isEmpty)
 
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:49:03'!
test09PortfolioWithOneAccountKnowsItsTransactions
	| portfolio account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio := Portfolio new. 
	portfolio addFinancialAsset: account.
	self assert: ((portfolio transactions) size = 2).
	self assert: ((portfolio transactions) includes: deposit).
	self assert: ((portfolio transactions) includes: withdraw).
	
 
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:49:15'!
test10PortfolioWithMultipleAccountsKnowsItsTransactions
	| portfolio account account2 deposit withdraw deposit2|
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 50 on: account.
	
	portfolio := Portfolio new. 
	portfolio addFinancialAsset: account.
	self assert: ((portfolio transactions) size = 3).
	self assert: ((portfolio transactions) includes: deposit).
	self assert: ((portfolio transactions) includes: withdraw).
	self assert: ((portfolio transactions) includes: deposit2).
	
 
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 21:49:41'!
test11AddingAPortfolioShouldAppearInPortfolio
	|portfolio portfolio2|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio addFinancialAsset: portfolio2.
	self assert: (portfolio hasThisAmountOfFinancialAssets: 1).
	self assert: (portfolio hasThisFinancialAsset: portfolio2).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lv 10/28/2025 22:01:25'!
test12CanNotAddAnAccountAlreadyInSubPortfolio
	|portfolio account anotherPortfolio|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherPortfolio := Portfolio new.
	
	portfolio addFinancialAsset: anotherPortfolio.
	anotherPortfolio addFinancialAsset: account.
	
	self should: [ portfolio addFinancialAsset: account ] 
		raise: Error
		withExceptionDo:[: anException |  anException messageText = Portfolio repeatedFinancialAssetError ].
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
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 56 60 63 53 112 116 104 110 108 17 124 117 112 127 17 115 112 117 124 127 52 110 117 124 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 84 104 121 39 57 58 39 57 55 57 60 39 56 56 65 57 61 65 59 63 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 57 61 39 124 124 112 107 65 39 58 62 105 104 64 109 61 64 52 105 62 56 108 52 59 106 106 60 52 63 107 62 105 52 108 56 109 58 63 64 64 64 63 107 56 107 39 84 104 121 39 57 58 39 57 55 57 60 17 93 84 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 91 111 124 39 84 104 121 39 57 55 39 56 59 65 56 55 65 60 64 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 64 58 59 104 60 58 106 58 105 39 87 115 124 110 112 117 122 65 39 57 55 57 60 55 58 57 55 56 63 56 55 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 83 112 125 108 91 128 119 112 117 110 52 74 118 110 93 84 52 72 117 110 108 115 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 149 26 65 17 56 55 53 56 59 57 53 56 64 53 60 63 17 115 124 125 104 117 52 80 107 108 104 87 104 107 52 90 115 112 116 52 58 52 56 59 80 72 85 63 17 115 124 125 104 117 52 80 107 108 104 87 104 107 52 90 115 112 116 52 58 52 56 59 80 72 85 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 55 91 56 59 65 60 61 65 58 59 53 58 59 56 63 55 64 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 56 52 119 58 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 64 60 61 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 59 65 58 59 65 56 61 53 64 59 57 58 56 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 73 104 105 128 90 123 108 119 122 58 64 56 83 112 117 124 127 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 91 75 75 73 104 105 128 90 123 108 119 122 78 104 116 108 79 124 117 107 121 108 107 75 118 118 121 122 53 122 123 17 61 55 62 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 60 65 57 61 65 58 57 53 64 59 57 58 58 59 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 123 119 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 64 64 58 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 60 65 57 62 65 56 62 53 62 55 56 61 61 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 108 113 108 121 106 112 106 112 118 52 56 52 119 58 52 116 104 121 122 52 121 118 125 108 121 52 106 104 109 108 105 104 122 108 63 54 84 104 121 122 89 118 125 108 121 53 122 123 17 57 55 61 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 57 56 65 55 64 65 55 61 53 63 64 57 58 63 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 108 117 123 121 108 110 104 105 115 108 122 54 119 118 121 123 109 118 115 112 118 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 60 60 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 63 91 57 55 65 56 64 65 57 60 53 61 62 55 60 59 58 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 72 106 123 124 104 115 112 129 104 107 118 53 122 123 17 57 55 64 62 55 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 55 91 57 55 65 55 57 65 58 57 53 62 58 60 60 63 58 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 57 57 62 63 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 55 91 57 56 65 59 57 65 59 58 53 63 58 59 57 56 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 56 57 53 122 123 17 57 58 56 63 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 56 91 56 61 65 57 58 65 59 59 53 62 63 62 63 59 56 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 111 104 122 123 104 56 59 53 122 123 17 57 58 56 64 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 56 64 65 56 59 53 59 62 63 59 61 63 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 121 108 122 118 115 122 54 119 104 121 106 112 104 115 108 122 39 125 112 108 113 118 122 46 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 57 56 65 56 61 53 57 58 57 60 60 56 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 46 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 56 65 57 57 65 59 59 53 56 63 63 60 63 64 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 56 63 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 57 65 55 57 65 60 62 53 64 60 63 56 63 60 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 58 57 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 57 65 55 58 65 55 63 53 61 56 56 59 63 62 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 112 117 110 108 56 54 112 117 110 108 56 54 123 119 52 84 104 121 122 89 118 125 108 121 53 122 123 17 58 57 59 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 57 57 65 55 55 65 58 55 53 56 56 64 55 62 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 61 59 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 63 91 57 57 65 56 58 65 55 59 53 64 58 63 55 57 61 52 55 58 65 55 55 17 54 111 118 116 108 54 115 124 125 104 117 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 57 63 118 106 123 53 122 123 17 56 58 62 63 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!