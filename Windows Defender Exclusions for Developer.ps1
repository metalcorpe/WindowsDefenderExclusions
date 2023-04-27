param(
    [Parameter(Mandatory, HelpMessage = "Select Scope ['all']", Position = 1)][ValidateSet('all')][string[]]$Scope
)

# See: https://medium.com/burak-tasci/tweaking-the-environment-to-speed-up-visual-studio-79cd1920fed9
$userPath = $env:USERPROFILE
$pathExclusions = New-Object System.Collections.ArrayList
$processExclusions = New-Object System.Collections.ArrayList
$extensionExclusions = New-Object System.Collections.ArrayList

Function CI {
    $pathExclusions.Add('C:\Windows\Microsoft.NET') > $null
    $pathExclusions.Add('C:\Windows\assembly') > $null
    $pathExclusions.Add('C:\P4V') > $null
    $pathExclusions.Add('C:\P4S') > $null
    $pathExclusions.Add('C:\P4P') > $null
    $pathExclusions.Add('C:\P4') > $null
    $pathExclusions.Add('C:\DDC') > $null
    $pathExclusions.Add('C:\Jenkins') > $null
    $pathExclusions.Add('C:\_JenkinsMerge') > $null
    $pathExclusions.Add('C:\JenkinsSlave') > $null
    $pathExclusions.Add('C:\JenkinsWorkspaces') > $null
    $pathExclusions.Add('C:\Staging') > $null
}

Function Tools {
    $pathExclusions.Add($userPath + '\.dotnet') > $null
    $pathExclusions.Add($userPath + '\.librarymanager') > $null
    
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VisualStudio Services') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\GitCredentialManager') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\GitHubVisualStudio') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\dotnet') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSApplicationInsights') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\VSCommon') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Temp\VSFeedbackIntelliCodeLogs') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\Microsoft Visual Studio') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\NuGet') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\Visual Studio Setup') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\vstelemetry') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\Microsoft\VisualStudio') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\HeidiSQL') > $null
    $pathExclusions.Add('C:\ProgramData\Microsoft\VisualStudio') > $null
    $pathExclusions.Add('C:\ProgramData\Microsoft\NetFramework') > $null
    $pathExclusions.Add('C:\ProgramData\Microsoft VisualStudio') > $null
    $pathExclusions.Add('C:\ProgramData\MySQL') > $null
    $pathExclusions.Add('C:\ProgramData\Git') > $null
    $pathExclusions.Add('C:\Program Files (x86)\MSBuild') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft Visual Studio 14.0') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft Visual Studio 10.0') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft Visual Studio') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft SDKs') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Common Files\Microsoft Shared\MSEnv') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft SQL Server') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Entity Framework Tools') > $null
    $pathExclusions.Add('C:\Program Files (x86)\IIS') > $null
    $pathExclusions.Add('C:\Program Files (x86)\IIS Express') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft Web Tools') > $null
    $pathExclusions.Add('C:\Program Files (x86)\Microsoft.NET') > $null
    $pathExclusions.Add('C:\Program Files (x86)\MySQL') > $null
    $pathExclusions.Add('C:\Program Files (x86)\NuGet') > $null
    $pathExclusions.Add('C:\Program Files\dotnet') > $null
    $pathExclusions.Add('C:\Program Files\Microsoft SDKs') > $null
    $pathExclusions.Add('C:\Program Files\Microsoft SQL Server') > $null
    $pathExclusions.Add('C:\Program Files\IIS') > $null
    $pathExclusions.Add('C:\Program Files\IIS Express') > $null
    $pathExclusions.Add('C:\Program Files\MySQL') > $null
    $pathExclusions.Add('C:\Program Files\Git') > $null
}

Function Cache {
    #region Cache Folders
    $pathExclusions.Add($userPath + '\.nuget') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Microsoft\WebsiteCache') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Jetbrains') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\Microsoft\VisualStudio') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\JetBrains') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\npm') > $null
    $pathExclusions.Add($userPath + '\AppData\Roaming\npm-cache') > $null
    $pathExclusions.Add('C:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files') > $null
    $pathExclusions.Add('C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files') > $null
    #endregion
}

