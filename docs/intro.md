---
sidebar_position: 1
---

# About
Lagoon is a barebones typesafe framework that can be integrated anywhere with low requirements for integration. For example usages click [here](https://github.com/re-sync-dev/Lagoon/releases).

## How does it compare to other frameworks?
Lagoon itself can be used as a framework to support a game's infrastructure, but unlike frameworks such as [Knit](https://github.com/Sleitnick/Knit) that require integration into the entire game, Lagoon does not require complete game integration and at most requires integration into the module you use to define a Service or Controller.

## Services v Controllers
### Services
Services are modules that can only be used on the Server and on the client.

### Controllers
Controllers differ from Services because they can only be used on the client

:::info
The best time to use a trait is when you need to have methods or properties accessible to both the server and client.
:::

## What are traits?
Traits are simply put modules that services and controllers can inherit methods and properties from using `:ApplyTrait`
