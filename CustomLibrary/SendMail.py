from email.mime.text import MIMEText
import smtplib
import zipfile
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from email.mime.base import MIMEBase
import os
import sys
from email import encoders
from datetime import datetime

class SendMail:
    # Set up the message
    def __init__(self):
        print("send mail")
        self.zip_path= "Report/archive.zip"
        self.outputdir=""
        self.body=""
        self.subject = 'Robot Framework Report '
        self.sender_email = ''
        self.recipients = ['']
        self.password= ""  #app password

    def edit_subject_title(self):
        now = datetime.now()
        self.subject+= now.strftime("%d%m%Y%H%M%S")
        return self.subject

    def zip_report_folder(self):
        try:
            self.index = sys.argv.index('--outputdir')
        except ValueError:
            self.index = -1

        # If the '--outputdir' option was not found, use a default value
        if self.index == -1 or len(sys.argv) <= self.index + 1:
            self.outputdir = 'results'
        else:
            self.outputdir = sys.argv[self.index + 1]

        with zipfile.ZipFile(self.zip_path, 'w', zipfile.ZIP_DEFLATED) as zip_file:
            for root, dirs, files in os.walk(self.outputdir):
                for file in files + dirs:
                   file_path = os.path.join(root, file)
                   rel_path = os.path.relpath(file_path, self.outputdir)
                   zip_file.write(file_path, os.path.join('Report', rel_path))

    def custom_body_email(self, suite_results_items):
        self.body= "<html><body>"
        for suite_name, suite_results in suite_results_items:
            self.body += "<h1>Test Result</h1>"
            self.body += f"<h2>Suite: {suite_name}</h2>"
            self.body += f"<p>Total tests:  {suite_results['total_tests']}</p>"
            self.body += f"<p>Tests passed: {suite_results['tests_passed']}</p>"
            self.body += f"<p>Tests failed: {suite_results['tests_failed']}</p><br>"
        self.body += "</body></html>"

    def attach_zip_folder_and_send_mail(self, suite_results_items):
        self.custom_body_email(suite_results_items)
        self.edit_subject_title()
        self.msg = MIMEMultipart()
        self.msg['Subject'] = self.subject
        self.msg['From'] = self.sender_email
        self.msg['To'] = ', '.join(self.recipients)
        self.msg.attach(MIMEText(self.body, 'html'))
        with open(self.zip_path, 'rb') as attachment:
            part = MIMEBase('application', 'octet-stream')
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', f'attachment; filename= {os.path.basename(self.zip_path)}')
            self.msg.attach(part)
        with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
            smtp.starttls()
            smtp.login(self.sender_email, self.password)
            smtp.sendmail(self.sender_email, self.recipients, self.msg.as_string())
