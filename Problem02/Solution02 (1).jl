### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 9f28d4f5-b720-4b20-b2b9-65df20bfffef
using Pkg

# ╔═╡ 8dac89d7-5140-453d-966b-2d79cf9e3656
Pkg.activate("Problem_2_Assignment1.toml")

# ╔═╡ 265916b0-b198-11eb-1f44-d549e9faae87
using Markdown

# ╔═╡ bdd4e518-42cd-40bc-bc37-325aab151515
using InteractiveUtils

# ╔═╡ 68ea4a42-727d-4d3b-b18c-56df66a560ed
import Base.display;

# ╔═╡ 002e72e4-0bef-4361-ae16-ff245f2215c3
abstract type AbstractGame end;

# ╔═╡ f4f9809d-847f-430e-91df-7858e821bdd8
md"##### Game is an abstract game that contains an initial state.Games have a corresponding utility function, terminal test, set of legal moves, and transition model."

# ╔═╡ 1dbeabd3-89cd-457e-9173-02024f114b9d
struct Game <: AbstractGame
    initial::String

    function Game(initial_state::String)
        return new(initial_state);
    end
end

# ╔═╡ 5ff70250-393b-4285-bf69-c943ba70f65d
function actions(game::T, state::String) where {T <: AbstractGame}
    println("actions() is not implemented yet for ", typeof(game), "!");
    nothing;
end

# ╔═╡ b7bb95a9-67ad-4855-b92a-d8e7a8cc7619
function result(game::T, state::String, move::String) where {T <: AbstractGame}
    println("result() is not implemented yet for ", typeof(game), "!");
    nothing;
end

# ╔═╡ 1d36f442-f1e4-4c4b-a26e-5cd13f78a601
function utility(game::T, state::String, player::String) where {T <: AbstractGame}
    println("utility() is not implemented yet for ", typeof(game), "!");
    nothing;
end

# ╔═╡ cc8ac0d8-5e27-49db-bcf0-aacdbfbc8bfa
function to_move(game::T, state::String) where {T <: AbstractGame}
    println("to_move() is not implemented yet for ", typeof(game), "!");
    nothing;
end

# ╔═╡ e2252c2d-f147-4e2c-a856-9e78b4dcf63e
function display2(game::T, state::String) where {T <: AbstractGame}
    println(state);
end

# ╔═╡ 5ebc807d-5ced-4a8d-ab96-ef1f3a91fe07
struct TicTacToeState
    turn::String
    utility::Int64
    board::Dict
    moves::AbstractVector
end

# ╔═╡ 4c2a94f6-a1c7-4148-8254-9069a1901707
 function TicTacToeState2(turn::String, utility::Int64, board::Dict, moves::AbstractVector)
        return new(turn, utility, board, moves);
    end

# ╔═╡ 3bc94527-deb6-4c1b-aeba-fd4e269c5b07
md"##### TicTacToeGame is a AbstractGame implementation of the Tic-tac-toe game."

# ╔═╡ 6ea920ac-963b-44dd-b10d-7aa0396618fb
struct TicTacToeGame <: AbstractGame
    initial::TicTacToeState
    h::Int64
    v::Int64
    k::Int64

    function TicTacToeGame(initial::TicTacToeState)
        return new(initial, 3, 3, 3);
    end
end

# ╔═╡ f2da56f6-dc26-44c8-b202-c049e2c7306b
 function TicTacToeGame2()
        return new(TicTacToeState("X", 0, Dict(), collect((x, y) for x in 1:3 for y in 1:3)), 3, 3, 3);
    end


# ╔═╡ 0190c90c-c9e3-42fa-aae6-adfd308c7816
function actions(game::TicTacToeGame, state::TicTacToeState)
    return state.moves;
end

# ╔═╡ cda50c23-2878-4d46-b95d-898107c10974
function utility(game::TicTacToeGame, state::TicTacToeState, player::String)
    return if_((player == "X"), state.utility, -state.utility);
end

# ╔═╡ df80b03b-5548-4e30-ab5b-fd9f3ee6d71e
function terminal_test(game::TicTacToeGame, state::TicTacToeState)
    return ((state.utility != 0) || (length(state.moves) == 0));
end

# ╔═╡ ab949a00-0bc3-42f2-be55-0f32956a7414
function to_move(game::TicTacToeGame, state::TicTacToeState)
    return state.turn;
