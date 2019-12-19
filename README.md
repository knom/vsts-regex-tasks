# RegexReplace Build/Release Task [![Version](https://img.shields.io/vscode-marketplace/v/knom.regexreplace-task.svg?label=VS%20Marketplace&logo=visual-studio-code&logoColor=white)](https://marketplace.visualstudio.com/items?itemName=knom.regexreplace-task) [![Visual Studio Marketplace Downloads](https://img.shields.io/vscode-marketplace/d/knom.regexreplace-task.svg?logo=visual-studio-code&logoColor=white)](https://marketplace.visualstudio.com/items?itemName=knom.regexreplace-task) [![GitHub License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/knom/vsts-regex-tasks/blob/master/LICENSE) ![Build Status](https://knom-msft.visualstudio.com/_apis/public/build/definitions/9d8fcb7c-6c11-4014-9dc2-7966c94af2b2/5/badge)

A task for replacing REGULAR EXPRESSIONS in your files with variables and text in build and release pipelines.

## Supported Platforms

* Azure DevOps - Pipelines
* Team Foundation Server 2015 Update 3 and higher ([How to install extensions in TFS](https://www.visualstudio.com/en-us/docs/marketplace/get-tfs-extensions))
* **Only Windows** - sorry, this is due to the lack of Powershell support of the underlying task FX platform :-(
* Build Agents w. Powershell 3.0 or higher

## Usage

### 1. Add the RegEx Find & Replace task to your build or release pipeline.

![Extension Tasks](https://raw.githubusercontent.com/knom/vsts-regex-tasks/master/docs/addtask.png "Extension Tasks")

### 2. Configure the parameters

![Screenshot](https://raw.githubusercontent.com/knom/vsts-regex-tasks/master/docs/regexreplace.png "Screenshot")

#### Parameters:

* Search Paths to Input Files:
  * The search patterns to the files that should used in Find & Replace
  * **New in v3**: Supports multiple input lines and minimatching
* Find RegEx:
  * The Regular Expression to **FIND** text
  * RegEx Groups (brackets) are used for the replace option
  * E.g. find all XML/HTML comments

            <!-- (.*) -->
* Replace With:
  * The text to replace with
  * *$1* is the first group, *$2* the second, ...
  * E.g. replace them with what was within the comment (comment it IN)
  
            $1
* **New in v3**: UseRAW (default true):
  * Whether to use RAW file read mode (might help with replace issues, such as newline)
* **New in v3**: UseUTF8 (default true):
  * Whether to read the file in UTF8 (otherwise in ASCII)

## License

Now published under [MIT License](https://github.com/knom/vsts-markdown-tasks/blob/master/LICENSE).
