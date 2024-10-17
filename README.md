# CoupDeWeb: Advanced Web Vulnerability Scanner

**CoupDeWeb** is a powerful and automated web vulnerability scanner designed for security researchers, developers, and penetration testers. This tool helps users scan websites for vulnerabilities like XSS and SQL Injection by retrieving historical URLs and filtering them through customizable patterns. It’s a fast, efficient, and user-friendly solution for finding potential loopholes in web applications.

## **Features**

- **Historical URL Collection**: Utilizes `waybackurls` to retrieve a site’s historical URLs.
- **Customizable Filters**: Supports `gf` filters for various vulnerability patterns like XSS, SQLi, and more.
- **De-duplication**: Ensures only unique URLs are presented with `urldedupe`.
- **User-Friendly**: Provides interactive prompts for a streamlined scanning process.
- **Optimized**: Fast scanning with detailed results and the option to save vulnerable URLs.

## **Prerequisites**

- **Go**
- **Gf**
- **waybackurls**
- **urldedupe**

## **Installation**

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AnonKryptiQuz/CoupDeWeb.git
   cd CoupDeWeb
   ```

2. **Run the script:**

   ```bash
   bash CoupDeWeb.sh
   ```

   **Ensure you have Go and all the required tools installed.**

## **Usage**

1. **Run the tool:**

   ```bash
   ./CoupDeWeb.sh
   ```

2. **Follow the prompts to input the website URL and select a filter.**

3. **The scanner will search for vulnerable URLs based on the selected filter and display the results.**
   
4. **Optionally, save the found URLs for future use.**

## **Disclaimer**

- **Educational Purposes Only**: CoupDeWeb is intended for educational and research use. The tool should not be used for illegal or malicious activities. It is the user’s responsibility to ensure compliance with local laws and regulations.

## **Credits**

This tool uses open-source projects, and we give full credit to the original developers:

- **waybackurls** by [tomnomnom](https://github.com/tomnomnom/waybackurls)
- **gf** by [tomnomnom](https://github.com/tomnomnom/gf)
- **urldedupe** by [ameenmaali](https://github.com/ameenmaali/urldedupe)

All tools are used under their respective open-source licenses.

## **Author**

**Created by:** [AnonKryptiQuz](https://AnonKryptiQuz.github.io/)