Function VS {
    #region VS
    $processExclusions.Add('vshost-clr2.exe') > $null       # vshost-clr2.exe is used by Visual Studio to provide a debugging environment for .NET Framework applications and works in conjunction with the Visual Studio Hosting Process (vshost.exe).
    $processExclusions.Add('VSInitializer.exe') > $null     # VSInitializer.exe is a process used by Visual Studio to initialize the application and set up the environment. It helps to speed up the launch time of the application by performing initialization tasks in the background.
    $processExclusions.Add('VSIXInstaller.exe') > $null     # VSIXInstaller.exe is used to install Visual Studio extensions and manage add-ons for the Visual Studio IDE.
    $processExclusions.Add('VSLaunchBrowser.exe') > $null   # VSLaunchBrowser.exe is used by Visual Studio to launch web applications in a browser for debugging and testing purposes.
    $processExclusions.Add('vsn.exe') > $null               # vsn.exe is used by Visual Studio to manage the versioning and signing of .NET Framework assemblies through a command-line interface.
    $processExclusions.Add('VsRegEdit.exe') > $null         # VsRegEdit.exe is used by Visual Studio to view, edit, and manage the Visual Studio registry settings through a user-friendly interface.
    $processExclusions.Add('VSWebHandler.exe') > $null      # VSWebHandler.exe is used by Visual Studio to handle HTTP requests for web applications during debugging and testing, allowing developers to interact with and debug web applications in real-time.
    $processExclusions.Add('VSWebLauncher.exe') > $null     # VSWebLauncher.exe is used by Visual Studio to launch web applications in a web browser for debugging and testing purposes, allowing developers to interact with and debug web applications in real-time.
    $processExclusions.Add('XDesProc.exe') > $null          # XDesProc.exe is used by Visual Studio to provide design-time support for Windows Forms and WPF applications, allowing developers to visually design the user interface of their applications.
    $processExclusions.Add('Blend.exe') > $null             # Blend.exe is used by Visual Studio to create and design user interfaces for XAML-based applications using a drag-and-drop interface and a wide range of design tools and features.
    $processExclusions.Add('DDConfigCA.exe') > $null        # DDConfigCA.exe is used by Visual Studio to configure the permissions and security settings for the ClickOnce deployment of .NET applications through a command-line interface.
    $processExclusions.Add('devenv.exe') > $null            # devenv.exe is the main executable file for Microsoft Visual Studio's integrated development environment, which is used by developers to create and edit software applications for a variety of platforms.
    $processExclusions.Add('FeedbackCollector.exe') > $null # FeedbackCollector.exe is used by Visual Studio to collect feedback and diagnostic data from users who participate in the Visual Studio Customer Experience Improvement Program.
    $processExclusions.Add('Microsoft.VisualStudio.Web.Host.exe') > $null   # Microsoft.VisualStudio.Web.Host.exe is used by Visual Studio to host and debug web applications locally, providing a lightweight web server and handling requests for both static and dynamic content.
    $processExclusions.Add('mspdbsrv.exe') > $null          # mspdbsrv.exe is used by Visual Studio to manage access to program database (PDB) files during the debugging process, allowing multiple instances of the debugger to access them simultaneously.
    $processExclusions.Add('MSTest.exe') > $null            # MSTest.exe is used by Visual Studio to run automated tests on .NET applications, allowing developers to test the functionality and performance of their code using the MSTest framework and a command-line interface.
    $processExclusions.Add('PerfWatson2.exe') > $null       # PerfWatson2.exe is used by Visual Studio to collect performance and diagnostic data from the IDE and send it to Microsoft for analysis, with the goal of identifying and diagnosing issues and developing solutions to improve the performance and reliability of the IDE over time.
    $processExclusions.Add('Publicize.exe') > $null         # Publicize.exe is used by Visual Studio to publish and deploy applications to various platforms and app stores, providing a streamlined process for packaging and configuring the application for distribution.
    $processExclusions.Add('QTAgent.exe') > $null           # QTAgent.exe is a part of the QuickTest Professional (QTP) software developed by Hewlett-Packard. It is an automated testing tool used for functional and regression testing of software applications. The QTAgent.exe process is responsible for launching and controlling the automated testing process. It communicates with the application being tested and executes test scripts to verify that the application functions correctly.
    $processExclusions.Add('QTAgent_35.exe') > $null        # QTAgent_35.exe is a process used by Microsoft's Visual Studio Test Tools to execute automated UI tests on applications built with .NET Framework 3.5. It allows developers to create, manage, and run automated tests against their applications, and provides a graphical interface for viewing and analyzing test results. QTAgent_35.exe runs in the background during test execution and is responsible for interacting with the UI of the target application to perform the required actions and validate the expected results.
    $processExclusions.Add('QTAgent_40.exe') > $null        # QTAgent_40.exe is a process used by Microsoft's Visual Studio Test Tools to execute automated UI tests on applications built with .NET Framework 4.0. It allows developers to create, manage, and run automated tests against their applications, and provides a graphical interface for viewing and analyzing test results. QTAgent_35.exe runs in the background during test execution and is responsible for interacting with the UI of the target application to perform the required actions and validate the expected results.
    $processExclusions.Add('QTAgent32.exe') > $null         # QTAgent32.exe is used by Visual Studio to execute automated tests on 32-bit Windows applications using the Microsoft Visual Studio Test Agent, providing a framework for executing tests in a variety of environments and configurations.
    $processExclusions.Add('QTAgent32_35.exe') > $null      # QTAgent32_35.exe is used by Visual Studio to execute automated tests on 32-bit Windows applications using the Microsoft Visual Studio Test Agent 2010, providing a framework for executing tests in a variety of environments and configurations.
    $processExclusions.Add('QTAgent32_40.exe') > $null      # QTAgent32_40.exe is used by Visual Studio to execute automated tests on 32-bit Windows applications using the Microsoft Visual Studio Test Agent 2012, providing a framework for executing tests in a variety of environments and configurations.
    $processExclusions.Add('QTDCAgent.exe') > $null         # QTDCAgent.exe is a Windows executable file that belongs to the QuickTest Professional (QTP) software, which is now known as Unified Functional Testing (UFT). It is a component of the test automation framework used to perform functional and regression testing on software applications. QTDCAgent.exe is responsible for communicating with the application under test and capturing objects, properties, and methods. It also provides support for distributed testing and allows tests to be executed on remote machines.
    $processExclusions.Add('QTDCAgent32.exe') > $null       # QTDCAgent32.exe is a software component developed by QuickTime, a multimedia software framework developed by Apple Inc. It is used for managing and coordinating the QuickTime Direct Component (QTDC) system. QTDC is a set of software components used to enhance the performance of multimedia applications on Windows-based systems. QTDCAgent32.exe is responsible for managing the installation and updating of QTDC components on the system. It is typically installed as part of the QuickTime software package.
    $processExclusions.Add('StorePID.exe') > $null          # StorePID.exe is a Windows system process that is associated with the Windows Store. The process is responsible for activating and managing licenses for apps installed from the Windows Store. When a user installs an app from the Windows Store, StorePID.exe generates a unique Product ID (PID) for that app, which is used to activate and verify the license for the app on the user's system.
    $processExclusions.Add('T4VSHostProcess.exe') > $null   # T4VSHostProcess.exe is a process used by Visual Studio to execute text templates created using the Text Template Transformation Toolkit (T4). It is responsible for compiling and executing the T4 template code and generating output files such as source code files or configuration files.
    $processExclusions.Add('TailoredDeploy.exe') > $null    # TailoredDeploy.exe is a tool used in Microsoft Dynamics AX to deploy customizations and configurations. It provides a way to package changes made to the application into a deployable package that can be distributed to other environments or customers. The tool performs several functions, including creating and managing deployment packages, validating package contents, and deploying packages to target environments.
    $processExclusions.Add('TCM.exe') > $null               # TCM.exe is a command-line tool provided by Microsoft Visual Studio and Microsoft Test Manager that allows users to execute automated tests and collect test data for analysis. It is primarily used for managing and running automated tests within the Visual Studio testing framework, and can be used with various testing frameworks including MSTest, NUnit, and xUnit. TCM.exe can also be used to create, manage, and execute test plans, test cases, and test suites, and to collect and analyze test results. It is a useful tool for software developers and testers who need to automate and manage their testing process.
    $processExclusions.Add('TextTransform.exe') > $null     # TextTransform.exe is a command-line utility that is part of the Visual Studio SDK. It is used to execute Text Template Transformation Toolkit (T4) templates and generate code from them. T4 templates are text files that contain a mix of text and code, which can be transformed into other text files, such as source code files, XML files, or HTML files. TextTransform.exe can be used to automate the code generation process, which can help developers save time and improve code consistency.
    $processExclusions.Add('TfsLabConfig.exe') > $null      # TfsLabConfig.exe is a command-line utility used to configure Team Foundation Server (TFS) Lab Management environments. It allows users to create, modify, and delete lab environments, manage virtual machines, and automate various tasks related to lab management. The utility is typically used by administrators and developers working with TFS to manage lab environments for testing and development purposes.
    $processExclusions.Add('UserControlTestContainer.exe') > $null  # UserControlTestContainer.exe is a utility executable file used by Microsoft Visual Studio for creating and running user control tests. It is typically used by developers to test user controls and ensure that they function correctly. The tool is part of the .NET Framework and allows users to create tests in various languages, including C# and Visual Basic.NET. Once the tests are created, UserControlTestContainer.exe can be used to run them and analyze the results.
    $processExclusions.Add('vb7to8.exe') > $null            # vb7to8.exe is a command-line tool used to upgrade Visual Basic 7.0 projects to Visual Basic 8.0 projects. The tool automatically updates the syntax of the Visual Basic 7.0 code to be compatible with the Visual Basic 8.0 compiler. This makes it easier for developers to migrate their code to the newer version of Visual Basic.
    $processExclusions.Add('VcxprojReader.exe') > $null     # VcxprojReader.exe is a command-line tool used in Microsoft Visual Studio for reading and displaying information about Visual C++ project files (vcxproj). It allows developers to extract information about project configuration, source files, compiler options, and more from the project file. This tool is primarily used for debugging and troubleshooting purposes.
    $processExclusions.Add('VsDebugWERHelper.exe') > $null  # VsDebugWERHelper.exe is a process that assists with error reporting in Visual Studio. When a Visual Studio application encounters a fatal error, the process creates a Windows Error Reporting (WER) report that can be used to diagnose and fix the problem. The VsDebugWERHelper.exe process is responsible for communicating with the WER system to generate the report and provide additional information about the error.
    $processExclusions.Add('VSFinalizer.exe') > $null       # VSFinalizer.exe is a background process that runs when Visual Studio is closed. Its main purpose is to clean up any resources or memory that were used by Visual Studio during its execution. It also performs other tasks such as updating settings, saving user preferences, and closing any running processes or services related to Visual Studio. This helps to ensure that Visual Studio starts up quickly and runs smoothly the next time it is opened.
    $processExclusions.Add('VsGa.exe') > $null              # VsGa.exe is a tool used by Microsoft Visual Studio for collecting data about usage and diagnostics of the product. It runs in the background and sends telemetry data to Microsoft, which can be used to improve the quality and performance of the software. Users can choose to opt out of this data collection during installation or through the Visual Studio options menu.
    $processExclusions.Add('VSHiveStub.exe') > $null        # VSHiveStub.exe is a process used by Microsoft Visual Studio to manage access to the registry hive, which stores configuration data for the Visual Studio instance. It runs as a background process and is responsible for loading and unloading registry hives. It is typically launched when a user starts Visual Studio and runs until the application is closed.
    $processExclusions.Add('vshost.exe') > $null            # vshost.exe is a process used by Visual Studio to run applications during the debugging process. It is a hosting process that runs alongside the application being debugged, and allows for debugging features such as breakpoints and variable inspection.
    $processExclusions.Add('vshost32.exe') > $null          # vshost32.exe is a process used by Visual Studio to run applications during the debugging process. It is a 32-bit hosting process that runs alongside the application being debugged, and allows for debugging features such as breakpoints and variable inspection.
    $processExclusions.Add('vshost32-clr2.exe') > $null     # vshost32-clr2.exe is a Windows process that acts as a hosting environment for .NET Framework applications developed in Visual Studio. It is a 32-bit version of the vshost.exe process that allows developers to debug and test their applications in a controlled environment. The process runs in the background when a Visual Studio project is launched and provides a number of services for the application, including debugging, profiling, and code coverage analysis.
    #endregion
}

