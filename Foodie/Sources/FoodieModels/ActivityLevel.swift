// More information found at:
// https://www.medicalnewstoday.com/articles/319731#calculating-how-many-calories-are-burned-in-a-day

public enum ActivityLevel: Int, CaseIterable {
    case barelyActive = 1
    case slightlyActive = 2
    case moderativelyActive = 3
    case veryActive = 4
    case extraActive = 5
    
    var description: String {
        switch self {
        case .barelyActive:
            "A person who does little to no exercise"
        case .slightlyActive:
            "A slightly active person who does light exercise 1–3 days a week"
        case .moderativelyActive:
            "A moderately active person who performs moderate exercise 3–5 days a week"
        case .veryActive:
            "A very active person who exercises hard 6–7 days a week"
        case .extraActive:
            "An extra active person who either has a physically demanding job or has a particularly challenging exercise routine"
        }
    }
    
    public var bmrPoints: Double {
        switch self {
        case .barelyActive:
            1.2
        case .slightlyActive:
            1.37
        case .moderativelyActive:
            1.55
        case .veryActive:
            1.725
        case .extraActive:
            1.9
        }
    }
}
