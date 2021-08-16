# Graph Algorithms

![Build status](https://github.com/pharo-ai/edit-distances/actions/workflows/ci.yml/badge.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)

## Description

These are the start of the migration of graphs algorithms that are defined in Moose.
The nodes in the graph can be anything, a character, an string, an integer or a complex object.

## Migrated graph algorithms

  - Tarjan’s Algorithm: Strongly Connected Components

## How to install it

[//]: # (pi)
```smalltalk
Metacello new
	repository: 'github://pharo-ai/graph-algorithms/src';
	baseline: 'AIGraphAlgorithms';
	load
```

## How to depend on it

If you want to add this repo to your Metacello Baselines or Configurations, copy and paste the following expression:
```smalltalk
spec
	baseline: 'AIEditDistances' 
	with: [ spec repository: 'github://pharo-ai/graph-algorithms/src' ]
```

## How to use it

WIP