function VSCode {
    #region VS Code
    $processExclusions.Add('Code - Insiders.exe') > $null
    $processExclusions.Add('Code.exe') > $null
    $processExclusions.Add('vstest.console.exe') > $null
    #endregion    
}

Function BuildTools {
    #region Runtimes, build tools
    $processExclusions.Add('dotnet.exe') > $null
    $processExclusions.Add('mono.exe') > $null
    $processExclusions.Add('mono-sgen.exe') > $null
    $processExclusions.Add('java.exe') > $null
    $processExclusions.Add('java64.exe') > $null
    $processExclusions.Add('msbuild.exe') > $null
    $processExclusions.Add('node.exe') > $null
    $processExclusions.Add('node.js') > $null
    $processExclusions.Add('perfwatson2.exe') > $null
    $processExclusions.Add('ServiceHub.Host.Node.x86.exe') > $null
    $processExclusions.Add('vbcscompiler.exe') > $null
    $processExclusions.Add('nuget.exe') > $null
    $processExclusions.Add('cake.exe') > $null
    $processExclusions.Add('packet.exe') > $null
    $processExclusions.Add('csc.exe') > $null
    $processExclusions.Add('fsc.exe') > $null
    $processExclusions.Add('mysqld.exe') > $null
    $processExclusions.Add('git.exe') > $null
    $processExclusions.Add('heidisql.exe') > $null
    #endregion
}

