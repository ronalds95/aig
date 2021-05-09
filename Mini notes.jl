### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ f8e6e020-aea1-11eb-3ce9-11b5f3253189
using Pkg

# ╔═╡ 888cf7a8-24c5-4486-ae11-2ffe0f951615
Pkg.activate("Prblem_1_Assignment1.toml")

# ╔═╡ 3602eb72-b142-4c94-8fbe-3443a3ae983c
using PlutoUI

# ╔═╡ c664f4ef-3fd3-463f-8e32-bdea8f2f10c9
using DataStructures

# ╔═╡ a63bd2a6-2838-4982-bff4-a46d04d2f73d
with_terminal() do
	println("this is our assignment 1 problem 1")
end

# ╔═╡ 77001f36-ad52-41d7-870d-087a5159e5d5
struct Action
	Name::String
	Cost::Int64
end

# ╔═╡ ca12bdfd-025c-400b-9590-26fa60513de0
Move_East = Action("move east", 3)

# ╔═╡ 13e8572e-ccb5-4a53-a008-5cd55e5e2ab6
Move_West = Action("move west", 3)

# ╔═╡ af98796e-6cdf-48a3-b916-3bca68babbe1
Remain = Action("remain", 1)

# ╔═╡ 7534329a-2221-4c93-970d-b58815e34c60
Collect = Action("collect", 5)

# ╔═╡ bab42e0f-0d31-4513-be2b-10fd61b50d07
struct State
	Name::String
	CollectItems::Vector{Bool}
	Office::Int64 #this are the office number 1=W, 2=C1, 3=C2, 4=E 
end

# ╔═╡ 96d58bb6-bde2-4741-a796-834bd94564aa
SOne = State("State One",[false,true,true,true],1)

# ╔═╡ 7381a72c-c411-4c97-94b4-5c141cbfc018
STwo = State("State Two",[true,true,true,true],2)

# ╔═╡ 0385951a-82b9-4b87-ab95-c9e62b312faa
SThree = State("State Three",[true,true,true,true],3)

# ╔═╡ ea4a3a51-e508-4d65-99a1-fe436882b296
SFour = State("State Four",[true,false,true,true],4)

# ╔═╡ 4e65bb16-9ee8-4887-8bc7-5bd59a4f50b1
SFive = State("State Five",[false,false,true,true],2)

# ╔═╡ 525c4d25-66eb-4353-8170-1645384cf1ab
SSix = State("State Six",[false,false,true,false],2)

# ╔═╡ 3e77db2d-1046-48c5-aa42-0771da85326e
SSeven = State("State Seven",[false,true,true,true],2)

# ╔═╡ babf4ec2-71ce-456b-8843-5e68e4de9e59
SEight = State("State Eight",[false,false,true,true],3)

# ╔═╡ 35c59020-d875-4749-9a4d-98694d532680
SNine = State("State Nine",[false,false,true,false],3)

# ╔═╡ cb2f512e-72c0-4705-be07-7da651136d18
STen = State("State Ten",[false,true,true,true],3)

# ╔═╡ 61e9c94a-3e25-40ac-bfbe-c9ffc2d6c9a0
SEleven = State("State Eleven",[false,false,false,false],4)

# ╔═╡ 5592bbbc-0c6f-4622-ac85-ae7b85d166bd
TransitionModel = Dict(SOne => [(Move_East, STwo), (Collect, SSeven), (Move_West, SOne)])

# ╔═╡ 57df8da0-9e6f-4538-92eb-9b209faaa129
push!(TransitionModel, STwo => [(Move_East, SThree)]), (Collect, STen), (Move_West, STwo)

# ╔═╡ 93c67c40-b116-4214-b4c7-37589a11021a
push!(TransitionModel, SThree => [(Move_East, SFour)]), (Collect, SFour), (Move_West, SThree)

# ╔═╡ 93940922-0fd5-488f-95d5-bf2843bfe865
push!(TransitionModel, SOne => [(Move_East, STwo), (Move_West, SOne)])

# ╔═╡ 200fe010-c6c3-421a-b094-50579c4581bf
push!(TransitionModel, STwo => [(Move_East, SThree), (Move_West, STwo)])

# ╔═╡ bec4ebc6-717a-44f1-9700-7a38e68737cf
push!(TransitionModel, SThree => [(Move_East, SFour), (Move_West, SThree)])

# ╔═╡ 2e0bcbcd-f8b7-468b-a545-853a4505e150
push!(TransitionModel, SFour => [(Move_West, SThree), (Move_East, SFour)])

# ╔═╡ d8d31095-3518-4cff-af77-f19ba90f1d92
push!(TransitionModel, SOne => [(Collect, STwo)])

