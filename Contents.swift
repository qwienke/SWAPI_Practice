import UIKit


                                                    //People API
func fetchPeopleInfo() async throws ->  GetPeopleInfo {
    var urlComponents = URLComponents(string:
                                        "https://swapi.dev/api/people")!
    urlComponents.queryItems = [
        "results": ""
    ].map { URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from:
                                                                urlComponents.url!)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        print("error 404")
        throw getPeopleInfoError.itemNotFound
    }
    
    let jsonDecoder = JSONDecoder()
    let personInfo = try jsonDecoder.decode(GetPeopleInfo.self,
                                           from: data)
    print(personInfo)
    return (personInfo)
}

Task {
    do {
        let personInfo = try await fetchPeopleInfo()
        print("Successfully fetched PersonInfo: \(personInfo)")
    } catch {
        print("Fetch PersonInfo failed with error: \(error)")
    }
}

                                                //homeWorld api
func fetchHomeWorldInfo() async throws ->  HomeWorldResults{
    var urlComponents = URLComponents(string:
                                        "https://swapi.dev/api/planets/")!
    
    let (data, response) = try await URLSession.shared.data(from:                                                                       urlComponents.url!)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        print("error 404")
        throw getHomeWorldInfoError.itemNotFound
    }
    
    let jsonDecoder = JSONDecoder()
    let worldInfo = try jsonDecoder.decode(HomeWorldResults.self,
                                           from: data)
    print(worldInfo)
    return (worldInfo)
}

Task {
    do {
        let worldInfo = try await fetchHomeWorldInfo()
        print("Successfully fetched WorldInfo: \(worldInfo)")
    } catch {
        print("Fetch WorldInfo failed with error: \(error)")
    }
}


enum getPeopleInfoError: Error, LocalizedError {
    case itemNotFound
}
enum getHomeWorldInfoError: Error, LocalizedError {
    case itemNotFound
}

struct GetPeopleInfo: Codable {
    var results: [NewPeopleInfo]
}

struct NewPeopleInfo: Codable {
    var name: String
    var height: String
    var birthYear: String
    var homeworld: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case birthYear = "birth_year"
        case homeworld = "homeworld"
        
    }
}

struct HomeWorldResults: Codable {
    var results: [HomeWorld]
}

struct HomeWorld: Codable {
    var name: String
}