end

# ╔═╡ 348968b4-593b-4f91-9fdf-ba712a96a837
function display3(game::TicTacToeGame, state::TicTacToeState)
    for x in 1:game.h
        for y in 1:game.v
            print(get(state.board, (x, y), "."));
        end
        println();
    end
end

# ╔═╡ 28272400-fd4c-4a5c-be43-b8f4e52357da
function k_in_row(game::TicTacToeGame, board::Dict, move::Tuple{Signed, Signed}, player::String, delta::Tuple{Signed, Signed})
    local delta_x::Int64 = Int64(getindex(delta, 1));
    local delta_y::Int64 = Int64(getindex(delta, 2));
    local x::Int64 = Int64(getindex(move, 1));
    local y::Int64 = Int64(getindex(move, 2));
    local n::Int64 = Int64(0);
    while (get(board, (x,y), nothing) == player)
        n = n + 1;
        x = x + delta_x;
        y = y + delta_y;
    end
    x = Int64(getindex(move, 1));
    y = Int64(getindex(move, 2));
    while (get(board, (x,y), nothing) == player)
        n = n + 1;
        x = x - delta_x;
        y = y - delta_y;
    end
    n = n - 1;  #remove the duplicate check on get(board, move, nothing)
    return n >= game.k;
end

# ╔═╡ c981521c-1a2f-4a37-9252-4faaf5bf68b4
const ConnectFourState = TicTacToeState;

# ╔═╡ a1361951-c07a-4a19-ae21-bb88daee78c2
struct ConnectFourGame <: AbstractGame
    initial::ConnectFourState
    h::Int64
    v::Int64
    k::Int64

    function ConnectFourGame(initial::ConnectFourState)
        return new(initial, 3, 3, 3);
    end

    function ConnectFourGame()
        return new(ConnectFourState("X", 0, Dict(), collect((x, y) for x in 1:7 for y in 1:6)), 7, 6, 4);
    end
end

# ╔═╡ d7299d9f-7801-4893-9d50-3e9a5d533ae0
function actions(game::ConnectFourGame, state::ConnectFourState)
    return collect((x,y) for (x, y) in state.moves if ((y == 0) || ((x, y - 1) in state.board)));
end

# ╔═╡ a817499e-b367-4ab9-8ff7-26bc57b18081
function terminal_test(game::T, state::String) where {T <: AbstractGame}
    if (length(actions(game, state)) == 0)
        return true;
    else
        return false;
    end
end

# ╔═╡ 3c89178e-9ec9-4700-9465-e7961dff8f25
function utility(game::ConnectFourGame, state::ConnectFourState, player::String)
    return if_((player == "X"), state.utility, -state.utility);
end

# ╔═╡ cb7c831b-9298-48b3-a350-f4511974623c
function terminal_test(game::ConnectFourGame, state::ConnectFourState)
    return ((state.utility != 0) || (length(state.moves) == 0));
end

# ╔═╡ 39551a48-c3f2-4101-8074-4b0ce32c5988
function to_move(game::ConnectFourGame, state::ConnectFourState)
    return state.turn;
end

# ╔═╡ 9a407d72-5ab2-4d34-a530-9ac3a120cd79
function display4(game::ConnectFourGame, state::ConnectFourState)
    for x in 1:game.h
        for y in 1:game.v
            print(get(state.board, (x, y), "."));
        end
        println();
    end
end

# ╔═╡ 42b40e20-9f90-448a-904f-115c17920017
function k_in_row(game::ConnectFourGame, board::Dict, move::Tuple{Signed, Signed}, player::String, delta::Tuple{Signed, Signed})
    local delta_x::Int64 = Int64(getindex(delta, 1));
    local delta_y::Int64 = Int64(getindex(delta, 2));
    local x::Int64 = Int64(getindex(move, 1));
    local y::Int64 = Int64(getindex(move, 2));
    local n::Int64 = Int64(0);
    while (get(board, (x,y), nothing) == player)
        n = n + 1;
        x = x + delta_x;
        y = y + delta_y;
    end
    x = Int64(getindex(move, 1));
    y = Int64(getindex(move, 2));
    while (get(board, (x,y), nothing) == player)
        n = n + 1;
        x = x - delta_x;
        y = y - delta_y;
    end
    n = n - 1;  #remove the duplicate check on get(board, move, nothing)
    return n >= game.k;
