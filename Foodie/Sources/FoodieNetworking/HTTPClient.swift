import Foundation

public class HTTPClient {
    private let base: URL = URL(string: "https://api.ajr.dev/foodie")!
    private let acceptableStatusCodes: Set<Int> = Set(200...300)

    public func getFood(barcode: String) async throws -> Food? {
        try await request("/food/barcode/\(barcode)", method: .get)
    }
    
    private func request<T: Codable>(_ route: String, method: HTTPMethod) async throws -> T {
        let url = base.appending(path: route)
        
        let (data, response) = try await send(url: url)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidCast
        }
        guard acceptableStatusCodes.contains(urlResponse.statusCode) else {
            throw HTTPClientError.invalidStatusCode(actualStatusCode: urlResponse.statusCode)
        }
        return try decode(from: data)
    }
    
    private func send(url: URL) async throws -> (Data, URLResponse) {
        do {
            return try await URLSession.shared.data(from: url)
        } catch {
            print(error)
            throw HTTPClientError.requestFailure(error)
        }
    }
    
    private func decode<T: Codable>(from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            throw HTTPClientError.decodingFailure(error)
        }
    }
}
