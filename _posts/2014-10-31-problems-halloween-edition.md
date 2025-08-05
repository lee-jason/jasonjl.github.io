---
layout: post
title:  "Problems: Halloween Edition"
date:   2014-10-31 08:00:00
description: "You're a kid, and tonight's the greatest night a kid could have next to Christmas. Halloween night is coming soon and you're prepping your bags for the trick or treating. The problem is, is that your parents are tired and are only willing to walk a certain number of feet before they call it a night."
media: "halloween_graph.png"
categories: algorithms, graph-theory, optimization, traveling-salesman, programming, halloween
comments: true
---

# Problems: Halloween Edition

**Problem:** You're a kid, and tonight's the greatest night a kid could have next to Christmas. Halloween night is coming soon and you're prepping your bags for the trick or treating. The problem is, is that your parents are tired and are only willing to walk a certain number of feet before they call it a night. Given a map detailing the amount of feet between each house and the amount of candy given per house, how do you maximize the amount of candy gained before having to return back home?

Of course, graphing optimization problems. Isn't this what every kid is thinking on Halloween? I know it was definitely keeping me up last night, even though I don't trick or treat anymore. This is slightly different from the [traveling salesman problem](http://en.wikipedia.org/wiki/Travelling_salesman_problem) in that each location now has a weight, and now the salesman doesn't need to travel to every location. I guess its a variant of the traveling salesman problem if the salesman's car had n amount of miles of fuel and the each location had variable amounts of money to be made and he needs to return home by the end of the trip. In this problem, we can assume that the graph is undirected and your house is accessible through a loop. To save some computation time, this algorithm does not cross over visited nodes. Paths will not have intersections.

## Proposed Solution

So after starting to really think about this problem at 6am and it now being 11am, the problem is not as easy as I thought. I've given it some thought and this is what I propose. In order to get the true most optimal path a ton of paths have to be evaluated. A backtrack algorithm would be used to trace down paths starting from the house node going all the way down until it reaches the house node again. This algorithm would be pretty terrible due to there being O(!N) paths but since backtracking is being used we can save ourselves from checking dead-end paths sooner.

## A Solution

```java
    Class Node{
        //Node class contains...
        int candyValue
        NodesNPaths[] connectingNodes;
        int totalCandyValue
        int totalSteps
        Node prevNode
        boolean visited
    }

    //bestPath modifies rootNode to have history of 
    Node bestPath(Node rootNode, Node currNode, int pathLength, Node prevNode, int stepQuota, boolean initial){
        //route is a failure when totalsteps is over the stepquota,
        //when the node has already been visited AND its not the root node
        //its fine to go back to the root node to update its values if its under the step quota and its already been visited.
        if(currNode.totalSteps > stepQuota || currNode.visited && currNode != rootNode){
            return null;
        }

        //replace tally of path of most candy
        currNode.totalCandyValue = currNode.candyValue + prevNode.totalCandyValue;
        currNode.totalSteps += pathLength + prevNode.totalSteps;
        currNode.prevNode = prevNode;
        currNode.visited = true;

        for(Node connectingNode : currNode.connectingNodes){
            Node nextNode = bestPath(rootNode, connectingNode.node, connectingNode.pathLength, Node.currNode, stepQuota, false);
            if(nextNode == null){
                //reset node status, so next branch can access this point again
                currNode.visited = false;
                return null
            }
        }
    }
```

The algorithm above will update the rootNode with the history where we can traverse through and eventually find the best path. So in plain english here's what's going on. The method above will recursively dig into the graph in a depth first search. the function will break when it discovers that the path its on exceeds the amount of allotted steps or if the node has been visited and is NOT the root node. This not distinction exists because revisiting the home node is necessary in order to complete the looping path and update the home node's history and current tally. Each traversed node keeps track of the previous node that it came from as well as a running tally of how many steps it took to get there as well as the amount of candy gained. The function is then called recursively on each of the visited node's connected paths and the cycle repeats until no more paths exist. I'm not a mathmagician but this algorithm should have a worst case scenario of O(!N + N) where N is number of nodes.

I thought of another addition that allows a path to end earlier before having to dig several nodes deep to reach the step limit. There could be a pre-processing stage where we figure out the shortest path to home from each node. At each node we check to see if our available steps is more than the steps required to go back home. If it is, then the path is a bust and the algorithm can move on to the next path. This time-saving measure over the course of !N calculations could potentially reduce a lot of number crunching even though the algorithm is would still be of factorial time.

This algorithm is pretty terrible and I'm surprised to see that I wasn't able to find much information on a scenario similar to this. Either I'm using the wrong search terms or people just never were curious about finding optimal paths when both the nodes and edges have weights which I highly doubt.

I would absolutely love to read if anybody else has any insight into these kinds of problems.