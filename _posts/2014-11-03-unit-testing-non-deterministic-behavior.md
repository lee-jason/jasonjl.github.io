---
layout: post
title:  "Unit Testing Random Behavior With Mock Objects"
date:   2014-11-03 08:00:00
description: "What happens when you're trying to write some unit tests and suddenly you need to test a method with non-deterministic properties. In other words how do you test a method whose expected behavior is random behavior? The answer is with mock objects."
categories: java, testing, mocking, unit-tests, junit, programming
comments: true
---

# Unit Testing Random Behavior With Mock Objects

What happens when you're trying to write some unit tests and suddenly you need to test a method with non-deterministic properties. In other words how do you test a method whose expected behavior is random behavior? The answer is with mock objects. I've seen a bunch of suggestions to use a mock randomizer but I haven't seen anyone actually explain it further than that. Hopefully this will help someone out

So when writing unit tests for methods, we need to execute these methods with test data or mock objects. These mock objects either come in through the constructor during the setup or as a method parameter when calling the method. When people say to make your random object a dependency, they mean that your random object should be an external object that is passed into the constructor or method of whatever you need to test. Since the object is being passed into the constructor, you can pass in a real non-deterministic random number generator, or a phony completely predictable deterministic 'random number generator'.

In the following example I'm going to be making and testing a simple program that simply gets me a random number

```java
import java.util.Random;

public class PrintRandomNumber {
    private Random random;
    
    public PrintRandomNumber(Random random) {
        this.random = random;
    }
    
    public int getRandomInt() {
        return random.nextInt();
    }
}
```

notice how the `PrintRandomNumber` constructor accepts a `Random random` parameter. This means that we can pass in any class that comes from the class Random. Usually we want to use java.util.Random during real code execution, but when testing we'll want to mock our own random object with deterministic results. Here's an example deterministic random class.

```java
public class DeterministicRandom extends Random{
    int sequentialNum = 0;

    public DeterministicRandom(){
        super();
    }

    public int nextInt(){
        return sequentialNum++;
    }
}
```

The class `DeterministicRandom` extends the `Random` class with an overridden `nextInt()` method. This means that `DeterministicRandom` can be passed into the `PrintRandomNumber` constructor where by calling `nextInt()` will then give completely deterministic results. The following class is a test case to show just that.

```java
public class DeterministicRandomTest{
    PrintRandomNumber printRandomNumber

    @Before
    public void setUp() throws Exception{
        DeterministicRandom deterministicRandom = new DeterministicRandom();
        printRandomNumber = new PrintRandomNumber(deterministicRandom);
    }

    @Test
    public void testGetRandomInt(){
        assertEquals(0, printRandomNumber.getRandomInt());
        assertEquals(1, printRandomNumber.getRandomInt());
        assertEquals(2, printRandomNumber.getRandomInt());
        assertEquals(3, printRandomNumber.getRandomInt());
        assertEquals(4, printRandomNumber.getRandomInt());
        assertEquals(5, printRandomNumber.getRandomInt());
    }
}

```

Running the JUnit test case above, I'm creating a new `DeterministicRandom` that I feed into `PrintRandomNumber`'s constructor, this way my random will always start at 0 for every test case. In the test case `testGetRandomInt()` I'm testing to see whether `PrintRandomNumber.getRandomInt()` is working as I'm expecting, and I'm expecting sequential numbers starting at zero. The test should pass since I fed `PrintRandomNumber` a completely deterministic 'random number generator' in the setUp, `printRandomNumber = new PrintRandomNumber(deterministicRandom)`. This allows a method that's dependent on a random number generator to have consistent results every time you test it.

So there you have it, that's how you mock a Random class. Having to pass in your random number generator class into the constructor of the object that uses it may sound counter-intuitive (I know it did to me) but I guess it makes sense. It allows your class to be more modular and definitely more testable. After all, we're not trying to test if the random number generator is working, but rather whether your class is reacting appropriately to the numbers that come from the random number generator.

Happy testing.