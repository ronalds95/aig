### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 3879cce8-0d6b-4016-9a85-e49708485d6a
using Pkg

# ╔═╡ 1fbc0df1-5d4c-4dc4-8d53-9396fc6b4ac4
Pkg.activate("Problem_3_Assignment1.toml")

# ╔═╡ 331d7de2-b19a-11eb-2606-37c1694eb9d9
using Markdown

# ╔═╡ 8f72d78b-74fd-4af5-8edb-99630ae39a22
using InteractiveUtils

# ╔═╡ 55ae5d56-0038-4618-a422-e065dc4064f9
using PlutoUI

# ╔═╡ c31392c8-0bf8-4855-8277-18e1fb58b5d8
struct variable
	Name::String
	value::Int64
end

# ╔═╡ 76700376-d7cf-4ac0-ad78-130740218434
struct Constraint
	    variables::Vector{String}
	    place1::String
	    function Constraint(variables::Vector{String}, place1)
	        return new(variables, place1)
	    end
	end

# ╔═╡ 14cfc571-e623-401b-adfb-377e0f40e15d
X1 = variable("X1", 1)

# ╔═╡ ab66b324-9550-407e-9296-eca56ab98bba
X2 = variable("X2", 2)

# ╔═╡ 62670d4a-3d90-495a-8bfe-e3d14be1ea68
X3 = variable("X3", 3)

# ╔═╡ 6cafa65b-59c3-4c04-8e1d-7d6da03755e1
X4 = variable("X4", 4)

# ╔═╡ 54372625-cadc-4146-ace7-421f95fcb1cf
X5 = variable("X5", 5)

# ╔═╡ 32eab809-d340-4ca6-9de0-ac0a67114cb8
X6 = variable("X6", 6)

# ╔═╡ b81a0213-8e67-4304-9e44-bc5a7c8b004e
X7 = variable("X7", 7)

# ╔═╡ 5387037a-695f-4054-9d09-40673fbd7e53


# ╔═╡ 804edec6-002a-4222-be18-980128e4cc98
Constraints = Dict(X1 =>[X2,X3,X4,X5,X6])

# ╔═╡ 7015cbe2-1c6e-459f-b403-1280d34f2535
push!(Constraints, X2 =>[X1,X5])

# ╔═╡ a6d188fc-944f-4d1c-af5c-cb4899fca89f
push!(Constraints, X3 =>[X1,X4])

# ╔═╡ 964892ac-c6be-4293-ab4a-8c2de60fd245
push!(Constraints, X4 =>[X1,X3,X5,X6])

# ╔═╡ 26c21f30-b379-4c7d-8c34-c02a42988548
push!(Constraints, X5 =>[X1,X2,X4,X6])

# ╔═╡ 168762cf-90ec-429c-b72f-694352c42b18
push!(Constraints, X6 =>[X1,X4,X5,X7])

# ╔═╡ c3108943-7ce7-4709-a76c-0370ee534f8f
push!(Constraints, X7=>[X6])

# ╔═╡ 208e21bd-8a1e-4afd-9981-f48af687759b
function Variable(object)
      initiate(self, name, domain)
      self.name = name
      self.domain = domain
end

# ╔═╡ f29dfea6-1e4d-48d6-972e-c282563a6bfd
 function Constraint2(object)
      initiate(self, variables)
      self.variables = variables
      check(self, values)
      return true
end


# ╔═╡ 831046bf-9b55-436a-b4cd-cbd1cd4ba567
 function AllDifferentConstraint(Constraint)
      check(self, values)
      if len(values) == 0
      return true
      end
      v = None
      for val in values
          if v == None
              v = val
          elseif val == v
             return false
          end
          return true
      end
end

# ╔═╡ 15349087-a1e6-48b7-a141-8962a127d3fc

      function AllEqualConstraint(Constraint)
      check(self, values)
      if len(values) == 0
         return true
      end
      v = values[0]
      for val in values
          if v != val
              return false
          end
          return true
      end
end

# ╔═╡ 74d09d1b-fe40-4fd4-a6d8-3f67367fe110

function Problem(object)
      initiate(self)
      self.variables = []
      self.constraints = []

      add_variable(self, variable)
      self.variables.append(variable)
      end

# ╔═╡ 3bab6f0f-04c2-4acf-a33a-3f07b896b82f
function Problem1(object)
	   add_constraint(self, constraint)
	      self.constraints.append(constraint)
	
	      
end

