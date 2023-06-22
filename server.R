function(input, output,session) {


  # Change theme ----------------------------------------------------------

  observe(print(input$dataset))
  ukman = fread('data/bin_UKBB_manifest_both_sexes_mapped_phenotypes_201807.tsv')
  output$tableukman <- renderDT({
    DT::datatable(ukman,
                  rownames = F, filter='top', options = list(pageLength = 15, scrollX = TRUE,deferRender = TRUE), autoHideNavigation = F,caption = 'UKBB phenotypes chosen for cophescan PheWAS'
    )
  })
  output$text1 <- renderText({ paste("hello input is","<font color=\"#FF0000\"><b>", input$n, "</b></font>") })
  observeEvent(input$dataset,{
    observeEvent({input$TraitVarHc},{
      max_disp = 10
      load(file.path('data/',input$dataset, '/variants.RData'), envir = .GlobalEnv)
      load(file.path('data/',input$dataset, '/cophe_res.RData'))
      load(file.path('data/',input$dataset, '/dat_for_p.RData'))
    if (input$dataset == 'pQTL'){
      shinyjs::hide(selector = "ul li:eq(7)", anim = TRUE)
      max_disp = 15
      cophe_res <- cophe_res[which(cophe_res$querysnp%in%variants$queryvariant_38), ]
      cophe_res_sub <- cophe_res[which(cophe_res$Hc.hier.norg>=input$TraitVarHc), ]
      cophe_res_sub$disp = paste0(cophe_res_sub$querysnp, ': ', variants$symbol[match(cophe_res_sub$querysnp, variants$queryvariant_38)])
    } else if (input$dataset == 'FinnGen'){
      shinyjs::hide(selector = "ul li:eq(7)", anim = TRUE)
      cophe_res_sub <- cophe_res[which(cophe_res$Hc.hier.norg>=input$TraitVarHc | cophe_res$Hc.hier.rg>=input$TraitVarHc), ]
      cophe_res_sub$disp = paste0(cophe_res_sub$querysnp, ': ', cophe_res_sub$gene_name)
    } else if (input$dataset == 'PTV'){
      shinyjs::hide(selector = "ul li:eq(7)", anim = TRUE)
      cophe_res_sub <- cophe_res[which(cophe_res$Hc.hier.norg.all>=input$TraitVarHc), ]
      cophe_res_sub$disp = paste0(cophe_res_sub$querysnp, ': ', cophe_res_sub$gene_name)
    } else if (input$dataset == 'Individual'){
      cophe_res_sub <- cophe_res[which(cophe_res$Hc>=input$TraitVarHc), ]
      cophe_res_sub$disp = paste0(cophe_res_sub$querysnp, ': ', cophe_res_sub$gene_name)
      gwascatman = fread('data/GWAScat_phenotypes.tsv')
      gwascatman = gwascatman[ , c(1:7,which(colnames(gwascatman)%in%variants$queryvariant_38)), with = F] %>%
        rename(Pop =`1000genPop`)
      shinyjs::show(selector = "ul li:eq(7)", anim = TRUE)
      output$tablegwascatman <- renderDT({
        DT::datatable(gwascatman,
                      rownames = F, filter='top', options = list(pageLength = 15, scrollX = TRUE,deferRender = TRUE), autoHideNavigation = F,caption = 'GWAS catalog phenotypes chosen for cophescan PheWAS on individual variants'
        )
      })
    }
    variants$rsid_all = paste0(variants$rsid,'_' ,sapply(variants$queryvariant_38, function(x) paste(do.call(rbind, strsplit(x, '_'))[, 3:4], collapse  = '>')))
    variants$Hc_detected = F
    variants$Hc_detected[variants$queryvariant_38%in%cophe_res$querysnp] = T
    cophe_res <-   cophe_res %>% mutate_if(is.numeric, round, digits=3)
    cophe_res$prmtrait_descrip <- NULL


      ch = ((cophe_res_sub$querysnp))
      names(ch) = cophe_res_sub$disp
      ch = mixedsort(ch)
      updateSelectizeInput(session, "TraitVar", "Variant",
                           choices = ch[!duplicated(ch)], selected = (ch)[1],server = T)


    output$queryvariant <- renderInfoBox({
      infoBox(
        title = "Query Variant",fill = TRUE, subtitle = 'View in OTG(click)', value = variants$queryvariant_38[variants$queryvariant_38 == input$TraitVar], icon = icon("dna", lib = "font-awesome"),
        color = "olive", href = paste0('https://genetics.opentargets.org/variant/', variants$queryvariant_38[variants$queryvariant_38 == input$TraitVar])
      )
    })


    cophe_res_sub$querytrait_direction_eff <-  ifelse((cophe_res_sub$querytrait_direction_eff == 'n'), paste0(fa(name = "arrow-down", fill = "forestgreen"), ' n'), paste0(fa(name = "arrow-up", fill = "red"), ' p'))

    prim_signs =data.frame(querysnp=variants$queryvariant_38, PrimaryTrait=variants$primarytrait)
    if (!input$dataset %in% c('PTV', 'Individual')){
      prim_signs$Primarytrait_Effect <- cophe_res_sub$primarytrait_direction_eff[match(prim_signs$querysnp, cophe_res_sub$querysnp)]
      # prim_signs <- prim_signs[complete.cases(prim_signs$prim_dir), ]

      prim_signs$Primarytrait_Effect <-  sapply(1:nrow(prim_signs), function(x) paste(unlist(ifelse(grepl('n',  strsplit(prim_signs$Primarytrait_Effect[x], split = ',')[[1]]), paste0(fa(name = "arrow-down", fill = "forestgreen"), ' n'), paste0(fa(name = "arrow-up", fill = "red"), ' p'))), collapse = ','))
    } else {
      prim_signs$Primarytrait_Effect <- '-'
    }
    output$primarytrait <- renderInfoBox({
      infoBox(
        title="Primary Trait/Protein",value= prim_signs$primarytrait[prim_signs$queryvariant_38 == input$TraitVar], icon = icon("user", lib = "glyphicon"),
        color = "light-blue", fill = TRUE
      )
    })
    output$queryvariant2 <- renderInfoBox({
      infoBox(
        title = "Query Variant",fill = TRUE, subtitle = 'View in OTG(click)', value = variants$queryvariant_38[variants$queryvariant_38 == input$TraitVar], icon = icon("dna", lib = "font-awesome"),
        color = "olive", href = paste0('https://genetics.opentargets.org/variant/', variants$queryvariant_38[variants$queryvariant_38 == input$TraitVar])
      )
    })

    output$primarytrait2 <- renderInfoBox({
      infoBox(
        title="Primary Trait/Protein",value= variants$primarytrait[variants$queryvariant_38 == input$TraitVar], icon = icon("user", lib = "glyphicon"),
        color = "light-blue", fill = TRUE
      )
    })

    # cophe_res_sub$`primarytrait/protein` <- NULL

    output$sus <- renderPlotly({
      if (input$dataset == 'pQTL'){
        cophe_out <- pQTL_norg[which(pQTL_norg$querysnp==input$TraitVar), ]
      } else if (input$dataset == 'FinnGen'){
        cophe_out <- finn_norg[which(finn_norg$querysnp==input$TraitVar), ]
      } else if (input$dataset == 'PTV'){
        cophe_out <- ptv_norg[which(ptv_norg$querysnp==input$TraitVar), ]
      }  else if (input$dataset == 'Individual'){
        cophe_out <- ind[which(ind$querysnp==input$TraitVar), ]
      }
      ggplotly(return_plot(cophe_out)+ ggtitle(paste0('Hier.Pr|SuSIE.BF|No.rg')) , height = 600, width = 1000, tooltip = c('Querytrait', 'Hc', 'p', 'shape'))
    })

    output$tableres <- renderDT({
      DT::datatable(variants,
                    rownames = F, filter='top',
                    options = list(pageLength = max_disp, scrollX = TRUE, deferRender = TRUE), autoHideNavigation = F,caption = paste0('Putative variants obtained from ', input$dataset, 'dataset')
      )
    })

    if (!input$dataset  %in% c('PTV', 'Individual')){
      cophe_res_sub$primarytrait_direction_eff <-  sapply(1:nrow(cophe_res_sub), function(x) paste(unlist(ifelse(grepl('n',  strsplit(cophe_res_sub$primarytrait_direction_eff[x], split = ',')[[1]]), paste0(fa(name = "arrow-down", fill = "forestgreen"), ' n'), paste0(fa(name = "arrow-up", fill = "red"), ' p'))), collapse = ','))
    } else {
      cophe_res_sub$primarytrait_direction_eff <- '-'
    }

    output$tableprim <- renderDT({
      DT::datatable(prim_signs[which(prim_signs$querysnp==input$TraitVar), c("PrimaryTrait", "Primarytrait_Effect") ],escape = F, rownames = F, options=list(dom = 't', ordering=FALSE, searching = FALSE)
      ) %>%
        formatStyle(colnames(prim_signs[which(prim_signs$querysnp==input$TraitVar), c("PrimaryTrait", "Primarytrait_Effect")]), backgroundColor = 'orange', color = 'white', fontWeight='bold')
    })

    output$tableprim2 <- renderDT({
      DT::datatable(prim_signs[which(prim_signs$querysnp==input$TraitVar), c("PrimaryTrait", "Primarytrait_Effect") ],escape = F, rownames = F, options=list(dom = 't', ordering=F, searching = FALSE, info = FALSE)
      ) %>%
        formatStyle(colnames(prim_signs[which(prim_signs$querysnp==input$TraitVar), c("PrimaryTrait", "Primarytrait_Effect")]), backgroundColor = 'orange', color = 'white', fontWeight='bold')
    })

    # brks1 <- quantile(cophe_res_sub$Hc.hier.norg, probs = seq(.05, .95, .05), na.rm = TRUE)
    brks1=seq(.4, 1, .05)
    clrs1 <- viridis::viridis(n=length(brks1)+1, alpha=.5, direction = -1)

    if (input$dataset == 'FinnGen'){
      cophe_res_sub$ukbbeq_primrytrait_rg <- sapply(cophe_res_sub$primrytrat_rg, function(x) get_prim( gsub(" ", "", strsplit(x, split = ',')[[1]])))
      cophe_res_sub$ukbbeq_primrytrait_rg[cophe_res_sub$ukbbeq_primrytrait_rg=='NA'] <- NA
      cophe_res_sub <- cophe_res_sub[, c("querysnp", "rsid", "consequence_category", "querytrait", "qrtrait_descrip", "log10pval", "querytrait_direction_eff", "Hc.hier.norg", "Hc.hier.rg", "rg", "ukbbeq_primrytrait_rg" , "primarytrait/protein", "primarytrait_direction_eff", "gene_name")]
      col_num <- which(colnames(cophe_res_sub)%in%c( "primarytrait/protein", "primarytrait_direction_eff"))
    } else if (input$dataset == 'pQTL'){
      cophe_res_sub <- cophe_res_sub[, c("querysnp", "rsid", "consequence_category","querytrait", "qrtrait_descrip", "log10pval", "querytrait_direction_eff", "Hc.hier.norg", "primarytrait/protein", "primarytrait_direction_eff")]
      col_num <- which(colnames(cophe_res_sub)%in%c( "primarytrait/protein", "primarytrait_direction_eff"))
    } else if (input$dataset == 'PTV'){
      cophe_res_sub <- cophe_res_sub[, c("querysnp", "rsid", "consequence_category", "querytrait", "qrtrait_descrip", "log10pval", "querytrait_direction_eff", "Hc.hier.norg.all", "Hc.hier.norg.gnomAD", "Hc.hier.norg.StopGained", "primarytrait/protein", 'gnomAD', "gene_name")]
      col_num <- which(colnames(cophe_res_sub)%in%c( "primarytrait/protein"))
    } else if (input$dataset == 'Individual'){
      cophe_res_sub <- cophe_res_sub[, c("querysnp", "rsid", "consequence_category", "consequence", "querytrait", "qrtrait_descrip", "log10pval", "querytrait_direction_eff", "Hc", "primarytrait/protein", "gene_name")]
      col_num <- which(colnames(cophe_res_sub)%in%c( "primarytrait/protein"))
    }
    cophe_res_sub[is.na(cophe_res_sub)] <- '-'
    output$tablecophe <- renderDT({
      if (input$dataset == 'pQTL'){
        DT::datatable(cophe_res_sub[which(cophe_res_sub$querysnp==input$TraitVar), ],escape = F,
                      callback=JS('$("button.buttons-copy").css("background","salmon");
                      $("button.buttons-csv").css("background","forestgreen");
                      return table;'), extensions = c("Buttons"), rownames = F, filter='top', options = list(columnDefs = list(list(visible=FALSE, targets=c(col_num-1))), paging=F, pageLength = max_disp,scrollX = TRUE,deferRender = TRUE, dom = 'Bfrtip',scroller = TRUE, buttons = list('copy', list(extend = 'csv',text='Download .csv', filename=paste0(input$TraitVar)))), autoHideNavigation = F,caption = paste0('Putative variants obtained from ', input$dataset, 'dataset')
        )%>%
          formatStyle("Hc.hier.norg", backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold')
      } else if (input$dataset == 'FinnGen'){
        DT::datatable(cophe_res_sub[which(cophe_res_sub$querysnp==input$TraitVar), ],escape = F,
                      callback=JS('$("button.buttons-copy").css("background","salmon");
                      $("button.buttons-csv").css("background","forestgreen");
                      return table;'), extensions = c("Buttons"), rownames = F, filter='top', options = list(columnDefs = list(list(visible=FALSE, targets=c(col_num-1))), paging=F, pageLength = max_disp,scrollX = TRUE,deferRender = TRUE, dom = 'Bfrtip',scroller = TRUE, buttons = list('copy', list(extend = 'csv',text='Download .csv', filename=paste0(input$TraitVar)))), autoHideNavigation = F,caption = paste0('Putative variants obtained from ', input$dataset, 'dataset')
        ) %>%
          # formatStyle("Hc.hier.norg",  valueColumns = 'vec.hc', backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold') %>%
          formatStyle("Hc.hier.norg",  backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold') %>%
          formatStyle("Hc.hier.rg",  backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold')
      } else if (input$dataset == 'PTV'){
        DT::datatable(cophe_res_sub[which(cophe_res_sub$querysnp==input$TraitVar), ],escape = F,
                      callback=JS('$("button.buttons-copy").css("background","salmon");
                      $("button.buttons-csv").css("background","forestgreen");
                      return table;'), extensions = c("Buttons"), rownames = F, filter='top', options = list(columnDefs = list(list(visible=FALSE, targets=c(col_num-1))), paging=F, pageLength = max_disp,scrollX = TRUE,deferRender = TRUE, dom = 'Bfrtip',scroller = TRUE, buttons = list('copy', list(extend = 'csv',text='Download .csv', filename=paste0(input$TraitVar)))), autoHideNavigation = F,caption = paste0('Putative variants obtained from ', input$dataset, 'dataset')
        ) %>%
          formatStyle("Hc.hier.norg.all", backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold') %>%
          formatStyle("Hc.hier.norg.gnomAD",  backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold') %>%
          formatStyle("Hc.hier.norg.StopGained",  backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold')
      } else if (input$dataset == 'Individual'){
        DT::datatable(cophe_res_sub[which(cophe_res_sub$querysnp==input$TraitVar), ],escape = F,
                      callback=JS('$("button.buttons-copy").css("background","salmon");
                      $("button.buttons-csv").css("background","forestgreen");
                      return table;'), extensions = c("Buttons"), rownames = F, filter='top', options = list(columnDefs = list(list(visible=FALSE, targets=c(col_num-1))), paging=F, pageLength = max_disp,scrollX = TRUE,deferRender = TRUE, dom = 'Bfrtip',scroller = TRUE, buttons = list('copy', list(extend = 'csv',text='Download .csv', filename=paste0(input$TraitVar)))), autoHideNavigation = F,caption = paste0('Putative variants selected individually: cophescan run with fixed priors')
        ) %>%
          formatStyle("Hc", backgroundColor = styleInterval(brks1, clrs1), fontWeight='bold')
      }
    })
  })
  })
  output$readme <- renderUI({
    withMathJax(includeHTML(rmarkdown::render("www/README.Rmd")))
  })
  output$intro <- renderUI({
    withMathJax(includeHTML(rmarkdown::render("www/INTRO.Rmd")))
  })
}

