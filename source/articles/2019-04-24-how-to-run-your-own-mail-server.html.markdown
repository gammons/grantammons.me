---

title: How to run your own mail server
date: 2019-04-24 10:39 UTC
tags: email linux
comments: true
---

Running your own mail server can be a fun and rewarding experience.  

In this day and age it's completely unnecesary to run your own server.  It's certainly a hobby, but it's also fun and rewarding to have ownership of your own servers, and to have everything properly configured.

There are certainly some things to be aware of

* where to run your own mail server
  * can't run locally, outbound port 25 is blocked
  * you won't be able to _send_ email via your home internet connection
    * you may be able to _receive_ email, and it's worth testing if your local ISP blocks incoming traffic on port 25.  if they don't, j
  * Use an outbound SMTP service like Duocircle[1]
  * Host entire infrastructure on AWS, like I do
  * 

* postfix setup
  * ensuring you're not running an open relay
  * using multiple domains

* dovecot setup
  * dovecot is the IMAP server

* DNS setup  
  * PTR record request from AWS
  * setting up SPF and DKIM
  * setting up DMARC

* blocking spam with rspamadm

* redundancy
  * setting up a second postfix box

* testing
  * dkimvalidator.com
  * blacklist checking

* inbox management
  * auto-archiving old emails

* Security
  * installing fail2ban
  * limiting ip address


[1]: https://www.duocircle.com/email/outbound-smtp


https://aws.amazon.com/forms/ec2-email-limit-rdns-request
