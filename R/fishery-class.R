#' @title Print method for fishery objects
#' @description Shows main information from objects of the \code{fishery} class,
#' like number of records data, the time period of dates (years and months),
#' the number of ports, the analyzed species and the analyzed variable type.
#' @param x Object of \code{fishery} class.
#' @param language The select language to print the outputs.
#' @export
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # Produce a object of fishery class
#' landing  = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing", sp = "caballa")
#' class(landing)
#'
#' # Show main information of the fishery class object
#' print(landing)
#' print(landing, language = "english")
#'
#' @method print fishery
print.fishery = function(x, language="spanish") {

  if(language == "english"){
    cat("Data from: ", sQuote(x$info$file), "\n", sep="")
    cat("Number of records: ", x$info$records, "\n", sep="")
    cat("Number of months of data: ", x$info$months, "\n", sep="")
    cat("Number of years of data: ", x$info$years, "\n", sep="")
    cat("Number of ports of data: ", x$info$ports, "\n", sep="")
    cat("Analyzed species: ", x$info$sp, "\n", sep="")
    cat("Analyzed variable: ", x$info$varType, "\n", sep="")
  } else {
    cat("Datos de : ", sQuote(x$info$file), "\n", sep="")
    cat("Numero de registros: ", x$info$records, "\n", sep="")
    cat("Numero de meses de la data: ", x$info$months, "\n", sep="")
    cat("Numero de ahnos de la data: ", x$info$years, "\n", sep="")
    cat("Numero de puertos: ", x$info$ports, "\n", sep="")
    cat("Especie analizada: ", x$info$sp, "\n", sep="")
    cat("Variable analizada: ", x$info$varType, "\n", sep="")
  }

  return(invisible())
}

#' @title Summary method for fishery objects
#' @description Get summary information of landing and fishing effort included on
#' objects of \code{fishery} class.
#' @param object Object of \code{fishery} class.
#' @param language The select language to print the summary of fishery objects.
#' It could be \code{"spanish"} by default or \code{"english"}.
#' @return A \code{list} of summary.fishery class. This contains:
#' \itemize{
#'   \item var The type of the variable that has been to analyze. This can be lading or effort.
#'   \item portDay A data frame with the information of the variable analyzed by day and port.
#'   \item day A data frame with the information of the variable by day.
#'   \item port A data frame with the information of the variable by ports.
#'   \item months A data frame with the information of the variable by months.
#'   \item years A data frame with the information of the variable by years.
#' }
#' @export
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # Produce a object of fishery class
#' landing  = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing", sp = "caballa")
#' class(landing)
#'
#' # Produce the summary of the fishery class object
#' summary(landing)
#'
#' @method summary fishery
summary.fishery =  function(object, language = "spanish") {

  object2 = object
  if(language=="spanish"){
    object2$data$month = engToSpa(object2$data$month)
    colnames(object2$data)[1:3] = c("anho", "mes", "dia")

  } else{
    object2$data$month = object2$data$month
    colnames(object2$data)[1:3] = c("year", "month", "day")
  }

  output = list()

  output$var      = object$info$varType
  output$portDay =  object2$data
  output$day     =  .getSumPorts.fishery(object=object, language=language)
  output$port    =  .getPorts.fishery(object=object, language=language)
  output$months   = .getMonth.fishery(object=object, language=language)
  output$years    = .getYear.fishery(object=object, language=language)

  class(output) = "summary.fishery"
  return(output)
}

