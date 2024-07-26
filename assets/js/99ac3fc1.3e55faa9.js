"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[405],{94307:e=>{e.exports=JSON.parse('{"functions":[{"name":"CollectName","desc":"Uses \'getfenv\' to get the name of then script that called the function","params":[],"returns":[{"desc":"","lua_type":"string"}],"function_type":"static","ignore":true,"source":{"line":33,"path":"src/init.luau"}},{"name":"MakeService","desc":"Takes in a table for the \'Module\' parameter and wraps the module with a Lagoon Service.\\n\\n**Usage:**   \\n**MyService.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\n\\nlocal MyService = {}\\nMyService.IsService = true\\n\\nfunction MyService.PrintFromServer()\\n\\tprint(\\"Hello from the server!\\")\\nend\\n\\nreturn Lagoon.MakeService(MyService)\\n```","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[],"function_type":"static","source":{"line":74,"path":"src/init.luau"}},{"name":"MakeController","desc":"Takes in a table for the \'Module\' parameter and wraps the module with a Lagoon Controller.\\n\\n**Usage:**   \\n**MyController.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\n\\nlocal MyController = {}\\nMyController.IsController = true\\n\\nfunction MyController.PrintFromClient()\\n\\tprint(\\"Hello from the client!\\")\\nend\\n\\nreturn Lagoon.MakeController(MyController)\\n```","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[],"function_type":"static","source":{"line":111,"path":"src/init.luau"}},{"name":"MakeTrait","desc":"Creates a Trait using the module parameter, the created trait can be applied to\\nservices/controllers using `Service:ApplyTrait(MyCustomTrait)` or\\n`Controller:ApplyTrait(MyCustomTrait)`\\n\\n**Usage:**   \\n**MyCustomTrait.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\n\\nlocal MyCustomTrait = {}\\n\\nfunction MyCustomTrait.Sum(a: number, b: number)\\n\\treturn a + b\\nend\\n\\nreturn Lagoon.MakeTrait(MyCustomTrait)\\n```\\n\\n**MyController.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\nlocal MyCustomTrait = require(Path.To.MyCustomTrait)\\n\\nlocal MyController = {}\\nMyController.IsController = true\\n\\nfunction MyController.PrintFromClient()\\n\\tprint(\\"Hello from the client!\\")\\nend\\n\\nreturn Lagoon.MakeController(MyController):ApplyTrait(MyCustomTrait)\\n```","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[],"function_type":"static","source":{"line":165,"path":"src/init.luau"}},{"name":"Load","desc":"Requires and initializes the Parent\'s children.","params":[{"name":"Parent","desc":"","lua_type":"Instance"}],"returns":[],"function_type":"static","source":{"line":178,"path":"src/init.luau"}},{"name":"Get","desc":":::warning\\nFunction provides no typesafety.\\n:::","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"static","source":{"line":214,"path":"src/init.luau"}}],"properties":[],"types":[],"name":"Lagoon","desc":"Lagoon is a barebones typesafe framework that can be integrated anywhere.","source":{"line":47,"path":"src/init.luau"}}')}}]);