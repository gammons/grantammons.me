---
title: Bitcoin, Litecoin, Dogecoin - Exploring the block chain
date: 2014-01-17 14:26 UTC
tags: bitcoin
cover: bitcoin.jpg
page: blog
---

Ever go to a site like <http://blockchain.info> and just wonder what all those numbers mean?  Well, wonder no more!  This guide will have you exploring the block chain like a pro.  This guide is separated into two main sections -- a brief, high level overview of transactions and blocks, followed by a deep inspection of a single block, and the transactions within it.
<!--more-->

## Cryptocurrency 101

Before understanding the charts and what they are telling us, it's important to have a firm grounding in the underpinnings of how the bitcoin protocol works.

### Transactions

The first thing to understand about bitcoins is that **they do not exist**, neither in digital or real form. The *only* thing that exists is the list of transactions.

A *transaction* is simply a record of someone exchanging bitcoin with someone else.

The fundamental components of a transaction are as follows:

* **Input**:  The address the bitcoins are being sent **from**.
* **Amount**:  The total amount of coin being sent.  Can be fractions of a coin a well.  Remember, the coins do not exist!  Only the transactions!
* **Output**:  The address the bitcoins are being sent **to**.

### Blocks

Conceptually a **block** is the method in which data is permanently recorded in the networks.  It is a record of some or all transactions that have not been recorded in any other blocks.

