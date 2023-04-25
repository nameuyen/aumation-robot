from robot.libraries.BuiltIn import BuiltIn
import json
from selenium.webdriver.common.by import By
import time
from datetime import datetime
import requests
from selenium.webdriver.common.action_chains import ActionChains
from selenium.common.exceptions import NoSuchElementException
# import CustomListener

class ElementHandler:
    def get_element_by_xpath(self, locator):
        locator = locator.replace("xpath:","")
        return self._driver.find_element(By.XPATH, locator)

    def get_child_element_by_xpath(self, locator, xpath_selector):
        return locator.find_element(By.XPATH, xpath_selector)

    def get_child_elements_by_xpath(self, locator, xpath_selector):
        return locator.find_elements(By.XPATH, xpath_selector)

    def get_elements_by_tag_name(self,locator, tag_name):
        elements=locator.find_elements(By.TAG_NAME,tag_name)
        return elements

    def get_elements_by_child_is_tag_name(self, locator, tag_name):
        if("xpath" in locator):
            locator= self.get_element_by_xpath(locator)
        elements= self.get_elements_by_tag_name(locator, tag_name)
        return elements

    def get_elements_by_css_selector(self, css_selector):
        return self._driver.find_elements(By.CSS_SELECTOR, css_selector)

    def get_child_element_by_css_selector(self, locator, css_selector):
        element= locator.find_element(By.CSS_SELECTOR, css_selector)
        return element

    def get_child_elements_by_css_selector(self, locator, css_selector):
        elements= locator.find_elements(By.CSS_SELECTOR, css_selector)
        return elements

    def get_element_by_value_on_list(self, list_elements, value):
        for element in list_elements:
            if(element.text == value):
                return element

    def get_css_value_property(self, locator, css_property):
        return locator.value_of_css_property(css_property)

    def value_of_element_should_be_correct(self, element, value):
        if(element.text == value):
               return True
        return False

    def get_from_list_with_check_if_existing_index(self, list_elements, index):
        index= int(index)
        if(index < len(list_elements)):
            return list_elements[index]
        else:
            return []

    def get_nth_parent_element(self, element, nth):
        for i in range(int(nth)):
             element= element.find_element(By.XPATH, "..")
        return element

    def hover_to_an_element(self, element):
        action=  ActionChains(self._driver)
        action.move_to_element(element).perform()

    def get_previous_sibling_element(self, element, tag_name="div", exceptions_value="MenuItems"):
        try:
           pre_sibling_el = element.find_element(By.XPATH, "preceding-sibling::"+tag_name)
           return pre_sibling_el.text
        except NoSuchElementException:
            return exceptions_value

    def get_next_sibling_element(self, element, tag_name="div"):
        next_sibling_el = element.find_element(By.XPATH, "following-sibling::"+tag_name)
        return next_sibling_el


class DateTimeHelper:
    def convert_date_to_string(self):
        now = datetime.now()
        return now.strftime("%d%m%Y%H%M%S")

class SessionStorageHandler:
    def _get_list_keys_session_storage(self):
        return self._driver.execute_script( \
            "var ls = window.sessionStorage, keys = []; " \
            "for (var i = 0; i < ls.length; ++i) " \
            "  keys[i] = ls.key(i); " \
            "return keys; ")

    def is_contain_key_in_session_storage(self, key):
        return key in self._get_list_keys_session_storage()

    def get_session_storage_value(self,key):
        item= self._driver.execute_script("return window.sessionStorage.getItem('{}');".format(key))
        return json.loads(item)   #Convert string to dictionary

class ApiHelper:
    def get_response_value(self, url):
        response = requests.get(url, verify=False)
        json_response= response.json()
        json_response_value=  json.dumps(json_response.get('value'))
        return json_response_value

    def get_session_timeout(self, url, ro):
        list_response = self.get_response_value(url)
        list_response = json.loads(list_response)
        for i in range(0,len(list_response)) :
            if(list_response[i]['']==ro):
                if(list_response[i].get('')!=None):
                    session_timeout= list_response[i]['']
                else:
                    session_timeout = "No Timeout"
        return session_timeout

    def set_session_timeout(self, url, ro, timeout):
        list_response = self.get_response_value(url)
        list_response = json.loads(list_response)
        for i in range(0,len(list_response)) :
            if(list_response[i]['']==ro):
                list_response[i][''] = timeout
        json_data = json.dumps(list_response)
        requests.post(url, json_data, verify=False)

    def set_data_api(self,url,data):
        post_result = True
        r= requests.post(url,data,verify=False)
        if(r.status_code)!= 200:
            post_result = False
        return post_result

class FileHandler:
    def get_item_has_attr_equal_value_from_json(self, json_data, attr, attr_value):
        list_data=[]
        json_data= self.change_json_to_data_format(json_data)
        for key in json_data:
            for value in json_data[key]:
                if(value.get(attr)==attr_value):
                    list_data.append(value)
        return list_data

    def change_json_to_data_format(self, data):
        if(type(data)==str):
            data = json.loads(data)
        if(type(data)==list):
            data = data[0]
        return data

    def get_value_of_key(self, json_data, key):
        json_data= self.change_json_to_data_format(json_data)
        if(key in json_data.keys()):
            if(len(json_data.get(key))!=0):
                return json_data.get(key)

    def filter_data_has_attr(self, list_item, attr, attr_value):
        result=  [d for d in list_item if d[attr]==attr_value ]
        return result

    def get_item_from_json_list(self, json_list, key):
        result= []
        for d in json_list:
            if(d[key] and d[key] not in result):
                result.append(d[key])
        return result

    def sort_list_json_follow_value_of_attr(self, data, attr):
        result=  sorted(data, key=lambda x: x[attr])
        return result


class CustomLibrary(ElementHandler, DateTimeHelper, SessionStorageHandler, ApiHelper, FileHandler):
    @property
    def _s2l(self):
        return BuiltIn().get_library_instance('SeleniumLibrary')

    @property
    def _driver(self):
        return self._s2l.driver

    def open_new_tab_browser(self, url):
        self._driver.execute_script("window.open('"+url+"');")
        self._driver.switch_to.window(self._driver.window_handles[1])