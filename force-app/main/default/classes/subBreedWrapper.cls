public with sharing class subBreedWrapper {
    public List<String> message; // A map to hold breed names and sub-breeds
    public String status; // For the status field

    public static subBreedWrapper parse(String json) {
        return (subBreedWrapper) System.JSON.deserialize(json, subBreedWrapper.class);
    }
}