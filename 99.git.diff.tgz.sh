#!/bin/bash

tar zcvf ../git_diff.tar.gz `git diff --name-only | xargs`
