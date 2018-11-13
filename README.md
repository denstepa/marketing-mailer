# Marketin Mailer

This is a simple tool that allows to send marketing campaigns to users through sendgrid transactional emails, without need to pay for contacts storage on sendgrid.



## Installation

TODO: write the installation instruction via docker

1. Create a sendgrid account
2. Get API key from sendgrid
3. Add sendgrid key as ENV variable to the docker.

## Usage

1. Go to Campaigns tab
2. Create a new campaign,
  1. Add a CSV file containing contacts. The only required column is `email`. File can also contain any other user-related information that will be passed to the template
  2. Add a CSV file with test contacts list. It should have same columns / structure as the original file, but only users who should receive test emails
  3. Add Sendgrid Template ID. You should first create a template inside Sendgrid. You can use template variables the way as sendgrid suggests. Names of the variables should match the columns on the CSV file.
  4. Fill other campaign fields
3. Save the campaign
4. Send test email, to check how email looks
5. Send the production email

# TODOs:

Potential Roadmap:
- Support for other email senders
- Support for contacts unsubscription logic (check if needed?)
- Email Preview
- Better Admin Interace
- Send within contacts timezone
- Dynamic contacts lists (update via URL)
- repeated campaigns