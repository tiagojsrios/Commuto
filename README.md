# Commuto

Commuto is a simple widget, targeting only MacOS (for now, perhaps?), that shows when the next recommended commute trip will be.

To retrieve the details of the next recommended trip, this tool uses the public API of the Dutch railways company - Nederlandse Spoorwegen (NS). If you live outside of the Netherlands, it's likely that you won't find this app useful. Though, I'm open to the idea of having this tool to work with other public transport providers :)

For more details on how to best use the widget, check the [How to use](#how-to-use) section.


## Tech Stack

- Swift

*DISCLAIMER: I have never developed apps using Swift. This tool is mostly vibe coded.*

My knowledge of Swift and architecturing apps in Swift is very limited. Though I'm open for suggestions on how to improve the code. Feel free to contribute!


## Installation Guide

1. **Homebrew**

The easiest and recommended way to install and run Commuto is through Homebrew.

To achieve that, simply run the following command in your terminal:

```
brew install --cask tiagojsrios/tap/commuto
```

Note: It is a pre-requirement that you to have [homebrew](https://brew.sh/) installed in your machine.

2. **Download asset**

Another way is to go to the [Releases page](https://github.com/tiagojsrios/Commuto/releases), and download the Commuto.zip asset from the release you want to download.


## How to use

The widget makes a request to the NS API every minute, to retrieve the most recent advice. 

As mentioned before, the NS API is public and free, but it enforces rate-limiting. Due to this constraint, and despite knowing that I could build my own proxy/API, I decided to ship the app without an API key that can access the NS API.

Therefore, you should go to the NS Developer Portal and request a **free** API key for the [NS-App](https://apiportal.ns.nl/product#product=NsApp) product.

After installing the app, a new icon should show on your top bar when you first run it. To add your newly created API key, click on the icon and then 'Settings'.

Last, you have to add your commute details - meaning the nearest station to your work and the destination.