end

# ╔═╡ b7a31928-fd9e-48e9-97e3-4c761d0816c3
function compute_utility(game::TicTacToeGame, board::Dict, move::Tuple{Signed, Signed}, player::String)
    if (k_in_row(game, board, move, player, (0, 1)) ||
        k_in_row(game, board, move, player, (1, 0)) ||
        k_in_row(game, board, move, player, (1, -1)) ||
        k_in_row(game, board, move, player, (1, 1)))
        return if_((player == "X"), 1, -1);
    else
        return 0;
    end
end

# ╔═╡ ea372758-61df-40de-baec-a41c10f3ab79
function compute_utility(game::ConnectFourGame, board::Dict, move::Tuple{Signed, Signed}, player::String)
    if (k_in_row(game, board, move, player, (0, 1)) ||
        k_in_row(game, board, move, player, (1, 0)) ||
        k_in_row(game, board, move, player, (1, -1)) ||
        k_in_row(game, board, move, player, (1, 1)))
        return if_((player == "X"), 1, -1);
    else
        return 0;
    end
end

# ╔═╡ 579ce6ab-4d55-4401-b013-de537cbaa193
function result(game::TicTacToeGame, state::TicTacToeState, move::Tuple{Signed, Signed})
    if (!(move in state.moves))
        return state;
    end
    local board::Dict = copy(state.board);
    board[move] = state.turn;
    local moves::Array{eltype(state.moves), 1} = collect(state.moves);
    for (i, element) in enumerate(moves)
        if (element == move)
            deleteat!(moves, i);
            break;
        end
    end
    return TicTacToeState(if_((state.turn == "X"), "O", "X"), compute_utility(game, board, move, state.turn), board, moves);
end

# ╔═╡ 0d4e7fe5-4908-4a7a-b070-4b6e730fed6c
function result(game::ConnectFourGame, state::ConnectFourState, move::Tuple{Signed, Signed})
    if (!(move in state.moves))
        return state;
    end
    local board::Dict = copy(state.board);
    board[move] = state.turn;
    local moves::Array{eltype(state.moves), 1} = collect(state.moves);
    for (i, element) in enumerate(moves)
        if (element == move)
            deleteat!(moves, i);
            break;
        end
    end
    return ConnectFourState(if_((state.turn == "X"), "O", "X"), compute_utility(game, board, move, state.turn), board, moves);
end

# ╔═╡ 49e38824-8f5f-48d1-8598-694ec543925a
function minimax_max_value(game::T, player::String, state::String) where {T <: AbstractGame}
    if (terminal_test(game, state))
        return utility(game, state, player)
    end
    local v::Float64 = -Inf64;
    v = reduce(max, vcat(v, collect(minimax_min_value(game, player, result(game, state, action))
                                    for action in actions(game, state))));
    return v;
end

# ╔═╡ f544f129-c544-4b82-b054-0830bec1a2b2
function minimax_min_value2(game::T, player::String, state::String) where {T <: AbstractGame}
    if (terminal_test(game, state))
        return utility(game, state, player);
    end
    local v::Float64 = Inf64;
    v = reduce(min, vcat(v, collect(minimax_max_value(game, player, result(game, state, action))
                                    for action in actions(game, state))));
    return v;
end

# ╔═╡ 4bade6c0-e116-4e4e-be4b-9f02d6111eff
function minimax_decision(state::String, game::T) where {T <: AbstractGame}
    local player = to_move(game, state);
    return argmax(actions(game, state),
                    (function(action::String,; relevant_game::AbstractGame=game, relevant_player::String=player, relevant_state::String=state)
                        return minimax_min_value(relevant_game, relevant_player, result(relevant_game, relevant_state, action));
                    end));
end

# ╔═╡ 99dff64a-1eb9-4942-be46-d67034f740ac
function alphabeta_full_search_max_value(game::T, player::String, state::String, alpha::Number, beta::Number) where {T <: AbstractGame}
	if (terminal_test(game, state))
		return utility(game, state, player)
	end
	local v::Float64 = -Inf64;
	for action in actions(game, state)
		v = max(v, alphabeta_full_search_min_value(game, player, result(game, state, action), alpha, beta));
        if (v >= beta)
            return v;
        end
        alpha = max(alpha, v);
	end
	return v;
