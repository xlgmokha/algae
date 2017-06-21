# Manufacturing parts analysis.

Consider you're working as a manufacturing company, and you have a blueprint for some item you wish to sell. 
This item can be built by combining a set of parts, of which you have a finite amount.

Now, assume you have a set of items and their blueprints, all using a varying -and overlapping- subset of parts from
your parts list.

Treat the parts list as a set of atomic items and you have a variable amount of each item. These items also have a cost associated with them:

 part   | amount | price 
 ------ | ------ | ----- 
 a | 10 | 5.99
b | 5 | 9.99
c | 50 | 2.99
. | |
. | |
. | |
n | |

Consider the blueprint as a compound tuple of the items in use:

| item  | component 1 | component 2 | parts\_price | sales\_price |
| ----- | ----------- | ----------- | ------------ | ------------ |
X | 1(b) | 5(c) | 24.94 | 35.00
Y | 2(a) | 3(c) | 20.95 | 30.00
Z | 5(b) | 2(a) | 61.93 | 75.00


1. How would you determine the optimal set of items to sell to maximize profits?

1. Consider the case where selling the parts straight would be more profitable than selling the manufactured items