Blocks also contain a pointer to the previous block.  So, in computer science speak, a block behaves much like a [linked list](http://en.wikipedia.org/wiki/Linked_list).  This list is called the **block chain**.

All bitcoin clients are part of a peer-to-peer network, so everyone is talking with everyone else.  When a transaction is performed, it is broadcast out to all the clients.  A transaction is said to be *confirmed* when the transaction is part of the longest block, and 5 blocks follow that block.

*Miners* are responsible for recording and confirming transactions into blocks.

### How mining works

Miners pay attention to the current transactions coming in, and perform a computationally difficult hashing algorithm against the current transaction data created since the last block was created.

If a miner is able to solve the hashing algorithm, they effectively "seal off" the block, and a new block is created to store transactions.  It is very easy for other clients to validate the work done by the miner.  The hashing algorithm is basically like a contest.  Each time the miner tries to solve, it is like rolling dice.  Therefore, it behooves a miner to have a lot of computing horsepower, so they can better their chances, by rolling the dice more often.

When a block is "discovered", the discoverer may award themselves a certain number of coins.  For dogecoin, that number is currently 500,000.  For bitcoin, it is 25.  This number gets halved over time.  Eventually, the reward will be 12.5, 6.25, and so on, until there is no more bitcoins awarded for mining.

The miner also collects any fees involved with a transaction.  Fees on transactions are a further incentive to mine coins.  This will further incentivize miners to continue mining, even after all bitcoins are found.

## Inspecting a block

If we look at the [latest dogecoin block](http://dogechain.info/block/efd86f0f13d4e28e4153559dcd6baec8db69b92e5a0bbb5be3c880c8d10859a7) (at time of writing), we see a lot of different information.

![block](/images/Screen_Shot_2014-01-05_at_11_46_14_AM_q6xg48.png)

So what are each of these fields?

####Hash:
The unique id of this block.

####Previous block:
The unique id of the previous block in the chain.  This is what links blocks into a chain.

####Height:
This is simply the length of the chain, or the number of blocks in the chain.

####Version:
For dogecoin, it's always 1.  For bitcoin, it's 2.  This specifies the version of the coin protocol.

####Transaction Merkle Root:
This is the SHA-256d hash based on all of the transactions in the block.  It is updated when a transaction is accepted into the block.  This hash of all hashes is known as the [merkle root](http://bitcoin.stackexchange.com/questions/10479/what-is-the-merkle-root).
####Time:
The timestamp of when this block was found.

####Difficulty:
The difficulty of finding a new block.  The difficulty is a human-friendly way of expressing how hard it is for a computer to do the proof-of-work algorithm, when mining.  The bitcoin protocol controls the level of difficulty very tightly.  As more miners join, and as computer hardware gets more adept at mining, the difficulty gets increased by the protocol.

The difficulty is adjusted to keep the number of blocks found over time at a steady pace.

The graph below shows the difficulty of mining bitcoin over the last 60 days.
![](/images/Screen_Shot_2014-01-08_at_8_15_57_PM_wlrio9.png)

For bitcoin, litecoin and dogecoin, the difficulty gets re-calculated every 2016 blocks.

####Nonce:
This is used when mining.  When mining, the nonce gets inremented so the next guess is completely random.  Part of the block header.  [See more about nonce here](http://en.wikipedia.org/wiki/Cryptographic_nonce).

####Transactions:
The number of transactions in this block.

####Value Out:
This is the total value of all the transactions in the block.

####Average coin age:
This is the average age of the transaction inputs, for the block.  The average age of the coins in this block is 9.1 days, which means on average, the coins transacted in this block were mined about 9 days ago.

####Bits:
This is the packed representation of the target the miners are trying to reach.

####Coin-days destroyed

"Coin-days destroyed" attempts to be a measurement of the true economic activity in the system[^1].  It can't be measured simply by transaction volume, as the same user could be sending coins back and forth to herself over and over, thus artificially inflating the number.

The idea is to multiply the amount of each transaction by the number of days since those coins were last spent.  This gives you the idea of coin-days.  These coin-days are destroyed when a new transaction occurs with the coins in question.

[^1]: http://bitcoin.stackexchange.com/questions/845/what-are-bitcoin-days-destroyed

## Inspecting a transaction

![transaction](/images/Screen_Shot_2014-01-08_at_8_15_57_PM_wlrio9-1.png)

### Overview

Above is a picture of a transaction within a block.  This particulart transaction showing someone sending 419 coins from address `DPrrn` to address `D69b`.

Now, `DPrrn` had a previous transaction of 430 coins earlier, and that is serving as the **input** to this transaction.

The **outputs** are that 419 coins were transacted to `D69b`, 1 coin was the transaction fee, and 10 coins were returned back to the sender.

"But wait", I hear you say, "Those 10 coins were sent to some other address!"

This is correct.  The other address, `DTFj`, is actually what is known as a [change address](https://en.bitcoin.it/wiki/Change), which is generated by your client.  All of this is an attempt at keeping transactions somewhat anonymous.[^2]  It also obfuscates the transaction as well.  In the above example, it's impossible to determine if 419 was transacted and 10 is the change, or vice versa.

[^2]: http://bitcoin.stackexchange.com/questions/1629/why-does-bitcoin-send-the-change-to-a-different-address

### Attributes of a transaction

#### Hash
The unique id of the transaction.

#### Timestamp
The timestamp of when the transaction occurred.

#### Number of inputs
The number of transactions that make up the from part of the transaction.

Consider the below example, where Alice wants to send 50 dogecoin to Bob.  She has been sent 25 doge and 35 doge before, in previous transactions.  Those previous transactions will serve as inputs to sending bob 50 dogecoins.

      Alice sending 50 dogecoin to Bob

      Inputs:    -------->  Outputs:
      25 doge               50 doge to Bob's address
      35 doge               10 doge to Alice's change address


#### Total in
The total number of coins that make up the input of the transaction.

#### Number of outputs
The number of wallets the output was sent to.  If the transaction requires making change, then one of the wallets is the change wallet back to the original sender.

#### Total out:
The total number of coins that make up the output of the transaction, minus any fees.

#### Fee:
If the transaction generated a fee, that would be listed here.

Fees go to the miner who validated the block that this transaction was part of.  This further incentivizes miners to mine, and will continue to do so, even when mining yields no new coins.  Additionally it discourages transactions from yielding very small fractions of coins, which can litter a wallet.

## Conclusion

Well, hopefully you have gained a more thorough understanding of what you're seeing when you look at the block chain!

### References

* <http://blockchain.info>
* <http://dogechain.info>
* <http://bitcoinfees.com>
* <http://www.michaelnielsen.org/ddi/how-the-bitcoin-protocol-actually-works>
* [Khan academy on bitcoin](https://www.khanacademy.org/economics-finance-domain/core-finance/money-and-banking/bitcoin/v/bitcoin---transaction-records)
* http://www.coindesk.com/information/how-bitcoin-mining-works/
* [bitcoin protocol specification](https://en.bitcoin.it/wiki/Protocol_specification)

