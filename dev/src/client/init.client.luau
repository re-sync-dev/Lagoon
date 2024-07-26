--[==[

	Copyright (C) Re-Sync - All Rights Reserved

	[init.client.luau]:
		Testing environment on the client.

	[Author(s)]:
		Vyon - https://github.com/Vyon

--]==]

-- Services:
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules:
local Network = require(ReplicatedStorage.Shared.Network)

-- Main:
do -- Wait for remotes:
	Network:WaitFor("Event")
	Network:WaitFor("Function")

	Network:WaitFor("EventMiddleware")
	Network:WaitFor("FunctionMiddleware")

	Network:WaitFor("EventSerialized")
	Network:WaitFor("FunctionSerialized")

	Network:WaitFor("EventSerializedMiddleware")
	Network:WaitFor("FunctionSerializedMiddleware")

	Network:WaitFor("FireAll")
	Network:WaitFor("SerializedFireAll")
end

local Passed = 0
local Responded = 0
local Total = 0
local Errors = {}

do --> Standard Remotes
	Network:Once("Event", function(Message: string)
		local IsEQ = Message == "Event"

		if IsEQ then
			print("Passed 1")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{1}`)
		end

		Responded += 1
	end)

	Network:Fire("Event")

	local Message = Network:Invoke("Function")

	local IsEQ = Message == "Function"

	if IsEQ then
		print("Passed 2")

		Passed += 1
	else
		table.insert(Errors, `Failed test #{2}`)
	end

	Responded += 1

	Total += 2
end

do --> Standard remote middleware
	Network:Once("EventMiddleware", function(Message: { string })
		local IsEQ = table.concat(Message) == "EventMiddleware"

		if IsEQ then
			print("Passed 3")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{3}`)
		end

		Responded += 1
	end)

	Network:Fire("EventMiddleware", { "Event" })

	local Message = Network:Invoke("FunctionMiddleware", { "Function" })

	local IsEQ = table.concat(Message) == "FunctionMiddleware"

	if IsEQ then
		print("Passed 4")

		Passed += 1
	else
		table.insert(Errors, `Failed test #{4}`)
	end

	Responded += 1

	Total += 2
end

do --> Serialized Remotes
	Network:Once("EventSerialized", function(Message: string)
		local IsEQ = Message == "EventSerialized"

		if IsEQ then
			print("Passed 5")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{5}`)
		end

		Responded += 1
	end)

	Network:Fire("EventSerialized", "Serialized")

	local Message = Network:Invoke("FunctionSerialized", "Serialized")

	local IsEQ = Message == "FunctionSerialized"

	if IsEQ then
		print("Passed 6")

		Passed += 1
	else
		table.insert(Errors, `Failed test #{6}`)
	end

	Responded += 1

	Total += 2
end

do --> Serialized Remote middleware
	Network:Once("EventSerializedMiddleware", function(Message: { string })
		local IsEQ = table.concat(Message) == "EventSerializedMiddleware"

		if IsEQ then
			print("Passed 7")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{7}`)
		end

		Responded += 1
	end)

	Network:Fire("EventSerializedMiddleware", { "Serialized" })

	local Message = Network:Invoke("FunctionSerializedMiddleware", { "Serialized" })

	local IsEQ = table.concat(Message) == "FunctionSerializedMiddleware"

	if IsEQ then
		print("Passed 8")

		Passed += 1
	else
		warn(Message)
		table.insert(Errors, `Failed test #{8}`)
	end

	Responded += 1

	Total += 2
end

do --> Fire all clients
	Network:Once("FireAll", function(Message: string)
		local IsEQ = Message == "FireAll"

		if IsEQ then
			print("Passed 9")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{9}`)
		end

		Responded += 1
	end)

	Network:Fire("FireAll")

	Total += 1
end

do --> Serialized Fire all clients
	Network:Once("SerializedFireAll", function(Message: string)
		local IsEQ = Message == "SerializedFireAll"

		if IsEQ then
			print("Passed 10")

			Passed += 1
		else
			table.insert(Errors, `Failed test #{10}`)
		end

		Responded += 1
	end)

	Network:Fire("SerializedFireAll", "Serialized")

	Total += 1
end

repeat
	task.wait()
until Responded == Total

task.wait(0.1)

print(`Tests: {Passed} / {Responded}`)
print(Errors)
