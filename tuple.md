---
title: How to build a tuple?
author: Ivan Veselov
date: March 7, 2018
---

## Order

Concept of order is ubiquitous in mathematics and computer science, it permeates even the basic definitions. For example: what is a function from $X$ to $Y$? In set-theoretic terms it is some kind of relation between two sets (that has only one "value" for each "argument"). Then, what is a relation between two sets $X$ and $Y$? It is a subset of their Cartesian product $X \times Y$ and Cartesian product of two sets is defined as:

$$
X \times Y \equiv \{\langle x, y \rangle: x \in X, y \in Y\}
$$

In words: it is a set of all ordered pairs with the first element taken from $X$ and the second -- from $Y$.
Here, we encounter for the first time the concept of an *ordered pair* or, as it is sometimes known, *a tuple*. I'll use those terms interchangeably. Also I'll denote tuples with angle brackets: $\langle x, y \rangle$ as it is quite common in set theory books.

Note that many important mathematical objects like relations or functions are (or can be) asymmetric, e.g. a function is defined *from* some set $X$ *to* another set $Y$, those sets play different roles. The same goes about relations. Consider relation "to be parent of". Then "Clara is a parent of Jack" is not the same as "Jack is a parent of Clara". When we express relations or functions in terms of sets, we need a way to express this asymmetricity, we need ordered pairs.

## Tuples

Now, we have to ask: what is an ordered pair? How do we define one in terms of set theory?

If we have a set, say $\{1, 2\}$, it does not have order. What we mean by this is that $\{1, 2\} = \{2, 1\}$, it does not matter in which order we enumerate set elements. The set does not have any structure and is fully defined just by its elements. But now we are looking for an encoding which would represent ordered pairs as sets which would be different for pairs $\langle 1, 2 \rangle$ and $\langle 2, 1\rangle$.

This encoding $\langle x,y \rangle$ has to uniquely identify both elements $x$ and $y$ themselves and also their order. This is a succinctly described by the following property which is called _characteristic property_ of ordered pairs, since it captures their essence:

$$
\langle x,y \rangle = \langle u,v \rangle \iff x = u \land y = v
$$

In words: two encodings of ordered pairs are the same if and only if first elements are the same and second elements are the same.

To understand the property better let's start with an encoding which does not satisfy it:
$$
\langle x,y \rangle = \{x, \{y\}\}
$$

It may look as it can do the job, but in fact we can find two different pairs of sets which would be encoded to the same set, making it impossible to understand what the original pair was. Here they are[^1]:

[^1]: Note that $\emptyset \not = \{\emptyset\}$ and $\{\emptyset\} \not = \{\{\emptyset\}\}$, since they contain different elements, e.g. $\emptyset$ contains no elements and $\{\emptyset\}$ contains one element: the empty set.

$$
\begin{array}{lll}
 \langle \{\{\emptyset\}\}, \emptyset \rangle &= \{ \{\{\emptyset\}\}, \{\emptyset\} \} \\
 \langle \{\emptyset\}, \{\emptyset\} \rangle &= \{ \{\emptyset\}, \{\{\emptyset\}\} \} &= \{ \{\{\emptyset\}\}, \{\emptyset\} \}
\end{array}
$$

So our encoding does not work. A better idea which actually works is to define encoding in this way:
$$
\langle x,y \rangle = \{\{x\}, \{x, y\}\}
$$

The intuition as to how to arrive to this encoding is as follows: since we want to "visit" set elements in order, we can keep track of elements we have seen on every step. On the first step we've just seen $x$, so we have $\{x\}$ element, on the second step we've seen both $x$ and $y$, so we have $\{x, y\}$. Combining those two we get our $\{\{x\}, \{x, y\}\}$ encoding.

This definition was given by Polish mathematician Kazimierz Kuratowski in 1921.

In order to show that Kuratowski encoding is a valid one, we need to prove that it satisfies the characteristic property. It is a slightly laborious proof, so I only give you the sketch of it. In one direction it is trivial, i.e. to show that $x = u \land y = v \implies \langle x,y \rangle = \langle u,v \rangle$, we just build those sets-encodings and directly see that they have the same elements and thus are equal.

