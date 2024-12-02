public class allBreeds {
    public Map<String, List<String>> message; // A map to hold breed names and sub-breeds
    public String status; // For the status field

    public static allBreeds parse(String json) {
        return (allBreeds) System.JSON.deserialize(json, allBreeds.class);
    }
}