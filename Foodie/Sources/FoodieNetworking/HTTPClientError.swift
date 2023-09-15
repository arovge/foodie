enum HTTPClientError: Error {
    case invalidCast
    case invalidStatusCode(actualStatusCode: Int)
    case requestFailure(Error)
    case decodingFailure(Error)
}
