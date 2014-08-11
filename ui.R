library(shiny)

shinyUI(fluidPage(theme = "bootstrap.css",
                        
   titlePanel("To Kill a Busy Bug"),

    sidebarPanel(
        
        h4('Select sprays to compare efficiency:'),
        hr(),
        selectInput("spray1", "1st chosen spray", 
                    choices = c("Punctiventris", "Vaporariorum", "Decemlineata", "Capucinus", "Corylifoliella", "Controlitis"), selected = "Controlitis",
                    width = "80%"),
        selectInput("spray2", "2nd chosen spray", 
                    choices = c("Punctiventris", "Vaporariorum", "Decemlineata", "Capucinus", "Corylifoliella", "Controlitis"),  
                    width = "80%"),
        selectInput("spray3", "3rd chosen spray", 
                    choices = c("Punctiventris", "Vaporariorum", "Decemlineata", "Capucinus", "Corylifoliella", "Controlitis"), selected = "Decemlineata", 
                    width = "80%"),
        hr(),
        submitButton("Recalculate"),
        hr(),
        
        h4("Spray names"),
        p('Bug sprays used in the original research (see the document below) had a non-descriptive names (A, B, C...), but for the purpose of 
          this application we decided to substitute them with some funny Latin ones.'),
        fluidRow(
            column(width = 12,
                   includeHTML("table.html")
        ))
        
#        plotOutput('bggplot')
    ),
    mainPanel(
        h3(tags$strong("Let the data help you choose the best bug spray!")),
        
        p('This is how data science can help you get rid of those annoying buzzing buggers. This application is based on real research data that you can read
          in the PDF document included below the results. You have the opportunuty to compare 3 different bug sprays and choose the most efficient one.'),
        
        hr(),
        h4('INSTRUCTIONS:'), 
        p('1. Use the dropdown menus on the left to select three types of insect sprays.'),
        p('2. Press the', tags$strong("Recalculate"), 'button and wait a moment for the result. Depending on server load it may take a while, so please be patient.'),
        p('3. Read in the fields below how many bugs survived after each spray was applied during the original experiment.'),
        p('4. Look at the pretty graph representation of the results.'),
        p('5. Repeat from the beginning to choose other sprays to compare.'),
        hr(),
        
        h4('Results of your comparison:'),
#        uiOutput("code"),
        verbatimTextOutput("spray1Summary"),   
        verbatimTextOutput("spray2Summary"),
        verbatimTextOutput("spray3Summary"),
        verbatimTextOutput("rezultat"),
        hr(),
        hr(),
        plotOutput('ggplot'),
        
        hr(),
        
        p('Dataframe used in this application is imported from the dataset', tags$code("InsectSprays"), 'which comes 
            preloaded with RStudio', tags$code("datasets"), 'library. If you are interested in original research 
            check the paper published in ', tags$strong(tags$em("Biometrika")), ' in 1942:'),
        
        helpText(tags$strong("DATA SOURCE: "), tags$a(href="http://www.jstor.org/stable/2332128?origin=JSTOR-pdf", "Beall, G., (1942)2"), tags$em(tags$a(href="http://www.jstor.org/stable/2332128?origin=JSTOR-pdf", "The Transformation of data from entomological field experiments,")), tags$a(href="http://www.jstor.org/stable/2332128?origin=JSTOR-pdf", " Biometrika, 29, 243-262.")),
        hr(),
        fluidRow(
            column(width = 12,
                   includeHTML("biometrika.html")
        ))
    )
))