# ╔═╡ e4031509-84ab-4271-96b5-7e58a1c70894
function Problem2(object)
check_consisency(self, assignment)
      for constraint in self.constraints
          relevantValues = filter_dictionary(assignment, constraint, variables)
          if not constraint.check(dictionary_to_array(relevantValues))
              return false
          end
      return true
      end
end
      

# ╔═╡ ea129bf5-b876-4b71-999d-d718cfc35d7a
function Problem3(object)
find(self, assignment, _v)
      vars = _v.copy() #passed by reference create a copy
      if len(vars) === 0
         return [assignment]
      end
end
      

# ╔═╡ 9a288fa0-8489-42f4-abb2-8e913841918b
function Problem4(object)
var = vars.pop()
      results = []
      for option in var.domain
          new_assignment = union(assignmen, [ar.name: option])
          if self.check_consistency(new_assignment)
          res = self.find(new_assignment, vars)
          results += res
      return results
      end
      end
end

      

# ╔═╡ c02255cc-5ebb-4196-b9fb-dfd3a7b5d662
function Problem5(object)
get_Solutions(self)
      return self.find([], self.variables.copy())
  end

# ╔═╡ 88d7e4aa-3aa8-46c6-ab4b-22f545f78269
function Problem6(object)
var = vars.pop()
      results = []
      for option in var.domain
          new_assignment = union(assignmen, [var.name: option])
          if self.check_consistency(new_assignment)
          res = self.find(new_assignment, vars)
          results += res
      return results
      end
      end
end
      

# ╔═╡ 7cdc4678-4529-42d6-a6e4-887b85315799
function Problem7(object)
get_Solutions(self)
      return self.find([], self.variables.copy())
  end

# ╔═╡ Cell order:
# ╠═331d7de2-b19a-11eb-2606-37c1694eb9d9
# ╠═8f72d78b-74fd-4af5-8edb-99630ae39a22
# ╠═3879cce8-0d6b-4016-9a85-e49708485d6a
# ╠═55ae5d56-0038-4618-a422-e065dc4064f9
# ╠═1fbc0df1-5d4c-4dc4-8d53-9396fc6b4ac4
# ╠═c31392c8-0bf8-4855-8277-18e1fb58b5d8
# ╠═76700376-d7cf-4ac0-ad78-130740218434
# ╠═14cfc571-e623-401b-adfb-377e0f40e15d
# ╠═ab66b324-9550-407e-9296-eca56ab98bba
# ╠═62670d4a-3d90-495a-8bfe-e3d14be1ea68
# ╠═6cafa65b-59c3-4c04-8e1d-7d6da03755e1
# ╠═54372625-cadc-4146-ace7-421f95fcb1cf
# ╠═32eab809-d340-4ca6-9de0-ac0a67114cb8
# ╠═b81a0213-8e67-4304-9e44-bc5a7c8b004e
# ╠═5387037a-695f-4054-9d09-40673fbd7e53
# ╠═804edec6-002a-4222-be18-980128e4cc98
# ╠═7015cbe2-1c6e-459f-b403-1280d34f2535
# ╠═a6d188fc-944f-4d1c-af5c-cb4899fca89f
# ╠═964892ac-c6be-4293-ab4a-8c2de60fd245
# ╠═26c21f30-b379-4c7d-8c34-c02a42988548
# ╠═168762cf-90ec-429c-b72f-694352c42b18
# ╠═c3108943-7ce7-4709-a76c-0370ee534f8f
# ╠═208e21bd-8a1e-4afd-9981-f48af687759b
# ╠═f29dfea6-1e4d-48d6-972e-c282563a6bfd
# ╠═831046bf-9b55-436a-b4cd-cbd1cd4ba567
# ╠═15349087-a1e6-48b7-a141-8962a127d3fc
# ╠═74d09d1b-fe40-4fd4-a6d8-3f67367fe110
# ╠═3bab6f0f-04c2-4acf-a33a-3f07b896b82f
# ╠═e4031509-84ab-4271-96b5-7e58a1c70894
# ╠═ea129bf5-b876-4b71-999d-d718cfc35d7a
# ╠═9a288fa0-8489-42f4-abb2-8e913841918b
# ╠═c02255cc-5ebb-4196-b9fb-dfd3a7b5d662
# ╠═88d7e4aa-3aa8-46c6-ab4b-22f545f78269
# ╠═7cdc4678-4529-42d6-a6e4-887b85315799
