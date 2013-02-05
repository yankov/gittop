
Gittop is a simple tool to generate contributors' leaderboards for any git repository. It uses standard `git` utility to get log statistics and then stores data either in Redis or as JS array in a file. Here are examples of such leaderboards generated for some popular open source projects [gitboards](http://artemyankov.com/gitboards/).  

Also, example of how this generated data can be used to display leaderboards on a page can be found in leaderboards_example.html

Gittop generates four types of leaderboards: "all time", "monthly", "weekly" and "daily". Monthly and weekly leaderboards show data for the current month and current week accordingly.
They are reset in the beginning of each period.

Usage
=====
Generate leaderboards for repository in /ruby/myproj and store them in a JS file  

`gittop /ruby/myproj -f myproj_leaderboards.js`

Same thing but save leaderboards to Redis  

`gittop /ruby/myproj -r localhost:6379`


Requirements
============
* Ruby 1.9.x  
* Git  