#' @title Print method for summary.fishery
#' @description Shows main information from \code{summary.fishery} objects.
#' @param x Object of \code{summary.fishery} class.
#' @param language The select language to print the summary of fishery objects.
#' It could be \code{"spanish"} by default or \code{"english"}.
#' @return Each element of \code{summary.fishery} method.
#' @export
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # Produce a object of fishery class
#' landing  = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing", sp = "caballa")
#' class(landing)
#'
#' # Print the summary of the fishery class object
#' sumLanding = summary(landing)
#' print(sumLanding)
#'
#' sumLanding = summary(landing, language = "english")
#' print(sumLanding, language = "english")
#'
#' @method print summary.fishery
print.summary.fishery = function(x, language = "spanish") {

  x2 = x
  class(x2) = 'fishery'

  if(x$var == "landing"){
    if(language == "english"){
      cat("\nLanding by port and day (non-zero only):\n\n") ; print(x$portDay[x$portDay[,1]>0, ,drop=FALSE])
      cat("\nLanding by day:\n\n") ; print(x$day)
      cat("\nLanding by port (non-zero only):\n\n") ; print(x$port[x$port[,1]>0, ,drop=FALSE])
      cat("\nMonthly landing:\n\n") ; print(t(x$months))
      cat("\nAnnual landing:\n\n") ; print(x$years)}
    else {
      cat("\nDesembarque por puerto y por dia (solo positivos):\n\n") ; print(x$portDay[x$portDay[,1]>0, ,drop=FALSE])
      cat("\nDesembarque por dia:\n\n") ; print(x$day)
      cat("\nDesembarque por puerto (solo positivos):\n\n") ; print(x$port[x$port[,1]>0, ,drop=FALSE])
      cat("\nDesembarque mensual:\n\n") ; print(t(x$months))
      cat("\nDesembarque anual:\n\n") ; print(x$years)}

  } else {
    if(language == "english"){
      cat("\nEffort by port and day (non-zero only):\n\n") ; print(x$portDay[x$portDay[,1]>0, ,drop=FALSE])
      cat("\nEffort by day:\n\n") ; print(x$day)
      cat("\nEffort by port (non-zero only):\n\n") ; print(x$port[x$port[,1]>0, ,drop=FALSE])
      cat("\nMonthly effort:\n\n") ; print(t(x$months))
      cat("\nAnnual effort:\n\n") ; print(x$years)}
    else {
      cat("\nEsfuerzo por puerto y por dia (solo positivos):\n\n") ; print(x$portDay[x$portDay[,1]>0, ,drop=FALSE])
      cat("\nEsfuerzo por dia:\n\n") ; print(x$day)
      cat("\nEsfuerzo por puerto (solo positivos):\n\n") ; print(x$port[x$port[,1]>0, ,drop=FALSE])
      cat("\nEsfuerzo mensual:\n\n") ; print(t(x$months))
      cat("\nEsfuerzo anual:\n\n") ; print(x$years)}
  }

  return(invisible())
}

#' @title Plot method for fishery objects
#' @description This method takes a \code{fishery} object and make useful plots for
#' each variables (fishing lading and fishing effort). The plots can be daily,
#' monthly, yearly, over the peruvian region, and for north-central and south peruvian
#' region. An additional plot type to graph the effort and landing at the same time
#' using two y-axis.
#' @param x Object of \code{fishing} class.
#' @param language A \code{character}. Define the language of text labels in plots.
#' It could be \code{"spanish"} or \code{"english"}.
#' @param ploType What type of plot should be draw. Possible types are:
#' \itemize{
#'   \item plotDaily for daily plot
#'   \item plotMonthly for monthly plot
#'   \item plotYearly for yearly plot
#'   \item plotPeru for all the peruvian region
#'   \item plotNC to graph the north-central region
#'   \item plotS to graph the south region
#'   \item plotJoined to graph the effort and landing
#' }
#' @param daysToPlot If is a daily plot by default the x-axis show the first day of a week
#'  (1, 8, 15, 22) but could be change to show a specific day or to show the all days of the
#'  data with \code{all}. This is including in a vector form.
#' @param textAxis2 The text of the x axis.
#' @param textAxis4 The text of the y axis.
#' @param ... Extra arguments.
#' @return A graph of the specified type in \code{ploType}.
#' @export
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # Produce a object of fishery class
#' landing  = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing", sp = "caballa")
#' class(landing)
#'
#' plot(landing)
#' plot(landing, daysToPlot = "2", colBar = "red")
#' plot(landing, language= "english")
#' plot(landing, ploType = "plotMonthly")
#' plot(landing, ploType = "plotMonthly", language= "english")
#' plot(landing, ploType = "plotYearly")
#' plot(landing, ploType = "plotYearly", language= "english", colBar = "green")
#' plot(landing, ploType = "plotPERU")
#' plot(landing, ploType = "plotNC")
#' plot(landing, ploType = "plotS")
#'
#' @method plot fishery
plot.fishery = function(x, language = "spanish", ploType = NULL, daysToPlot = c(1,8,15,22),
                        textAxis2 = NULL, textAxis4 = NULL, colBar = "gray", colLine = "red", ...) {

  if(is.null(ploType)) ploType = "plotDaily"
  if(ploType %in% c("plotPERU", "plotNC", "plotS")){dataRegion = .getRegionData(x = x)}

  switch(ploType,
         plotDaily   = .plotDays.fishery(x=x, language=language, daysToPlot = daysToPlot, colBar = colBar, ...),

         plotMonthly = .plotMonths.fishery(x=x, language=language, colBar = colBar, ...),

         plotYearly  = .plotYears.fishery(x=x, language=language, colBar = colBar, ...),

         plotPERU    = .plotRegion(x = dataRegion, region = "PERU", daysToPlot = daysToPlot,
                                   textAxis2 = textAxis2, textAxis4 = textAxis4, ...),

         plotNC      = .plotRegion(x = dataRegion, region = "NC", daysToPlot = daysToPlot,
                                   textAxis2 = textAxis2, textAxis4 = textAxis4, ...),

         plotS       = .plotRegion(x = dataRegion, region = "S", daysToPlot = daysToPlot,
                                   textAxis2 = textAxis2, textAxis4 = textAxis4, ...),

         plotJoined  = .plotDaysJoined.fishery(x = x, language = language, daysToPlot = daysToPlot,
                                               colBar = colBar, colLine = colLine, ...))
  return(invisible())

}

