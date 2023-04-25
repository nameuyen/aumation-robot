from SendMail import SendMail
from robot.api import TestSuite

class CustomListener:

    ROBOT_LISTENER_API_VERSION = 2
    count_remove= 0

    def __init__(self):
        self.send_mail= SendMail()
        self.total_tests = 0
        self.tests_passed = 0
        self.tests_failed = 0
        self.suite_results = {}
        self.suites_status= []

    def end_suite(self, name, attrs):
        self.suites_status.append(attrs['status'])
        count_remove= CustomListener.count_remove
        self.current_suite= name
        #count to remove data unnecessary in result dict
        if count_remove == 0:
            parts = attrs['longname'].split('.')
            last_component=  parts.pop()
            count_remove= len(parts)
            CustomListener.count_remove = count_remove
            
        # Add the suite results to the dictionary
        self.suite_results[self.current_suite] = {
            "total_tests": self.total_tests,
            "tests_passed": self.tests_passed,
            "tests_failed": self.tests_failed
        }

        # Reset the counters for the next suite
        self.total_tests = 0
        self.tests_passed = 0
        self.tests_failed = 0

    def end_test(self, name, attrs):
        result= attrs['status']
        # Increment the total test case counter
        self.total_tests += 1
        # Check the result of the test case and increment the appropriate counter
        if result=='PASS':
            self.tests_passed += 1
        else:
            self.tests_failed += 1

    def close(self):
        # Remove unnecessary data in dict result
        if 'FAIL'in self.suites_status:
           count_remove= CustomListener.count_remove
           self.results = list(self.suite_results.items())[:-count_remove]
           self.send_mail.zip_report_folder()
           self.send_mail.attach_zip_folder_and_send_mail(self.results)
           print("Send mail for failed test cases success")
        else:
           print("All tests passed. No mail is sent")
