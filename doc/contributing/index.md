# Contributing to Tim

## General

* We use {Github issues}[https://github.com/aeolus-incubator/tim/issues/]
  to track our features and bugs.
* Want to paste some code or output? Put \`\`\` on a line above and
  below your code/output. See {Github documentation's}[https://help.github.com/articles/github-flavored-markdown]
  <b>Fenced Code Blocks</b> for details.
* Please use {pull requests}[https://help.github.com/articles/using-pull-requests]
  to submit code, whether for implementation of a new feature or for a bug fix.
* If you submit a pull request that doesn't have a test to go with it
  there is less chance we will merge it.

## Features

Have an idea for a feature you want to implement (or would like us to
consider implementing when time allows)?  Simply submit a new
issue[https://github.com/aeolus-incubator/tim/issues/] describing the
feature in sufficient detail to enable someone to consider
implementing it.  Ideally this would be in a format focusing on:

* Who would be the user of this feature?
* How would the feature be used (this could be a workflow, api
  example, etc)?
* What need does it fill (in other words, why does the user want/need
  to do the described task)?

If you like, you may use the Connextra format, but it is not strictly
required.  For reference, that format is:

<em>In order to [benefit], a [stakeholder] wants to [feature].</em>

## Bug Reporting

While we always strive to not have bug, we realize they will come up,
and appreciate help in identifying them so they can be corrected. If
you believe you have found such a thing, please tell us:

* which version of Tim you're using
* which version of Ruby you're using.
* How to reproduce it. Bugs with a failing test in a
  {pull request}[https://help.github.com/articles/using-pull-requests] get
  extra points, though a description and stack trace, if appropriate,
  would be a minimum requirement for the issue to receive attention.
  (And of course, submitting a pull request with proper tests that also
  fixes the bug will get the fix in a release quicker yet!)

## Coding practices

If you would like to contribute to Tim then you should quickly read through the
coding practices/guidlines shown below:

* [Logging Practices](logging.md)
* [Exception Handling](exceptions.md)
