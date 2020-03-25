<p>
  <img align="center" src="https://i.imgur.com/IyqXBb6.png"></img>
  <p align="center">
  <a href="https://loukamb.github.io/SynapseX">API Documentation</a> <b>·</b> <a href="https://github.com/LoukaMB/SynapseX/wiki">Wiki</a> <b>·</b> <a href="https://github.com/LoukaMB/SynapseX/issues">Bug Tracker</a>
  </p>
</p>

## Developer Resources

**This repository offers source code and documentation for Synapse X-related facilities, APIs and endorsed scripts/libraries,** excluding the Synapse X interface which is available in this [separate repository](https://github.com/syngp/xui). Pull requests are welcomed but rarely accepted. **This repository also serves as the principal bug tracker for Synapse X.**

## Development Compatibility Layer

The **Development Compatibility Layer** (DCL) is a Lua script providing a unified API that should be compatible between many similar softwares. It is developed by Synapse G.P. but, just like anything in this repository excluding image files, offered completely free of charge under the <b>AGPLv3</b>. The DCL's documentation is synonymous with Synapse X's documentation (as the DCL is based on Synapse X), meaning any Synapse X documentation provides DCL's entire API. [You can view the API documentation here](https://loukamb.github.io/SynapseX). Bear in mind that the DCL is accessed via `api.`, not `syn_`.

## Reporting Issues

**Only report issues that can be reproduced and clearly, evidently explained.** Occasional crashes related to the nature of the software that have no clear origin will be closed and ignored. Titles must be concise and provide a summary of the crash _(`"Help crash!!"` is not a good title, neither is `"Problem!"`. `"Crash when authenticating`" or `"Invalid argument Error while using syn.cache_invalidate"` are good example of titles.)_ We will also close all reports that provide no technical information. For your report to be accepted, you _must_ specify at minimum this information:

- Your operating system (`Windows 10`, `Windows 8`, `Windows 7`, etc.).
- Basic hardware in formation (such as your CPU, your GPU, your motherboard, etc.) If you don't know any of those elements, we recommend using the [free version of `Speccy`](https://www.ccleaner.com/speccy) or [CPU-Z](https://www.cpuid.com/softwares/cpu-z.html) to look up your computer specifications.
- The script you ran that crashed the software (Upload it to [`paste.sh`](https://paste.sh) or [`hastebin`](https://hastebin.com)), if applicable. Please specify that the software crashed on its own if no script was ran.
- The circumstances of the crash/bug/issue (for example, if the game crashes uniquely when accessing a specific component/API/feature of the software then you must name this component).
- Whether you are using a pre-release build of Synapse X (beta)
- The interface you are using (_the original interface or a 3rd party one_)
- Any additional information that you deem necessary and useful.

If you are a software developer/reverse engineer and you're capable of producing a `.dmp` file for us to analyze, then please do so and attach the file to your issue. It will be greatly appreciated. Otherwise, we will try to do our best with the information specified within the issue.

## Reporting security vulnerabilities

**We consider security vulnerabilities to be a critical matter,** and we will **reward** those that report them to us in cash prizes and other goodies. If you find a potentially dangerous security vulnerability and you want to tell us then simply contact Louka at the e-mail address written on his [profile](https://github.com/LoukaMB) describing the issue. If further communication is needed from your part, it will be requested.

Those are security vulnerabilities that warrants a reward:
- Methods to use the software without owning a legitimate account
- Methods to circumvent the software's security mechanisms (packing, obfuscation, detection, etc.)
- Methods to infect a Software user via the usage of malicious Lua scripts
- Anything related to unauthorized interaction with our online API

Those are security vulnerabilities that, while important, are not critical enough to be considered rewardable:
- Ways to detect the software from a script within a game
- Modifying or intercepting Synapse web requests

## Other communications

If you have anything else to transmit to us, then either personally contact one of our developers via the e-mails on their profiles or communicate with them on the various Synapse chatrooms.

### Documentation Generator

Our documentation generator, including `docgenx.lua` and all associated resources are licensed under the [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.en.html). Feel free to use it and modify it for your own projects.