end

# ╔═╡ 3f184d9f-4fb6-4860-8e64-36626cf2cccb
function alphabeta_full_search_min_value2(game::T, player::String, state::String, alpha::Number, beta::Number) where {T <: AbstractGame}
    if (terminal_test(game, state))
        return utility(game, state, player);
    end
    local v::Float64 = Inf64;
    for action in actions(game, state)
        v = min(v, alphabeta_full_search_max_value(game, player, result(game, state, action), alpha, beta));
        if (v <= alpha)
            return v;
        end
        beta = min(beta, v);
    end
    return v;
end

# ╔═╡ d5c0ec3c-6070-41bd-8092-2bd0d566ae00
function alphabeta_full_search(state::String, game::T) where {T <: AbstractGame}
	local player::String = to_move(game, state);
    return argmax(actions(game, state), 
                    (function(action::String,; relevant_game::AbstractGame=game, relevant_state::String=state, relevant_player::String=player)
                        return alphabeta_full_search_min_value(relevant_game, relevant_player, result(relevant_game, relevant_state, action), -Inf64, Inf64);
                    end));
end

# ╔═╡ e88d256d-f335-4e8b-8d5b-c9fb54193bee
function alphabeta_search_min_value(game::T, player::String, cutoff_test_fn::Function, evaluation_fn::Function, state::String, alpha::Number, beta::Number, depth::Int64) where {T <: AbstractGame}
    if (cutoff_test_fn(state, depth))
        return evaluation_fn(state);
    end
    local v::Float64 = Inf64;
    for action in actions(game, state)
        v = min(v, alphabeta_search_max_value(game, player, cutoff_test_fn, evaluation_fn, result(game, state, action), alpha, beta, depth + 1));
        if (v >= alpha)
            return v;
        end
        beta = min(alpha, v);
    end
    return v;
end

# ╔═╡ 7680b08a-616b-45a7-80ca-cc299c12903b
function alphabeta_search_min_value(game::T, player::String, cutoff_test_fn::Function, evaluation_fn::Function, state::TicTacToeState, alpha::Number, beta::Number, depth::Int64) where {T <: AbstractGame}
    if (cutoff_test_fn(state, depth))
        return evaluation_fn(state);
    end
    local v::Float64 = Inf64;
    for action in actions(game, state)
        v = min(v, alphabeta_search_max_value(game, player, cutoff_test_fn, evaluation_fn, result(game, state, action), alpha, beta, depth + 1));
        if (v >= alpha)
            return v;
        end
        beta = min(alpha, v);
    end
    return v;
end

# ╔═╡ 9964ae2d-cab7-4ca2-9ae5-2f0c8bda346c
function alphabeta_search_max_value2(game::T, player::String, cutoff_test_fn::Function, evaluation_fn::Function, state::String, alpha::Number, beta::Number, depth::Int64) where {T <: AbstractGame}
    if (cutoff_test_fn(state, depth))
        return evaluation_fn(state);
    end
    local v::Float64 = -Inf64;
    for action in actions(game, state)
        v = max(v, alphabeta_search_min_value(game, player, cutoff_test_fn, evaluation_fn, result(game, state, action), alpha, beta, depth + 1));
        if (v >= beta)
            return v;
        end
        alpha = max(alpha, v);
    end
    return v;
end

# ╔═╡ 2d3e5525-3f79-403d-8291-45f19c031d2b
function alphabeta_search_max_value2(game::T, player::String, cutoff_test_fn::Function, evaluation_fn::Function, state::TicTacToeState, alpha::Number, beta::Number, depth::Int64) where {T <: AbstractGame}
    if (cutoff_test_fn(state, depth))
        return evaluation_fn(state);
    end
    local v::Float64 = -Inf64;
    for action in actions(game, state)
        v = max(v, alphabeta_search_min_value(game, player, cutoff_test_fn, evaluation_fn, result(game, state, action), alpha, beta, depth + 1));
        if (v >= beta)
            return v;
        end
        alpha = max(alpha, v);
    end
    return v;
end

