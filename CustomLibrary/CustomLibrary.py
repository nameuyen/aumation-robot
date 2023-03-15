from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.by import By
import time
from datetime import datetime

class CustomLibrary(object):

    @property
    def _s2l(self):
        return BuiltIn().get_library_instance('SeleniumLibrary')

    @property
    def _driver(self):
        return self._s2l.driver
    
    def get_list(self,locator):
        locator = locator.replace("xpath:","")
        self._driver.find_element(By.XPATH, locator)
        time.sleep(5)
        return self._driver.find_elements(By.XPATH, locator+"/li")
        
    def get_list_value(self,locator):
        listItem = [item.text for item in self.get_list(locator)]
        return listItem
    
    def select_by_value_on_list(self, locator, value):
        locator = locator.replace("xpath:","")
        for i in range(1,len(self.get_list(locator))+1):
            select= self._driver.find_element(By.XPATH, locator+"/li"+"["+str(i)+"]")
            if(select.text == value):
                select.click()

    def get_css_value_property(self, locator, css_property):
        locator = locator.replace("xpath:","")
        element= self._driver.find_element(By.XPATH, locator)
        return element.value_of_css_property(css_property)
    
    def convert_date_to_string(self):
        now = datetime.now()
        return now.strftime("%d%m%Y%H%M%S")
    
    def _get_list_keys_session_storage(self):
        return self._driver.execute_script( \
            "var ls = window.sessionStorage, keys = []; " \
            "for (var i = 0; i < ls.length; ++i) " \
            "  keys[i] = ls.key(i); " \
            "return keys; ")
        
    def is_contain_key_in_session_storage(self, key):
        return key in self._get_list_keys_session_storage()
            
    def get_session_storage_value(self,key):
        return self._driver.execute_script("return window.sessionStorage.getItem('{}');".format(key))
        

       
        

        



