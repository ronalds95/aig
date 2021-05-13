### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ e6673bba-6361-44f9-b257-d29e19e5c996
using Pkg

# ╔═╡ 6c418973-d55e-4c8f-879f-5f600f71f1a5
Pkg.activate("Problem_1_Assignment1.toml")

# ╔═╡ d45787f2-b17e-11eb-3a9e-1dadd509823b
using Markdown

# ╔═╡ b5f98ef3-d67e-467a-b466-0dc5dec09f15
using InteractiveUtils

# ╔═╡ 4249ab5f-79fa-4cc6-ae28-ea6c7b0b0b7a
using PlutoUI

# ╔═╡ 13a185bc-2256-4442-8c2c-dc9acdaa7caa
with_terminal() do
	println("this is our assignment 1 problem 1")
end

# ╔═╡ b6390c7d-d7a9-479f-a09a-60c625f14094
"### definition of the Action"

# ╔═╡ 4afa8a0d-0877-4de6-9948-63b4aad6f1c3
struct Action
	name::String
	cost::Int64
end

# ╔═╡ febc2824-aadb-4eff-92cf-82f38caf2c01
re = Action("remain", 1)

# ╔═╡ fe8cffd9-b234-4da5-8f98-02a3dc647aa1
me = Action("move east", 3)

# ╔═╡ 7d885cf7-fb31-436c-814f-f86c60252667
mw = Action("move west", 3)

# ╔═╡ 590d6fb6-1998-4c20-b6f7-a648d152e406
co = Action("collect", 5)

# ╔═╡ 9af2bf18-95c1-45a7-bac1-6b04f24caa66
struct Office
	OfficeName::String
	Items::Int64
end

# ╔═╡ c32c40b9-748b-4275-9948-6d8c7bb7e0b8
struct Position
	Verbal::Office
end

# ╔═╡ 46550753-a86c-41d5-a3df-aafd86278bda
function Collect(Office, Action)
	if Action == co
		Office.Items - 1
	end
end

# ╔═╡ 949bc457-0c6f-49c5-abf6-1a81482ab1a5
W = Office("First Office", 1)

# ╔═╡ bc8f0178-fd59-45a2-a2cc-52307485bfeb
C1 = Office("Second Office", 3)

# ╔═╡ 39a0e930-9c8a-4ba2-a581-0a45995fffe4
C2 = Office("Third Office", 2)

# ╔═╡ da025b87-dda4-449e-9bd6-66514f39b51a
E = Office("Fourth Office", 1)

# ╔═╡ ac6ab451-846d-4d30-987e-8ea0bd1beef8
Start = Position(C1)

# ╔═╡ 8eee0df6-7407-47e8-b1d9-7fb2a4b52fd9
Actions = Dict(Start => (re, C1))

# ╔═╡ dad276d7-7e0c-4ef9-b559-2aeb757ba210
push!(Actions, Start => (me, C2))

# ╔═╡ f1aee843-5ed4-48a4-bdf9-a8e154ea112f
push!(Actions, Start => (mw, W)) 

# ╔═╡ 09922478-fe7f-44e4-81f5-882802734a73
 push!(Actions, Start => (co, C1)) 

# ╔═╡ 06353ed6-ce38-4c73-84b5-c565779eec16
"""
    astar_search(problem::GraphProblem; h::Union{Nothing, Function}=nothing)
Apply the A* search (best-first graph search with f(n)=g(n)+h(n)) to the given problem 'problem'."""

# ╔═╡ e7f0213f-2a93-43b1-b729-a350ced75071
function astar(start, isgoal, getneighbours, heuristic;
               cost = defaultcost, timeout = Inf, hashfn = defaulthash, maxcost = Inf, maxdepth = Inf)
  starttime = time()
  startheuristic = heuristic(start)
  startcost = zero(cost(start, start))
  nodetype = typeof(start)
  costtype = typeof(startcost)
  startnode = Node{nodetype, costtype}(start, zero(Int32), startcost, startheuristic, startheuristic, nothing, nothing)
  bestnode = startnode
  starthash = hashfn(start)

  closedset = Set{typeof(starthash)}()
  openheap = MutableBinaryHeap(Base.By(nodeorderingkey), Node{nodetype, costtype}[])
  starthandle = push!(openheap, startnode)
  startnode.heaphandle = starthandle
  opennodedict = Dict(starthash=>startnode)

  while !isempty(openheap)
    if time() - starttime > timeout
      return AStarResult{nodetype, costtype}(:timeout, reconstructpath(bestnode), bestnode.g, length(closedset), length(openheap))
    end

    node = pop!(openheap)
    nodehash = hashfn(node.data)
    delete!(opennodedict, nodehash)

    if isgoal(node.data)
      return AStarResult{nodetype, costtype}(:success, reconstructpath(node), node.g, length(closedset), length(openheap))
    end

    push!(closedset, nodehash)

    if node.h < bestnode.h
      bestnode = node
    end

    neighbours = getneighbours(node.data)

    for neighbour in neighbours
      neighbourhash = hashfn(neighbour)
      if neighbourhash in closedset
        continue
      end

      gfromthisnode = node.g + cost(node.data, neighbour)

      if gfromthisnode > maxcost
        continue
      end

      if node.depth > maxdepth
        continue
      end

      if neighbourhash in keys(opennodedict)
        neighbournode = opennodedict[neighbourhash]
        if gfromthisnode < neighbournode.g
          neighbournode.depth = node.depth + one(Int32)
          neighbournode.g = gfromthisnode
          neighbournode.parent = node
          neighbournode.f = gfromthisnode + neighbournode.h
          update!(openheap, neighbournode.heaphandle, neighbournode)
        end
      else
        neighbourheuristic = heuristic(neighbour)
        neighbournode = Node{nodetype, costtype}(neighbour, node.depth + one(Int32), gfromthisnode, neighbourheuristic, gfromthisnode + neighbourheuristic, node, nothing)
        neighbourhandle = push!(openheap, neighbournode)
        neighbournode.heaphandle = neighbourhandle
        push!(opennodedict, neighbourhash => neighbournode)
      end
    end
  end

  return AStarResult{nodetype, costtype}(:nopath, reconstructpath(bestnode), bestnode.g, length(closedset), length(openheap))
