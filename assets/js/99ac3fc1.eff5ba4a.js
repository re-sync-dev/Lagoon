"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[405],{94307:e=>{e.exports=JSON.parse('{"functions":[{"name":"MakeService","desc":"Takes in a table for the \'Module\' parameter and wraps the module with a Lagoon Service.\\n\\n**Usage:**   \\n**MyService.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\n\\nlocal MyService = {}\\nMyService.IsService = true\\n\\nfunction MyService.PrintFromServer()\\n\\tprint(\\"Hello from the server!\\")\\nend\\n\\nreturn Lagoon.MakeService(MyService)\\n```","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[{"desc":"","lua_type":"Service & T"}],"function_type":"static","source":{"line":75,"path":"src/init.luau"}},{"name":"MakeController","desc":"Takes in a table for the \'Module\' parameter and wraps the module with a Lagoon Controller.\\n\\n**Usage:**   \\n**MyController.lua**\\n```lua\\n-- This is in a ModuleScript\\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\\n\\nlocal MyController = {}\\nMyController.IsController = true\\n\\nfunction MyController.PrintFromClient()\\n\\tprint(\\"Hello from the client!\\")\\nend\\n\\nreturn Lagoon.MakeController(MyController)\\n```","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[{"desc":"","lua_type":"Controller & T"}],"function_type":"static","source":{"line":109,"path":"src/init.luau"}},{"name":"Wrap","desc":"Integrates a module into the lagoon environment","params":[{"name":"Module","desc":"","lua_type":"T"}],"returns":[{"desc":"","lua_type":"Module & T"}],"function_type":"static","source":{"line":128,"path":"src/init.luau"}},{"name":"Load","desc":"Requires and initializes the Parent\'s children.","params":[{"name":"List","desc":"","lua_type":"Instance | {Instance}"}],"returns":[],"function_type":"static","source":{"line":145,"path":"src/init.luau"}},{"name":"Get","desc":":::warning\\nFunction provides no typesafety.\\n:::","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"static","source":{"line":189,"path":"src/init.luau"}}],"properties":[],"types":[],"name":"Lagoon","desc":"Lagoon is a barebones typesafe framework that can be integrated anywhere.","source":{"line":46,"path":"src/init.luau"}}')}}]);