## UI ####

customSentence_share <- function(numItems, type) {
  paste("Use CoPheScan on your data!")
}

##
dropdownMenuCustom <- function (..., type = c("messages", "notifications", "tasks"),
                                    badgeStatus = "primary", icon = NULL, .list = NULL,
                                    customSentence = customSentence){
  type <- match.arg(type)
  if (!is.null(badgeStatus)) shinydashboard:::validateStatus(badgeStatus)
  items <- c(list(...), .list)
  lapply(items, shinydashboard:::tagAssert, type = "li")
  dropdownClass <- paste0("dropdown ", type, "-menu")
  if (is.null(icon)) {
    icon <- switch(type, messages = shiny::icon("envelope"),
                   notifications = shiny::icon("warning"), tasks = shiny::icon("tasks"))
  }
  numItems <- length(items)
  if (is.null(badgeStatus)) {
    badge <- NULL
  }
  else {
    badge <- tags$span(class = paste0("label label-", badgeStatus),
                       numItems)
  }
  tags$li(
    class = dropdownClass,
    a(
      href = "#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      icon,
      badge
    ),
    tags$ul(
      class = "dropdown-menu",
      tags$li(
        class = "header",
        customSentence(numItems, type)
      ),
      tags$li(
        tags$ul(class = "menu", items)
      )
    )
  )
}
messages <- dropdownMenuCustom( type = 'message',customSentence = customSentence_share,icon = icon("github"),messageItem(from = 'Github', message = "", icon = icon("github"), href = "https://github.com/ichcha-m/cophescan"
))
dashboardPage(skin = 'black',
  dashboardHeader(title = span(img(src = "logo.png", height = 35), "cophescan"),
                  titleWidth = 300,
                  # tags$li(class = "dropdown",
                  #         tags$style(".skin-black .main-header .navbar .logo {background-color: #E1DDE0;}")),
                  messages),
  dashboardSidebar(width=300, sidebarMenu(
    style = "position: fixed; overflow: visible;",
    useShinyjs(),
    menuItem("Introduction", tabName = "intro", icon = icon("door-open")),
    HTML(paste(
      p( HTML('&nbsp;'), strong("_______________________"))
    )
    ),
    HTML(paste(
      p( HTML('&nbsp;'), strong("Explore Input Data"))#, style="color:slategrey")
    )
    ),
    selectInput("dataset", "Select query variant source", c("FinnGen", "pQTL", "PTV", "Individual")),
    menuItem("Query variants", tabName = "var", icon = icon("dna", lib = "font-awesome")),
    menuItem("UKBB Query traits", tabName = "phen", icon = icon("hospital-user", lib = "font-awesome")),
    shinyjs::hidden(menuItem("GWAS cat Query traits", tabName = "phen_gwascat", icon = icon("hospital-user", lib = "font-awesome"))),
    HTML(paste(
      p( HTML('&nbsp;'), strong("_______________________"))
    )
    ),
    HTML(paste(
      p( HTML('&nbsp;'), strong("CoPheScan Results"))#, style="color:slategrey")
    )
    ),
    selectizeInput("TraitVar", "Select Variant", choices=NULL, size=10),
    sliderInput("TraitVarHc", "pp > Hc threshold:", min=0.6, max=0.9, value = 0.6),
    menuItem("Tables", tabName = "tables", icon = icon("table")),
    menuItem("Plots", tabName = "plots", icon = icon("signal")),
    HTML(paste(
      p( HTML('&nbsp;'), strong("_______________________"))
    )
    ),
    menuItem("README", tabName = "readme", icon = icon("readme"))
  )),

  dashboardBody(
    tags$script(HTML("$('body').addClass('fixed');")),
    tabItems(
      tabItem(tabName = "phen",
              fluidRow(column(
                DT::dataTableOutput('tableukman'), width=12))
      ),
      tabItem(tabName = "phen_gwascat",
              fluidRow(column(
                DT::dataTableOutput('tablegwascatman'), width=12))
      ),

      tabItem(tabName = "var",
              fluidRow(column(
                DT::dataTableOutput('tableres'), width=12))
      ),

      # Display plots
      tabItem(tabName = "tables",
              fluidRow(
                infoBoxOutput("queryvariant", width = 5),
                # infoBoxOutput("primarytrait", width = 5)
                column(DT::dataTableOutput('tableprim'), width=6)
              ),
              fluidRow(
                column(div(style = "font-size: 10px;
                   padding: 20px 0px;
                   margin:0%"),
                       DT::dataTableOutput('tablecophe'), width=12))
      ),
      tabItem(tabName = "plots",
              fluidRow(
                infoBoxOutput("queryvariant2", width = 6),
                column(DT::dataTableOutput('tableprim2'), width=6)),
              fluidRow(column(div(style = "font-size: 10px;
                   padding: 20px 0px;
                   margin:0%"), offset = 1,
                              box(plotlyOutput("sus"), height = 0, width = 0), width = 9))
      ),
      # tabItem(tabName = "readme",
      #         column(tags$iframe(src = "README.html", width = "1400", height = "700", style = "margin-top: 30px;", ), width = 12), offset=2
      # )
      tabItem(tabName = "intro",
              fluidRow(
                     box(width=12,
                       title = "INTRODUCTION",
                       closable = FALSE,
                       status = "primary",
                       solidHeader = FALSE,
                       collapsible = TRUE,
                       uiOutput("intro")
                     )
              )
      ),
      tabItem(tabName = "readme",
              fluidRow(
                box(width=12,
                    title = "README",
                    closable = FALSE,
                    status = "primary",
                    solidHeader = FALSE,
                    collapsible = TRUE,
                    uiOutput("readme")
                )
              )
      )
    )
  )
)


