Small shell script (together with a Makefile to install it) which processes `lightning-cli listfunds` and outputs the funds in a nicer and cleaner way

run `sudo make install` and then `listfunds`.

The result will look like this:

```
user@computer: listfunds
223887 satoshi available to fund channels
64523 satoshi owned in channels
7438925 satoshi total channel capacity
---------------
Total funds: 288410 satoshi
Percentage of total channel capacity owned: 0.86737
---------------
Add command line parameter [G] for GRS, [m] for mGRS, [y] for microGRS, [g] for groestls and nothting or anything else for gro
```

As you can see you can pass several command line options to change the unit of your funds.
