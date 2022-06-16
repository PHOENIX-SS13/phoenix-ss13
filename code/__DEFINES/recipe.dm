#define RECIPE_COMPONENT(type) GLOB.recipe_components[type]
#define RECIPE_RESULT(type) GLOB.recipe_results[type]
#define RECIPE(type) GLOB.recipes[type]

// Appliance types
#define RECIPE_APPLIANCE_OVEN "Oven"

// Recipe priorities
#define RECIPE_PRIORITY_VERY_HIGH 4000
#define RECIPE_PRIORITY_HIGH 3000
#define RECIPE_PRIORITY_NORMAL 2000
#define RECIPE_PRIORITY_LOW 1000
#define RECIPE_PRIORITY_VERY_LOW 500

// Generic recipe conditionals
#define RECIPE_CONDITION_TEMPERATURE "temp"
