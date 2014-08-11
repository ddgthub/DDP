library(shiny)
library(ggplot2)
library(grid)
library(extrafont)
data(InsectSprays)

shinyServer(
    function(input, output) {
        spraydf = InsectSprays
        
        levels(spraydf$spray) <- c("Punctiventris", "Vaporariorum", "Decemlineata", "Capucinus", "Corylifoliella", "Controlitis")

        spraydf$spray = with(spraydf, reorder(spray, count, mean))        
        
        output$bggplot = renderPlot((ggplot(spraydf,aes(spray,count,color=spray,fill=spray)) + 
                                         geom_point(position='jitter') + 
                                         geom_violin(alpha=0.4)
        ))
        
        output$ggplot = renderPlot((
                                ggplot(
                                    subset(
                                        spraydf,spray %in% c(input$spray1, input$spray2, input$spray3)
                                            ),aes(spray,count,fill=spray,color=spray)
                                        ) +
                                        geom_violin(alpha=0.3, trim = FALSE) +
                                        geom_point(alpha=0.5, position='jitter') + 
                                        coord_fixed(ratio=0.05) + 
                                        scale_colour_manual(values=c("#FF99FF", "#330066", "#be33be"), guide = FALSE) + 
                                        scale_fill_manual(values=c("#FF99FF", "#330066", "#be33be"), name = "Type of spray") +
                                        theme_gray(base_family="serif") +
                                        xlab("Type of spray") + ylab("Surviving bugs") +
                                        ggtitle("Comparison of spray efficiency") +
                                        theme(plot.title=element_text(family="Candara", face="bold", size=26, vjust=3),
                                              plot.margin=unit(c(1,1,1,1),"cm"),
                                              axis.title.x = element_text(family="Candara", size=16, vjust=-1),
                                              axis.title.y = element_text(family="Candara", size=16, vjust=2),
                                              axis.text.x = element_text(family="Candara", size=12),
                                              axis.text.y = element_text(family="Candara", size=12),
                                              legend.text = element_text(family="Candara", size=10, vjust=3),
                                              legend.key.size = unit(1, "cm"),
                                              legend.title = element_text(family="Candara", face="italic", size=14, vjust=2))
                                        
                                        
        ))
        
#         # code
#         output$code <- renderUI({   
#             HTML('<strong>input$spray1</strong>', 'will probably leave around', '<strong>round(mean(spraydf$count[spraydf$spray == input$spray1]))</strong>', 'bugs still alive.')
#         })
#         
        
        # prvi rezultat
        
        output$spray1Summary <- renderText({
        
                paste(input$spray1, 'will probably leave around', round(mean(spraydf$count[spraydf$spray == input$spray1])), 'bugs still alive.')
        
        })
        
 
        # drugi rezultat
        
        output$spray2Summary <- renderText({
            paste(input$spray2, 'will probably leave around', round(mean(spraydf$count[spraydf$spray == input$spray2])), 'bugs still alive.')                  
        })
        
        # treci rezultat
        
        output$spray3Summary <- renderText({
            paste(input$spray3, 'will probably leave around', round(mean(spraydf$count[spraydf$spray == input$spray3])), 'bugs still alive.')
        })
        
        # rezultat
        
        output$rezultat <- renderText({
            paste('Seems that the winner is', if((mean(spraydf$count[spraydf$spray == input$spray1]) < mean(spraydf$count[spraydf$spray == input$spray2])) && (mean(spraydf$count[spraydf$spray == input$spray1]) < mean(spraydf$count[spraydf$spray == input$spray3]))) input$spray1 else if((mean(spraydf$count[spraydf$spray == input$spray2]) < mean(spraydf$count[spraydf$spray == input$spray1])) && (mean(spraydf$count[spraydf$spray == input$spray2]) < mean(spraydf$count[spraydf$spray == input$spray3]))) input$spray2 else input$spray3, 'bug spray!')
        })
    }
)
