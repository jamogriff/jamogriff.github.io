---
layout: post
title: New Open Source Theme Released
description: Jamison Griffith has release a new open source theme entitled Gruv Poole for Jekyll, the static site generator. It is compliant with WCAG 2.2 AA and has a dark and light mode inspired by Gruvbox. Users that implement this theme can easily configure Google Analytics and Gruv Poole will dynamically render a privacy policy dependent on their choice to use site tracking.
---

## Howdy!

It's been a minute since I've updated this site. No better time to revive it from the grave than alongside the release of [Gruv Poole](https://github.com/jamogriff/gruv-poole), my open source theme. Gruv Poole is a modern, WCAG-compliant fork of the [Poole theme](https://github.com/poole/poole) for [Jekyll](https://jekyllrb.com), the static site generator.

The Gruv Poole theme powers the aesthetic of the site, and the beauty of it being open source allows you to use and configure it to your own liking. The easiest way to implement it on a Jekyll site is by adding the Gem to your Gemfile: `gem "jekyll-theme-gruv-poole"`.

Not sure what that means? No worries, as of this post the [latest release](https://github.com/jamogriff/gruv-poole/releases/tag/v1.0.3) can be downloaded here.

## No Brainer Dark Mode

Gruv Poole taps into the user's operating system or browser preference for light or dark mode, which means this theme's mode will automatically mirror the user's device setting. The color palette for both modes is inspired by the retro groove Vim theme [Gruvbox](https://github.com/morhetz/gruvbox).

## Tweak to Your Own Delight 

Gruv Poole's code is 100% open source. Even the icons and typefaces are licensed under permissive licenses. Don't believe me? I've got receipts:

<table>
  <thead>
    <tr>
      <th>License</th>
      <th>Asset</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
         <a href="https://github.com/jamogriff/gruv-poole/blob/main/LICENSE.md">MIT</a>
      </td>
      <td>Theme code</td>
    </tr>
    <tr>
      <td>
         <a href="{{ base.url }}/assets/fonts/body/LICENSE.md">SIL Open Font</a>
      </td>
      <td>Jost, the body typeface</td>
    </tr>
    <tr>
      <td>
          <a href="{{ base.url }}/assets/fonts/code/LICENSE.md">SIL Open Font</a>
      </td>
      <td>Office Code Pro, the code typeface</td>
    </tr>
    <tr>
      <td>
          <a href="https://github.com/twbs/icons/blob/main/LICENSE">MIT</a>
      </td>
      <td>Bootstrap icons</td>
    </tr>
  </tbody>
</table>

## Accessible and Privacy-conscious

Gruv Poole complies with the [WCAG 2.2 AA accessibility standard](https://www.wcag.com/resource/what-is-wcag). In addition, sites that use this theme can easily pop-in their Google Analytics ID if they want that functionality. Gruv Poole will dynamically render [an appropriate privacy policy]({% link privacy-policy.md %}) based on that configuration.

## What are You Waiting For?

Static sites are the cheapest entrypoint to host a website. Hosting on blob storage like AWS S3 is about a dollar a month or you can host on Github Pages for free. Embrace not needing to think about (or pay for) a database or a backend needing a server.


