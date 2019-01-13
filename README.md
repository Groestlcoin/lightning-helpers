This project is a collection of `lightning-helpers` which are small files (usually) written as shell scripts or in python which are supposed to ease the work with c-lightning.

currently there are two tools:

* listfunds is a small tool that gives you a nicer overview of your funds than the native `lighting-cli listfunds` API call
* pay_anyone_without_invoice is a tool that allows you to pay any lightning node by making a routed payment to yourself and drop a high routing fee for the node which you actually want to pay.