The opposite direction is more interesting, we need to show that:

$$
\langle x,y \rangle = \langle u,v \rangle \implies x = u \land y = v
$$

Substituting the definition:

$$
\{\{x\}, \{x, y\}\} = \{\{u\}, \{u, v\}\} \implies x = u \land y = v
$$

Now we'll have to examine possible combinations of elements which are supposed to be equal by the left hand side. Here, of great help would be the fact that we have $\{x, y\}$ together in one of the encoding elements, which would allow us to put more restrictions on the elements and finally derive that, necessarily, $x = u$ and $y = v$.

## Alternative encodings

So, Kuratowski encoding works well, is it the only one satisfying the property? It turns out that no, there are others. The first one, given by Norbert Wiener in 1914 was as follows:

$$
\langle x,y \rangle_{wiener} = \{\{\{x\}, \emptyset\}, \{\{y\}\}\}
$$

As you can see it's not as elegant as Kuratowski definition.

Another encoding is similar to Kuratowski, but even shorter:

$$
\langle x,y \rangle_{short} = \{x, \{x, y\}\}
$$

It has certain minor drawbacks though: the proof that it satisfies the characteristic property requires axiom of regularity. Also, encoding of $\langle 0, 1\rangle$ tuple is exactly the same as number 2, represented in set theory (numbers can also be represented in set theory using certain encodings).

The last encoding which I wanted to show is one which looks quite natural (I think) to a programmer. If we need to convert a set to a tuple, why not just add labels? Mark the first element with, say, 0 and the second with 1:

$$
\langle x,y \rangle_{prog} = \{\{0, x\}, \{1, y\}\}
$$

Here, we have to clarify what is 0 and 1. As I already mentioned above, natural numbers can also be encoded in set theory. I won't go into details about that (it would require one more post to properly cover it), but the gist is that in a classical von Neumann encoding, first natural numbers are represented as follows:

$$
\begin{array}{lll}
0 & &= \emptyset \\
1 &= \{0\} &= \{\emptyset\} \\
2 &= \{0, 1\} &= \{\emptyset, \{\emptyset\} \} \\
3 &= \{0, 1, 2\} &= \{ \emptyset,  \{\emptyset\}, \{\emptyset, \{\emptyset\} \} \} \\
\end{array}
$$

We can use those definitions of 0 and 1, spend some time proving that this encoding satisfies the characteristic property (it does) and then we can use it as well as Kuratowski's.

When we say "use the definition" I mean that we just use it to show that ordered pairs can be built in set theory (in any of the ways proposed above, it does not actually matter much which way we choose), they satisfy required properties and then we are done with it, we can start using ordered pairs without any further references to their encodings, we abstracted it away.

You may also notice that those encodings are somewhat unsatisfactory in a sense that they have some "accidental" properties, e.g. using Kuratowski encoding we have that $\{x, y\} \in \langle x, y \rangle$ or that in short encoding $\langle 0, 1 \rangle_{short} = 2$. Those strange properties do not convey any intended mathematical meaning, they are just "side effects" in a way. One can say that truly beautiful objects should only have properties required of them and nothing extra, that is why one may find those encodings unappealing. There are other ways of dealing with this situation, for example ordered pairs could be introduced axiomatically, as a separate primitive. There is a trade-off between number of axioms and primitives one has to work with and certain artificial properties. As Paul Halmos puts it:

> The mathematician's choice is between having to remember a few more
> axioms and having to forget a few accidental facts; the choice is
> pretty clearly a matter of taste.
>
> <footer>
> Paul Halmos, "Naive Set Theory"
> </footer>

## Exercise

Say we want to encode ordered triples a-la Kuratowski:
$$
\langle x, y, z \rangle = \{ \{x\}, \{x,y\}, \{x,y,z\} \}
$$

Is that a valid encoding, having the characteristic property? If not, find a counterexample.

## References

- Herbert Enderton "Elements of Set Theory"
- Paul Halmos "Naive Set Theory"
- Wikipedia: [Ordered pair](https://en.wikipedia.org/wiki/Ordered_pair)
