# Overview

Highlights a substring in HTML text.

## Install

    bower install <path to github repo>

Include the JS:

    <script src="/bower_components/teg-ng-text-utils/dist/teg-ng-text-utils.min.js"></script>
    <script src="/bower_components/teg-ng-select-substring/dist/teg-ng-select-substring.min.js"></script>

If you need to support IE8 and other older browsers please Include:

    bower install /es5-shim

    <script src="/bower_components/es5-shim/es5-shim.min.js"></script>

Add module to your app's dependencies:

    angular.module('YourApp', ['TegNgSelectSubstring'])

## Usage

In HTML:

    <span ng-bind-html="tegNgSelectSubstring.select('My penguin is happy!', 'Penguin')"></span>

Or in JavaScript:

    tegNgSelectSubstring.selectUnsafe('My penguin is happy!', 'Penguin')\


will produce:

    My <span class='SelectedSubstring'>penguin</span> is happy!


## Development

After cloning the github repo into a dir:

    npm install
    bower install
    npm install -g gulp

Test:

    gulp test

Demo in browser:

    gulp serve

Build:

    gulp

Finally, bump bower version number:

    git tag v0.1.[patch number]
    git push origin v0.1.[patch number]