Function Shells {
    #region Shells
    $processExclusions.Add('git-bash.exe') > $null
    $processExclusions.Add('bash.exe') > $null
    $processExclusions.Add('powershell.exe') > $null
    #endregion
}

Function JetBrains {
    #region All of JetBrains stuff
    $processExclusions.Add('JetBrains.EntityFramework.Runner620.exe') > $null
    $processExclusions.Add('JetBrains.MsBuild.TaskEntryPoint.exe') > $null
    $processExclusions.Add('JetBrains.Platform.Satellite.exe') > $null
    $processExclusions.Add('JetBrains.ReSharper.Features.XamlPreview.External.exe') > $null
    $processExclusions.Add('JetBrains.ReSharper.Host.exe') > $null
    $processExclusions.Add('JetBrains.ReSharper.Host64.exe') > $null
    $processExclusions.Add('JetBrains.ReSharper.Roslyn.Worker.exe') > $null
    $processExclusions.Add('JetLauncher32.exe') > $null
    $processExclusions.Add('JetLauncher32c.exe') > $null
    $processExclusions.Add('JetLauncher64.exe') > $null
    $processExclusions.Add('JetLauncher64c.exe') > $null
    $processExclusions.Add('JetLauncherIL.exe') > $null
    $processExclusions.Add('JetLauncherILc.exe') > $null
    $processExclusions.Add('OperatorsResolveCacheGenerator.exe') > $null
    $processExclusions.Add('PsiGen.exe') > $null
    $processExclusions.Add('ReSharperTestRunner32.exe') > $null
    $processExclusions.Add('ReSharperTestRunner64.exe') > $null
    $processExclusions.Add('ReSharperTestRunnerIL.exe') > $null
    $processExclusions.Add('RiderClrProcessEnumerator32.exe') > $null
    $processExclusions.Add('RiderClrProcessEnumeratorIL.exe') > $null
    $processExclusions.Add('TokenGenerator.exe') > $null
    $processExclusions.Add('xamarin-component.exe') > $null
    $processExclusions.Add('ClrStack.x64.exe') > $null
    $processExclusions.Add('ClrStack.x86.exe') > $null
    $processExclusions.Add('CsLex.exe') > $null
    $processExclusions.Add('ErrorsGen.exe') > $null
    $processExclusions.Add('JetBrains.Debugger.Worker.exe') > $null
    $processExclusions.Add('JetBrains.Debugger.Worker32c.exe') > $null
    $processExclusions.Add('JetBrains.Debugger.Worker64c.exe') > $null
    $processExclusions.Add('dotPeek32.exe') > $null
    $processExclusions.Add('dotPeek64.exe') > $null
    $processExclusions.Add('DotTabWellScattered32.exe') > $null
    $processExclusions.Add('DotTabWellScattered64.exe') > $null
    $processExclusions.Add('DotTabWellScatteredIL.exe') > $null
    $processExclusions.Add('JetBrains.Platform.Installer.Bootstrap.exe') > $null
    $processExclusions.Add('JetBrains.Platform.Installer.Cleanup.exe') > $null
    $processExclusions.Add('JetBrains.Platform.Installer.exe') > $null
    $processExclusions.Add('CleanUpProfiler.x64.exe') > $null
    $processExclusions.Add('CleanUpProfiler.x86.exe') > $null
    $processExclusions.Add('Configuration2Xml32.exe') > $null
    $processExclusions.Add('Configuration2Xml64.exe') > $null
    $processExclusions.Add('ConsoleProfiler.exe') > $null
    $processExclusions.Add('dotTrace32.exe') > $null
    $processExclusions.Add('dotTrace64.exe') > $null
    $processExclusions.Add('DotTraceLauncher.exe') > $null
    $processExclusions.Add('dotTraceView32.exe') > $null
    $processExclusions.Add('dotTraceView64.exe') > $null
    $processExclusions.Add('JetBrains.Common.ElevationAgent.exe') > $null
    $processExclusions.Add('JetBrains.Common.ExternalStorage.exe') > $null
    $processExclusions.Add('JetBrains.Common.ExternalStorage.x86.exe') > $null
    $processExclusions.Add('JetBrains.dotTrace.IntegrationDemo.exe') > $null
    $processExclusions.Add('Reporter.exe') > $null
    $processExclusions.Add('SnapshotStat.exe') > $null
    $processExclusions.Add('Timeline32.exe') > $null
    $processExclusions.Add('Timeline64.exe') > $null
    $processExclusions.Add('dotMemory.UI.32.exe') > $null
    $processExclusions.Add('dotMemory.UI.64.exe') > $null
    $processExclusions.Add('dotMemoryUnit.exe') > $null
    $processExclusions.Add('JetBrains.dotMemory.Console.SingleExe.exe') > $null
    $processExclusions.Add('JetBrains.dotMemoryUnit.Server.exe') > $null
    $processExclusions.Add('restarter.exe') > $null
    $processExclusions.Add('rider64.exe') > $null
    $processExclusions.Add('runnerw.exe') > $null
    $processExclusions.Add('runnerw64.exe') > $null
    $processExclusions.Add('WinProcessListHelper.exe') > $null
    $processExclusions.Add('elevator.exe') > $null
    $processExclusions.Add('fsnotifier.exe') > $null
    $processExclusions.Add('fsnotifier64.exe') > $null
    $processExclusions.Add('launcher.exe') > $null
    $processExclusions.Add('NGen Rider Assemblies.exe') > $null
    $processExclusions.Add('idea.exe') > $null
    $processExclusions.Add('idea64.exe') > $null
    $processExclusions.Add('JetBrains.Etw.Collector.Host.exe') > $null
    #endregion
    
    #region JB Toolbox
    $processExclusions.Add('jetbrains-toolbox.exe') > $null
    $processExclusions.Add('jetbrains-toolbox-cef.exe') > $null
    $processExclusions.Add('jetbrains-toolbox-cef-helper.exe') > $null
    #endregion
}

