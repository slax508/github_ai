#!/bin/bash
## git commit script
git add .
git commit -m "Update: $(date +'%Y-%m-%d %H:%M:%S')"
git push 