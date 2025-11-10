# Graph Algorithms

[![Build status](https://github.com/pharo-ai/linear-models/workflows/CI/badge.svg)](https://github.com/pharo-ai/graph-algorithms/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/graph-algorithms/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/graph-algorithms?branch=master)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Pharo version](https://img.shields.io/badge/Pharo-9-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)
[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)

## Description
This library contains several graphs algorithms. The nodes in the graph can be any kind of object: a Character, a String, an Integer or a complex object.

For the documentation, please refer to
- the pharo-ai wiki: https://github.com/pharo-ai/wiki/blob/master/wiki/Graphs/Graph-Algorithms.md and
- our graphs booklet [Booklet-PharoGraphs](https://github.com/SquareBracketAssociates/Booklet-PharoGraphs).

## How to install it

```smalltalk
EpMonitor disableDuring: [
    Metacello new
        repository: 'github://pharo-ai/graph-algorithms';
        baseline: 'AIGraphAlgorithms';
        load ]
```

## How to depend on it

If you want to add this repo to your Metacello Baselines or Configurations, copy and paste the following expression:
```smalltalk
spec
    baseline: 'AIGraphAlgorithms' 
    with: [ spec repository: 'github://pharo-ai/graph-algorithms' ]
```
