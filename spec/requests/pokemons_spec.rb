require "rails_helper"

describe 'Pokemon API testing', type: :request do
    describe 'GET /pokemons' do
        before do
            FactoryBot.create(
                :pokemon,
                name: "My Pokemon 1",
                type1: "My type 1",
                type2: "My type 2",
                total: 2,
                hp: 3,
                attack: 23,
                defense: 34,
                spatk: 3,
                spdef: 4,
                speed: 7,
                generation: 1,
                legendary: false
            )
            FactoryBot.create(
                :pokemon,
                name: "My Pokemon 2",
                type1: "My type 1",
                type2: "My type 2",
                total: 2,
                hp: 3,
                attack: 23,
                defense: 34,
                spatk: 3,
                spdef: 4,
                speed: 7,
                generation: 1,
                legendary: false
            )
        end

        it 'return all pokemons' do
            get '/api/v1/pokemons'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
            expect(JSON.parse(response.body)).to eq(
                [
                    {
                        "id" => 1,
                        "name" => "My Pokemon 1",
                        "type1" => "My type 1",
                        "type2" => "My type 2",
                        "total" => 2,
                        "hp" => 3,
                        "attack" => 23,
                        "defense" => 34,
                        "spatk" => 3,
                        "spdef" => 4,
                        "speed" => 7,
                        "generation" => 1,
                        "legendary" => false
                    },
                    {
                        "id" => 2,
                        "name" => "My Pokemon 2",
                        "type1" => "My type 1",
                        "type2" => "My type 2",
                        "total" => 2,
                        "hp" => 3,
                        "attack" => 23,
                        "defense" => 34,
                        "spatk" => 3,
                        "spdef" => 4,
                        "speed" => 7,
                        "generation" => 1,
                        "legendary" => false
                    }
                ]
            )
        end
        it 'return pokemons limit per page' do
            get '/api/v1/pokemons', params: { per_page: 1 }

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                [
                    {
                        "id" => 1,
                        "name" => "My Pokemon 1",
                        "type1" => "My type 1",
                        "type2" => "My type 2",
                        "total" => 2,
                        "hp" => 3,
                        "attack" => 23,
                        "defense" => 34,
                        "spatk" => 3,
                        "spdef" => 4,
                        "speed" => 7,
                        "generation" => 1,
                        "legendary" => false
                    }
                ]
            )
        end
        it 'return pokemons limit per page and offset' do
            get '/api/v1/pokemons', params: { per_page: 1, offset: 1 }

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                [
                    {
                        "id" => 2,
                        "name" => "My Pokemon 2",
                        "type1" => "My type 1",
                        "type2" => "My type 2",
                        "total" => 2,
                        "hp" => 3,
                        "attack" => 23,
                        "defense" => 34,
                        "spatk" => 3,
                        "spdef" => 4,
                        "speed" => 7,
                        "generation" => 1,
                        "legendary" => false
                    }
                ]
            )
        end
        it 'return pokemons max limit (10) per page' do
            FactoryBot.create(:pokemon, name: "My Pokemon 3")
            FactoryBot.create(:pokemon, name: "My Pokemon 4")
            FactoryBot.create(:pokemon, name: "My Pokemon 5")
            FactoryBot.create(:pokemon, name: "My Pokemon 6")
            FactoryBot.create(:pokemon, name: "My Pokemon 7")
            FactoryBot.create(:pokemon, name: "My Pokemon 8")
            FactoryBot.create(:pokemon, name: "My Pokemon 9")
            FactoryBot.create(:pokemon, name: "My Pokemon 10")
            FactoryBot.create(:pokemon, name: "My Pokemon 11")
            FactoryBot.create(:pokemon, name: "My Pokemon 12")

            expect(Pokemon.count).to eq(12)
            get '/api/v1/pokemons'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(10)
        end
    end

    describe 'GET /pokemons/:id' do
        it 'return a pokemon by id' do
            pokemon1 = FactoryBot.create(
                :pokemon,
                name: "My Pokemon Name",
                type1: "My type 1",
                type2: "My type 2",
                total: 2,
                hp: 3,
                attack: 23,
                defense: 34,
                spatk: 3,
                spdef: 4,
                speed: 7,
                generation: 1,
                legendary: false
            )
            get "/api/v1/pokemons/#{pokemon1.id}"

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)).to eq(
                {
                    "id" => 1,
                    "name" => "My Pokemon Name",
                    "type1" => "My type 1",
                    "type2" => "My type 2",
                    "total" => 2,
                    "hp" => 3,
                    "attack" => 23,
                    "defense" => 34,
                    "spatk" => 3,
                    "spdef" => 4,
                    "speed" => 7,
                    "generation" => 1,
                    "legendary" => false
                }
            )
        end
    end

    describe 'POST /pokemons' do
        it 'create a new pokemon' do
            expect {
                post '/api/v1/pokemons', params: {
                    pokemon: {
                        name: "My Pokemon Name",
                        type1: "My type 1",
                        type2: "My type 2",
                        total: 2,
                        hp: 3,
                        attack: 23,
                        defense: 34,
                        spatk: 3,
                        spdef: 4,
                        speed: 7,
                        generation: 1,
                        legendary: false
                    }
                }
            }.to change { Pokemon.count }.from(0).to(1)
            expect(JSON.parse(response.body)).to eq(
                {
                    "id" => 1,
                    "name" => "My Pokemon Name",
                    "type1" => "My type 1",
                    "type2" => "My type 2",
                    "total" => 2,
                    "hp" => 3,
                    "attack" => 23,
                    "defense" => 34,
                    "spatk" => 3,
                    "spdef" => 4,
                    "speed" => 7,
                    "generation" => 1,
                    "legendary" => false
                }
            )
        end
    end

    describe 'PUT /pokemons' do
        it 'Update a entier existing pokemon' do
            pokemon = FactoryBot.create(:pokemon, name: "My Pokemon1")
            put "/api/v1/pokemons/#{pokemon.id}", params: {
                pokemon: {
                    name: "Update Pokemon PUT",
                    type1: "Type 1 - Updated",
                    type2: "My type 2",
                    total: 2,
                    hp: 3,
                    attack: 23,
                    defense: 34,
                    spatk: 3,
                    spdef: 4,
                    speed: 7,
                    generation: 1,
                    legendary: false
                }
            }

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).to eq(
                {
                    "id" => 1,
                    "name" => "Update Pokemon PUT",
                    "type1" => "Type 1 - Updated",
                    "type2" => "My type 2",
                    "total" => 2,
                    "hp" => 3,
                    "attack" => 23,
                    "defense" => 34,
                    "spatk" => 3,
                    "spdef" => 4,
                    "speed" => 7,
                    "generation" => 1,
                    "legendary" => false
                }
            )
        end
    end

    describe 'DELETE /pokemons' do
        it 'delete a existing pokemon' do
            pokemon = FactoryBot.create(:pokemon, name: "My Pokemon1")
            expect {
                delete "/api/v1/pokemons/#{pokemon.id}"
            }.to change { Pokemon.count }.from(1).to(0)
            expect(response).to have_http_status(:no_content)
        end
    end

end