#' @title Report method for fishery objects
#' @description Export a report of landing or fishing effort.
#' @param x Object of \code{fishery} class.
#' @param type To indicate if the report is going to be reproduce for individual
#' variables (for landing or for effort) use \code{type = single} (by default).
#' To reproduce a report using the joined information (landing and effort)
#' use \code{type = joined}.
#' @param daysToPlot If is a daily plot by default the x-axis show the first day of a week
#'  (1, 8, 15, 22) but could be change to show a specific day or to show the all days of the
#'  data with \code{all}. This is including in a vector form.
#' @param textAxis2 The text of the x axis.
#' @param textAxis4 The text of the y axis.
#' @export
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # Produce a object of fishery class
#' landing  = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing", sp = "caballa")
#' class(landing)
#'
#' #Produce the report showing all days on the x-axis (by default)
#' report(landing)
#'
#' #Produce the report showing only the day 15 on the x-axis
#' report(landing, daysToPlot = "15")
#'
#' @method report fishery
report.fishery = function(x, type = "singled", format="latex", tangle=FALSE, output = NULL, open = TRUE,
                          daysToPlot = c(1,8,15,22), textAxis2 = NULL, textAxis4 = NULL){

  if(is.null(output)) output = getwd()

  outputName = deparse(substitute(x))

  if(type == "singled"){
    varType = x$info$varType
    if(varType == "landing"){skeleton = system.file("reports", "fishery-report_landing.Rmd", package = "imarpe")}
    if(varType == "effort") {skeleton = system.file("reports", "fishery-report_effort.Rmd", package = "imarpe")}
  }

  if(type == "joined"){
    skeleton = system.file("reports", "fishery-report_joined.Rmd", package = "imarpe")
  }

  if(isTRUE(tangle)) {
    knit(skeleton, tangle=TRUE, encoding = "latin1")
    f1 = gsub(pattern = ".Rmd", replacement = "\\.R", skeleton)
    file.rename(from=basename(f1), to=paste0(outputName, ".R"))
  }

  outputFile = paste0(outputName, "_output.pdf")
  render(skeleton, c("pdf_document"), output_file=outputFile, output_dir=output, encoding = "latin1")

  if(isTRUE(open)) shell.exec(outputFile)

  return(invisible(file.path(output, outputFile)))

}

#' Combine fishery variables
#' @description Function to combine two fishery class outputs (landing and effort)
#' into a only list.
#' @param landing Object of \code{fishery} class and landing variable type.
#' @param effort Object of \code{fishery} class and effort variable type.
#' @return A object of \code{fishery} class with information about the two lists, the first
#' with for landing and the second for effort.
#' @examples
#' # Read a example of a data base
#' fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")
#'
#' # A fishery class object with a landing variable type
#' landingObject = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "landing",
#'  sp = "caballa")
#'
#' # A fishery class object with a effort variable type
#' effortObject = getFishingData(file = fisheryData, type = "fisheryinfo", varType = "effort",
#' sp = "caballa", efforType = "viaje")
#'
#' # Use combineFisheryVar
#' fisheryVar = combineFisheryVar(landing = landingObject, effort = effortObject)
#' class(fisheryVar)
#' @export
combineFisheryVar = function(landing, effort) {

  x = list(landing = landing,
           effort  = effort)

  class(x) = "fishery"

  return(x)
}