# ╔═╡ f8204c8c-8bd1-4f47-b4a6-d0e2d020e8fa
function alphabeta_search(state::String, game::T; d::Int64=4, cutoff_test_fn::Union{Nothing, Function}=nothing, evaluation_fn::Union{Nothing, Function}=nothing) where {T <: AbstractGame}
    local player::String = to_move(game, state);
    if (typeof(cutoff_test_fn) <: Nothing)
        cutoff_test_fn = (function(state::String, depth::Int64; dvar::Int64=d, relevant_game::AbstractGame=game)
                            return ((depth > dvar) || terminal_test(relevant_game, state));
                        end);
    end
    if (typeof(evaluation_fn) <: Nothing)
        evaluation_fn = (function(state::String, ; relevant_game::AbstractGame=game, relevant_player::String=player)
                            return utility(relevant_game, state, relevant_player);
                        end);
    end
    return argmax(actions(game, state),
                    (function(action::String,; relevant_game::AbstractGame=game, relevant_state::String=state, relevant_player::String=player, cutoff_test::Function=cutoff_test_fn, eval_fn::Function=evaluation_fn)
                        return alphabeta_search_min_value(relevant_game, relevant_player, cutoff_test, eval_fn, result(relevant_game, relevant_state, action), -Inf64, Inf64, 0);
                    end));
end

# ╔═╡ 2e015cfc-d38a-45eb-86e5-85ade3b9e0a4
function alphabeta_search(state::TicTacToeState, game::T; d::Int64=4, cutoff_test_fn::Union{Nothing, Function}=nothing, evaluation_fn::Union{Nothing, Function}=nothing) where {T <: AbstractGame}
    local player::String = to_move(game, state);
    if (typeof(cutoff_test_fn) <: Nothing)
        cutoff_test_fn = (function(state::TicTacToeState, depth::Int64; dvar::Int64=d, relevant_game::AbstractGame=game)
                            return ((depth > dvar) || terminal_test(relevant_game, state));
                        end);
    end
    if (typeof(evaluation_fn) <: Nothing)
        evaluation_fn = (function(state::TicTacToeState, ; relevant_game::AbstractGame=game, relevant_player::String=player)
                            return utility(relevant_game, state, relevant_player);
                        end);
    end
    return argmax(actions(game, state),
                    (function(action::Tuple{Signed, Signed},; relevant_game::AbstractGame=game, relevant_state::TicTacToeState=state, relevant_player::String=player, cutoff_test::Function=cutoff_test_fn, eval_fn::Function=evaluation_fn)
                        return alphabeta_search_min_value(relevant_game, relevant_player, cutoff_test, eval_fn, result(relevant_game, relevant_state, action), -Inf64, Inf64, 0);
                    end));
end

# ╔═╡ b17bfdb2-2c18-41c2-8de7-3c54ccb2b457
function random_player(game::T, state::String) where {T <: AbstractGame}
    return rand(RandomDeviceInstance, actions(game, state));
end

# ╔═╡ 37b0b29b-a37c-40a1-9492-80b10f342eb2
function random_player(game::T, state::TicTacToeState) where {T <: AbstractGame}
    return rand(RandomDeviceInstance, actions(game, state));
end

# ╔═╡ c6d50f68-3dc7-4991-8b8b-fcef912f26ef
function alphabeta_player(game::T, state::String) where {T <: AbstractGame}
    return alphabeta_search(state, game);
end

# ╔═╡ 1a647ab9-f873-49fc-9694-03a069d81f06
function alphabeta_player(game::T, state::TicTacToeState) where {T <: AbstractGame}
    return alphabeta_search(state, game);
end

# ╔═╡ 96dda2f6-0aca-4735-88fc-393f94069228
function play_game(game::T, players::Vararg{Function}) where {T <: AbstractGame}
    state = game.initial;
    while (true)
        for player in players
            move = player(game, state);
            state = result(game, state, move);
            if (terminal_test(game, state))
                return utility(game, state, to_move(game, game.initial));
            end
        end
    end
end

# ╔═╡ 8a5a1e5b-cd17-4a4c-a4dd-a3c5da412efd
export AbstractGame, Figure52Game, TicTacToeGame, ConnectFourGame,
        TicTacToeState, ConnectFourState,
        minimax_decision, alphabeta_full_search, alphabeta_search,
        display,
        random_player, alphabeta_player, play_game;

