
class StateService {

  static List<String> getSuggestions(String query,List<String> list) {
    List<String> matches = [];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
