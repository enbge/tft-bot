# TFT AFK Farm Bot

This Perl script automates the process of farming experience points (XP) in Teamfight Tactics (TFT) by queuing up for matches, playing through them, and re-queuing once finished. It is designed to be used alongside the League of Legends client.

## Requirements

- **Perl**: You need to have Perl installed on your system. You can download and install Perl from [Strawberry Perl](http://strawberryperl.com/).

- **Required Perl Modules**:
  - MIME::Base64
  - LWP::UserAgent
  - JSON::Parse
  - Time::HiRes

  You can install these modules using the CPAN command:
  cpan install MIME::Base64 LWP::UserAgent JSON::Parse Time::HiRes


## Usage

1. **Clone Repository**: Clone this repository to your local machine:
git clone <repository-url>


2. **Save Script**: Save the provided Perl script as `tft_afk_bot.pl`.

3. **Install Missing Modules**: When you run the script for the first time, the console will indicate any missing Perl modules. Install them using the CPAN command as mentioned in the requirements.

4. **Run the Script**:
- Ensure that the League of Legends client is open and logged in.
- Navigate to the directory containing the Perl script.
- Run the script using the following command:
  ```
  perl tft_afk_bot.pl
  ```

5. **Enjoy**: The script will automate the process of queuing up for TFT matches, playing through them, and re-queuing once the match is finished.

## Queue IDs

- **1090**: Normal
- **1100**: Ranked
- **1130**: Hyperroll (Gives 50 XP)
- **1160**: Double

## Disclaimer

This bot is for educational purposes only. Using this bot to gain unfair advantages or violate the terms of service of the game is strictly prohibited. Use it at your own risk.

## License

This project is licensed under the [MIT License](LICENSE).