Function Unity {
    #region Unity
    $processExclusions.Add('UnityHelper.exe') > $null
    $processExclusions.Add('Unity.exe') > $null
    $processExclusions.Add('UnityShaderCompiler.exe') > $null
    $processExclusions.Add('UnityYAMLMerge.exe') > $null
    $processExclusions.Add('UnityCrashHandler64.exe') > $null
    #endregion
}

Function Misc {
    #region More: https://github.com/AshSewell/WindowsDefenderExclusions.git
    $pathExclusions.Add('C:\ProgramData\Microsoft Visual Studio') > $null
    $pathExclusions.Add('C:\Program Files\Microsoft Visual Studio') > $null
    $pathExclusions.Add('C:\Program Files\Epic Games') > $null
    $pathExclusions.Add('C:\Program Files\Perforce') > $null
    $pathExclusions.Add('C:\Program Files (x86)\dotnet') > $null
    
    $processExclusions.Add('ServiceHub.SettingsHost.exe') > $null
    $processExclusions.Add('ServiceHub.IdentityHost.exe') > $null
    $processExclusions.Add('ServiceHub.VSDetouredHost.exe') > $null
    $processExclusions.Add('ServiceHub.Host.CLR.x86.exe') > $null
    $processExclusions.Add('Microsoft.ServiceHub.Controller.exe') > $null
    $processExclusions.Add('sqlwriter.exe') > $null
    $processExclusions.Add('cl.exe') > $null
    $processExclusions.Add('link.exe') > $null
    $processExclusions.Add('cl-filter.exe') > $null
    $processExclusions.Add('link-filter.exe') > $null
    $processExclusions.Add('jp2launcher.exe') > $null
    $processExclusions.Add('vcpkgsrv.exe') > $null
    $processExclusions.Add('vctip.exe') > $null
    $processExclusions.Add('VaCodeInspectionsServer.exe') > $null
    $processExclusions.Add('VaDbMtx64.exe') > $null
    $processExclusions.Add('MSBuild.exe') > $null
    $processExclusions.Add('UE4Editor.exe') > $null
    $processExclusions.Add('UnrealEditor.exe') > $null
    $processExclusions.Add('UnrealBuildTool.exe') > $null
    $processExclusions.Add('UnrealHeaderTool.exe') > $null
    $processExclusions.Add('UnrealPak.exe') > $null
    $processExclusions.Add('AutomationTool.exe') > $null
    $processExclusions.Add('ShaderCompileWorker.exe') > $null
    $processExclusions.Add('p4ps.exe') > $null
    
    $extensionExclusions.Add('.c') > $null
    $extensionExclusions.Add('.cpp') > $null
    $extensionExclusions.Add('.cs') > $null
    $extensionExclusions.Add('.h') > $null
    $extensionExclusions.Add('.hpp') > $null
    $extensionExclusions.Add('.o') > $null
    $extensionExclusions.Add('.a') > $null
    $extensionExclusions.Add('.pdb') > $null
    $extensionExclusions.Add('.db') > $null
    $extensionExclusions.Add('.sln') > $null
    $extensionExclusions.Add('.vcxproj') > $null
    $extensionExclusions.Add('.user') > $null
    $extensionExclusions.Add('.uproject') > $null
    #endregion
}

