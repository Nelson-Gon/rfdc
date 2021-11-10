# rfdc 0.1.1

**Major Changes**

* `set_api_key` can now retrieve an API key from a user's environment if it exists. 

* A `get_label_nutrients` call now allows users to get label nutrients for a given FDC ID. 

* `get_nutrients` now returns serving information. 

* Fixed issues with package documentation. See https://github.com/Nelson-Gon/rfdc/issues/1

* Refactored to suit newer API specifications

* Exported previously non exported key functions

# rfdc 0.1.0

**Available functions**

1. **set_api_key**


- Sets a session api key

2. **key_signup**

- A helper function to direct users to the api key signup page.

3. **get_api_key**

- Retrieves the session api key from .Globalenv

4. **get_food_details**

- Retrieves food details given a Food Data Central ID

5. **get_food_info**

- Gets information from a search query

6. **get_nutrients**

- Provides nutrients given a food data central ID

**Available Classes**

1. **FoodSearch**

- Interfaces the Food Data central search endpoint

2. **FoodDetails**

- interfaces the Food Data Central food details point