name := "playframework-racine"

version := "1.0-SNAPSHOT"

libraryDependencies ++= Seq(
  javaJdbc,
  javaEbean,
  cache,
  "org.webjars" %% "webjars-play" % "2.2.1-2",
  "org.webjars" % "webjars-locator" % "0.12",
  "org.webjars" % "requirejs" % "2.1.5",
  "org.webjars" % "bootstrap" % "3.1.1" exclude("org.webjars", "jquery"),
  "org.webjars" % "jquery" % "2.1.0-2",
  "org.webjars" % "fullcalendar" % "1.6.4",
  "org.webjars" % "bootstrap-datetimepicker" % "2.2.0"
)     

// This tells Play to optimize this file and its dependencies
requireJs += "index.js"

// The main config file
// See http://requirejs.org/docs/optimization.html#mainConfigFile
//requireJsShim += "config.js"

play.Project.playJavaSettings