# ╔═╡ f2adcb28-c58d-441f-a574-b589271c360c
push!(TransitionModel, STwo => [(Collect, SThree)])

# ╔═╡ 23e64a54-7d54-448c-87e9-8516c98e0c9c
push!(TransitionModel, SFour=> [(Collect, SThree)])

# ╔═╡ 97f67b7c-a701-4ae5-b2b6-77cac84d36c7
push!(TransitionModel, SThree=> [(Collect, STwo)])

# ╔═╡ d0ea04d0-3510-40be-94af-e9c94d396612
push!(TransitionModel, STwo => [(Collect, SOne)])

# ╔═╡ cdb6f53f-850e-400d-9e01-a0ed89fe0304
push!(TransitionModel, STwo => [(Remain, SOne)])#This lets verbal remain in office one when theres no other office going westward

# ╔═╡ d190bbf2-430d-46c8-8112-a17be7aecd37
push!(TransitionModel, SThree => [(Collect, SFour)])

# ╔═╡ 6087a718-dcc8-4f6c-afd4-592225d73dd3
push!(TransitionModel, SThree => [(Remain, SFour)]) #This lets verbal remain in office four when theres no other office going eastward

# ╔═╡ b0996509-934c-4e2a-8de0-8b9f6205a925
goalstates = [SEleven]

# ╔═╡ 2325eec7-e41f-4215-a2c4-a01ac9b61001
TransitionModel[SOne]

# ╔═╡ Cell order:
# ╠═f8e6e020-aea1-11eb-3ce9-11b5f3253189
# ╠═888cf7a8-24c5-4486-ae11-2ffe0f951615
# ╠═3602eb72-b142-4c94-8fbe-3443a3ae983c
# ╠═a63bd2a6-2838-4982-bff4-a46d04d2f73d
# ╠═77001f36-ad52-41d7-870d-087a5159e5d5
# ╠═ca12bdfd-025c-400b-9590-26fa60513de0
# ╠═13e8572e-ccb5-4a53-a008-5cd55e5e2ab6
# ╠═af98796e-6cdf-48a3-b916-3bca68babbe1
# ╠═7534329a-2221-4c93-970d-b58815e34c60
# ╠═bab42e0f-0d31-4513-be2b-10fd61b50d07
# ╠═96d58bb6-bde2-4741-a796-834bd94564aa
# ╠═7381a72c-c411-4c97-94b4-5c141cbfc018
# ╠═0385951a-82b9-4b87-ab95-c9e62b312faa
# ╠═ea4a3a51-e508-4d65-99a1-fe436882b296
# ╠═4e65bb16-9ee8-4887-8bc7-5bd59a4f50b1
# ╠═525c4d25-66eb-4353-8170-1645384cf1ab
# ╠═3e77db2d-1046-48c5-aa42-0771da85326e
# ╠═babf4ec2-71ce-456b-8843-5e68e4de9e59
# ╠═35c59020-d875-4749-9a4d-98694d532680
# ╠═cb2f512e-72c0-4705-be07-7da651136d18
# ╠═61e9c94a-3e25-40ac-bfbe-c9ffc2d6c9a0
# ╠═5592bbbc-0c6f-4622-ac85-ae7b85d166bd
# ╠═57df8da0-9e6f-4538-92eb-9b209faaa129
# ╠═93c67c40-b116-4214-b4c7-37589a11021a
# ╠═93940922-0fd5-488f-95d5-bf2843bfe865
# ╠═200fe010-c6c3-421a-b094-50579c4581bf
# ╠═bec4ebc6-717a-44f1-9700-7a38e68737cf
# ╠═2e0bcbcd-f8b7-468b-a545-853a4505e150
# ╠═d8d31095-3518-4cff-af77-f19ba90f1d92
# ╠═f2adcb28-c58d-441f-a574-b589271c360c
# ╠═23e64a54-7d54-448c-87e9-8516c98e0c9c
# ╠═97f67b7c-a701-4ae5-b2b6-77cac84d36c7
# ╠═d0ea04d0-3510-40be-94af-e9c94d396612
# ╠═cdb6f53f-850e-400d-9e01-a0ed89fe0304
# ╠═d190bbf2-430d-46c8-8112-a17be7aecd37
# ╠═6087a718-dcc8-4f6c-afd4-592225d73dd3
# ╠═b0996509-934c-4e2a-8de0-8b9f6205a925
# ╠═2325eec7-e41f-4215-a2c4-a01ac9b61001
# ╠═c664f4ef-3fd3-463f-8e32-bdea8f2f10c9