# ╔═╡ Cell order:
# ╠═265916b0-b198-11eb-1f44-d549e9faae87
# ╠═bdd4e518-42cd-40bc-bc37-325aab151515
# ╠═9f28d4f5-b720-4b20-b2b9-65df20bfffef
# ╠═8dac89d7-5140-453d-966b-2d79cf9e3656
# ╠═68ea4a42-727d-4d3b-b18c-56df66a560ed
# ╠═8a5a1e5b-cd17-4a4c-a4dd-a3c5da412efd
# ╠═002e72e4-0bef-4361-ae16-ff245f2215c3
# ╠═f4f9809d-847f-430e-91df-7858e821bdd8
# ╠═1dbeabd3-89cd-457e-9173-02024f114b9d
# ╠═5ff70250-393b-4285-bf69-c943ba70f65d
# ╠═b7bb95a9-67ad-4855-b92a-d8e7a8cc7619
# ╠═1d36f442-f1e4-4c4b-a26e-5cd13f78a601
# ╠═a817499e-b367-4ab9-8ff7-26bc57b18081
# ╠═cc8ac0d8-5e27-49db-bcf0-aacdbfbc8bfa
# ╠═e2252c2d-f147-4e2c-a856-9e78b4dcf63e
# ╠═5ebc807d-5ced-4a8d-ab96-ef1f3a91fe07
# ╠═4c2a94f6-a1c7-4148-8254-9069a1901707
# ╠═3bc94527-deb6-4c1b-aeba-fd4e269c5b07
# ╠═6ea920ac-963b-44dd-b10d-7aa0396618fb
# ╠═f2da56f6-dc26-44c8-b202-c049e2c7306b
# ╠═0190c90c-c9e3-42fa-aae6-adfd308c7816
# ╠═579ce6ab-4d55-4401-b013-de537cbaa193
# ╠═cda50c23-2878-4d46-b95d-898107c10974
# ╠═df80b03b-5548-4e30-ab5b-fd9f3ee6d71e
# ╠═ab949a00-0bc3-42f2-be55-0f32956a7414
# ╠═348968b4-593b-4f91-9fdf-ba712a96a837
# ╠═b7a31928-fd9e-48e9-97e3-4c761d0816c3
# ╠═28272400-fd4c-4a5c-be43-b8f4e52357da
# ╠═c981521c-1a2f-4a37-9252-4faaf5bf68b4
# ╠═a1361951-c07a-4a19-ae21-bb88daee78c2
# ╠═d7299d9f-7801-4893-9d50-3e9a5d533ae0
# ╠═0d4e7fe5-4908-4a7a-b070-4b6e730fed6c
# ╠═3c89178e-9ec9-4700-9465-e7961dff8f25
# ╠═cb7c831b-9298-48b3-a350-f4511974623c
# ╠═39551a48-c3f2-4101-8074-4b0ce32c5988
# ╠═9a407d72-5ab2-4d34-a530-9ac3a120cd79
# ╠═ea372758-61df-40de-baec-a41c10f3ab79
# ╠═42b40e20-9f90-448a-904f-115c17920017
# ╠═49e38824-8f5f-48d1-8598-694ec543925a
# ╠═f544f129-c544-4b82-b054-0830bec1a2b2
# ╠═4bade6c0-e116-4e4e-be4b-9f02d6111eff
# ╠═99dff64a-1eb9-4942-be46-d67034f740ac
# ╠═3f184d9f-4fb6-4860-8e64-36626cf2cccb
# ╠═d5c0ec3c-6070-41bd-8092-2bd0d566ae00
# ╠═9964ae2d-cab7-4ca2-9ae5-2f0c8bda346c
# ╠═2d3e5525-3f79-403d-8291-45f19c031d2b
# ╠═e88d256d-f335-4e8b-8d5b-c9fb54193bee
# ╠═7680b08a-616b-45a7-80ca-cc299c12903b
# ╠═f8204c8c-8bd1-4f47-b4a6-d0e2d020e8fa
# ╠═2e015cfc-d38a-45eb-86e5-85ade3b9e0a4
# ╠═b17bfdb2-2c18-41c2-8de7-3c54ccb2b457
# ╠═37b0b29b-a37c-40a1-9492-80b10f342eb2
# ╠═c6d50f68-3dc7-4991-8b8b-fcef912f26ef
# ╠═1a647ab9-f873-49fc-9694-03a069d81f06
# ╠═96dda2f6-0aca-4735-88fc-393f94069228