Function Golang {
    $goPath = $env:GOPATH

    $processExclusions.Add('go.exe') > $null
    $processExclusions.Add('dlv.exe') > $null
    $processExclusions.Add('golint.exe') > $null
    $processExclusions.Add('guru.exe') > $null
    $processExclusions.Add('godef.exe') > $null

    $processExclusions.Add('goland.exe') > $null

    $extensionExclusions.Add('.go') > $null
    $extensionExclusions.Add('.mod') > $null
    $extensionExclusions.Add('.sum') > $null

    $pathExclusions.Add('C:\Go\bin') > $null
    $pathExclusions.Add('C:\Program Files\JetBrains\GoLand') > $null

    $pathExclusions.Add($goPath + '\pkg') > $null
    $pathExclusions.Add($goPath + '\bin') > $null
    $pathExclusions.Add($userPath + '\AppData\Local\Temp\go-build') > $null


}

If ($Scope = "all") {
    CI
    Tools
    Cache
    VS
    VSCode
    BuildTools
    Shells
    JetBrains
    Unity
    Misc
    Golang
}

Write-Host "This script will create Windows Defender exclusions for common Visual Studio folders and processes."
Write-Host ""
$projectsFolder = Read-Host 'What is the path to your Projects folder? (example: c:\projects)'

Write-Host ""
Write-Host "Adding Path Exclusion: " $projectsFolder
Add-MpPreference -ExclusionPath $projectsFolder


foreach ($exclusion in $pathExclusions) {
    Write-Host "Adding Path Exclusion: " $exclusion
    Add-MpPreference -ExclusionPath $exclusion
}

foreach ($exclusion in $processExclusions) {
    Write-Host "Adding Process Exclusion: " $exclusion
    Add-MpPreference -ExclusionProcess $exclusion
}

foreach ($exclusion in $extensionExclusions) {
    Write-Host "Adding Extension Exclusion: " $exclusion
    Add-MpPreference -ExclusionExtension $exclusion
}


Write-Host ""
Write-Host "Your Exclusions:"

$prefs = Get-MpPreference
Write-Host ""
Write-Host "Exclusion Path:"
$prefs.ExclusionPath
Write-Host ""
Write-Host "Exclusion Process:"
$prefs.ExclusionProcess
Write-Host ""
Write-Host "Exclusion Extension:"
$prefs.ExclusionExtension

Write-Host ""
Write-Host "Enjoy faster build times and coding!"
Write-Host ""