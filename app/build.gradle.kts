plugins {
    // Apply the application plugin to add support for building a CLI application in Java.
    application
    java
    antlr
}

repositories {
    // Use Maven Central for resolving dependencies.
    mavenCentral()
}

dependencies {
    // This dependency is used by the application.
    implementation(libs.guava)

    antlr("org.antlr:antlr4:4.13.1")
    implementation("org.antlr:antlr4-runtime:4.13.1")
}

// Apply a specific Java toolchain to ease working on different environments.
java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

application {
    // Define the main class for the application.
    mainClass.set("toyccompiler.App")
}

tasks.generateGrammarSource {
    arguments = arguments + listOf(
        "-visitor", // Generates visitor interface
        "-package", "antlr", // Custom package
        "-Xexact-output-dir" // For precise output control
    )
    outputDirectory = file("src/main/java/antlr") // Custom output dir
}
