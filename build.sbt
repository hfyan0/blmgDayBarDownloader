// import AssemblyKeys._

// Project name (artifact name in Maven)
name := "blmg_day_bar_downloader"

// orgnization name (e.g., the package name of the project)
organization := "com.treasure-data"

version := "1.0-SNAPSHOT"

// project description
description := "blmg_day_bar_downloader"

// Enables publishing to maven repo
publishMavenStyle := true

// Do not append Scala versions to the generated artifacts
crossPaths := false

// This forbids including Scala related libraries into the dependency
autoScalaLibrary := true

// library dependencies. (orginization name) % (project name) % (version)
libraryDependencies ++= Seq(
  // "org.scalatest" %% "scalatest" % "1.9.1" % "test",
  "org.scalatest" %% "scalatest" % "3.0.4" % "test",
  "junit" % "junit" % "4.11" % "test",
  "com.novocode" % "junit-interface" % "0.9" % "test->default",
  "org.mockito" % "mockito-core" % "1.9.5",
  // "com.github.nscala-time" %% "nscala-time" % "2.6.0",
  "com.github.nscala-time" %% "nscala-time" % "2.16.0",
  "joda-time" % "joda-time" % "2.9.1",
  "mysql" % "mysql-connector-java" % "5.1.12"
)

javaOptions in run += "-Djava.library.path=/usr/lib/x86_64-linux-gnu/jni/"

// assemblySettings

// packSettings

enablePlugins(JavaAppPackaging, UniversalPlugin)
