# RegexReplace Build/Release Task ![Build Status](https://knom.visualstudio.com/_apis/public/build/definitions/969cb309-5d7f-427d-b48a-43eeac3c4aaf/21/badge)
A task for replacing REGULAR EXPRESSIONS in your files with variables and text in build and release pipelines.

## Supported Platforms ##
* Visual Studio Team Services
* Team Foundation Server 2015 Update 3 and higher ([How to install extensions in TFS](https://www.visualstudio.com/en-us/docs/marketplace/get-tfs-extensions))

## Usage ##
The extension installs the follow task:

![Extension Tasks](https://raw.githubusercontent.com/knom/vsts-regex-tasks/master/docs/addtask.png "Extension Tasks")

* ### RegEx Find & Replace
    Find & replace using Regular Expressions.
    
    ![Screenshot](https://raw.githubusercontent.com/knom/vsts-regex-tasks/master/docs/regexreplace.png "Screenshot")
    
    #### Parameters: ####
    * Search Path to Input Files: 
        * The search pattern to the files that should used in Find & Replace
        * This is regular Windows Search Patterns - *NO minimatch*
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

## License ##
Published under [Apache 2.0 License](https://github.com/knom/vsts-markdown-tasks/blob/master/LICENSE).
