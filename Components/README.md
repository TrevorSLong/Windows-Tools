# Components
This part of the repository has smaller code snippets that are used in other scripts. Many of these components are reusable and could be helpful in many scripts.

### Registry-Change-Function
   * This is three functions that together can change or add registry entries.
   * It first checks to make sure the value exists, then it either adds or modifies the value.
   * It then checks to make sure that the value was successfully changed and outputs the results.
   * It checks to see if the path to the value exists and if it doesn't it **force** creates it
   * This tool can easily break the registry, check your paths and values carefully before running the script.

### Test-Regpath
   * This function allows a user to check whether a path in the registry exists
   * Optionally, the user can check whether a path exists at a per level basis

### Registry-Path-Validation
   * This function checks a registry path and checks to see if it exists, and if it doesn't it will output what part exists and what part doesn't.