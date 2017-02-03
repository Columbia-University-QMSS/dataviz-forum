# dataviz-forum
This will serve as the public forum repository for the QMSS - Data Visualization course to which anyone can post. [Don't put your graded homework here!]

To get you started with R Markdown and Github, I have detailed a few steps on how to share your explorations for [this week's data extercise on guns and deaths in America](exercise_guns/exercise/_guns_exercise.Rmd)

## Steps for R Markdown + GitHub in detail

  1. Open a GitHub account (if you don't have one). Please use your Columbia-email to benefit from private repositories. Install their dektop client (if you are new to Git): https://desktop.github.com/
  2. Go to https://github.com/Columbia-University-QMSS/dataviz-forum 
  3. Fork the repository (can be done in the web interface of GitHub)
  4. Clone the repository to your computer (no worries, this is only for *learning* how to do this, so nothing can break.) Click clone -> open in desktop.
  5. Choose a location on your hard drive for this "Forum" repository.
  6. Create a branch on which to work. Name the branch `FIRSTNAME_LASTNAME`
  7. Select `file > new Rmarkdown` in RStudio and create a file in the subfolder `exercise_guns\` in the forum folder. Use HTML as output format option.
  8. Make sure your YAML Front Matter at the top of the document looks something like this:  
      title: "INTERESTING TITLE HERE"   
      author: "FIRST NAME LAST NAME"  
      date: "DATE"  
      tag: "guns"  
  9. Save the file with the following naming convention: `Guns_FIRSTNAME_LASTNAME.RMD` in the subfolder `exercise_guns\`.
  10. Go to GitHub Desktop. You will see one or more uncommitted changes. Commit the changes (with some very short summary description, e.g "First commit".) 
  11. Press the "Sync" button to upload the file to GitHub.
  12. You can continue working on the file, exploring data, adding commits, uploading them etc. Save and commit frequently. You might choose just to commit changes to the Rmd, and then only include the html at the end. Then you can see (and share, and store) the entire history of the process.
  13. When you are done (but before class) open a pull request for your branch targeting the forum master repo. This is how I know you are done as well.