end

# ╔═╡ c3e82520-2b7a-4bb9-87b1-e9927e51ebee
abstract type AbstractAStarSearch{T} end

# ╔═╡ 37e64082-209f-4acb-97f0-3d98af83674a
isgoal(astarsearch::AbstractAStarSearch{T}, current::T, goal::T) where T = current == goal

# ╔═╡ 722b4dba-6fed-42f6-9b01-6b8a68aee9c2
neighbours(astarsearch::AbstractAStarSearch{T}, current::T) where T = throw("neighbours not implemented! Implement it for your AbstractAStarSearch subtype!")

# ╔═╡ cf0979fa-ba36-4ef7-9e69-41c63752c090
heuristic(astarsearch::AbstractAStarSearch{T}, current::T, goal::T) where T = throw("heuristic not implemented! Implement it for your AbstractAStarSearch subtype!")

# ╔═╡ d7e27b51-b721-41f1-9ef2-af13e337e7c9
cost(astarsearch::AbstractAStarSearch{T}, current::T, neighbour::T) where T = defaultcost(current, neighbour)

# ╔═╡ c4d5b9a6-623f-481d-b40e-49a1e92338c2
#function search(aastarsearch::AbstractAStarSearch{T}, start::T, goal::T; timeout = Inf, maxcost = Inf, maxdepth = Inf) where T
 # _isgoal(x::T) = isgoal(aastarsearch, x, goal)
  #_neighbours(x::T) = neighbours(aastarsearch, x)
  #_heuristic(x::T) = heuristic(aastarsearch, x, goal)
  #_cost(current::T, neighbour::T) = cost(aastarsearch, current, neighbour)
  #_hashfn(x::T) = hash(x)
  #return astar(start, _isgoal, _neighbours, _heuristic, cost = _cost, hashfn = _hashfn; timeout, maxcost, maxdepth)
#end

# ╔═╡ Cell order:
# ╠═d45787f2-b17e-11eb-3a9e-1dadd509823b
# ╠═e6673bba-6361-44f9-b257-d29e19e5c996
# ╠═b5f98ef3-d67e-467a-b466-0dc5dec09f15
# ╠═6c418973-d55e-4c8f-879f-5f600f71f1a5
# ╠═4249ab5f-79fa-4cc6-ae28-ea6c7b0b0b7a
# ╠═13a185bc-2256-4442-8c2c-dc9acdaa7caa
# ╠═b6390c7d-d7a9-479f-a09a-60c625f14094
# ╠═4afa8a0d-0877-4de6-9948-63b4aad6f1c3
# ╠═febc2824-aadb-4eff-92cf-82f38caf2c01
# ╠═fe8cffd9-b234-4da5-8f98-02a3dc647aa1
# ╠═7d885cf7-fb31-436c-814f-f86c60252667
# ╠═590d6fb6-1998-4c20-b6f7-a648d152e406
# ╠═9af2bf18-95c1-45a7-bac1-6b04f24caa66
# ╠═c32c40b9-748b-4275-9948-6d8c7bb7e0b8
# ╠═46550753-a86c-41d5-a3df-aafd86278bda
# ╠═949bc457-0c6f-49c5-abf6-1a81482ab1a5
# ╠═bc8f0178-fd59-45a2-a2cc-52307485bfeb
# ╠═39a0e930-9c8a-4ba2-a581-0a45995fffe4
# ╠═da025b87-dda4-449e-9bd6-66514f39b51a
# ╠═ac6ab451-846d-4d30-987e-8ea0bd1beef8
# ╠═8eee0df6-7407-47e8-b1d9-7fb2a4b52fd9
# ╠═dad276d7-7e0c-4ef9-b559-2aeb757ba210
# ╠═f1aee843-5ed4-48a4-bdf9-a8e154ea112f
# ╠═09922478-fe7f-44e4-81f5-882802734a73
# ╠═06353ed6-ce38-4c73-84b5-c565779eec16
# ╠═e7f0213f-2a93-43b1-b729-a350ced75071
# ╠═c3e82520-2b7a-4bb9-87b1-e9927e51ebee
# ╠═37e64082-209f-4acb-97f0-3d98af83674a
# ╠═722b4dba-6fed-42f6-9b01-6b8a68aee9c2
# ╠═cf0979fa-ba36-4ef7-9e69-41c63752c090
# ╠═d7e27b51-b721-41f1-9ef2-af13e337e7c9
# ╠═c4d5b9a6-623f-481d-b40e-49a1e92338c2
