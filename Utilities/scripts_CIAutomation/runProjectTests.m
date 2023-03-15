function results = runProjectTests()
% This script is to automate the tests contained in this project

% List names of all test files
    results = [];
    testsName = {'dcmtrCTRL_PID_Tests'};

% Get handle to project
    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)


for i = 1:length(testsName)
    
    disp(['Running Model Tests from: ' testsName{i}])
    % Load test file and setup plugins to generate usable test reports    
        sltest.testmanager.load([testsName{i} '.mldatx']);
    
        import matlab.unittest.TestSuite
        suite = testsuite([testsName{i} '.mldatx']);
        
        import matlab.unittest.TestRunner
        myrunner = TestRunner.withNoPlugins;
    
        % Publish Results as MLDATX
            import sltest.plugins.TestManagerResultsPlugin
            mldatxFileName = fullfile(prj.RootFolder,...
                'GeneratedArtifacts','TestResults',[testsName{i} '_Results.mldatx']);
            tmr = TestManagerResultsPlugin('ExportToFile',mldatxFileName); 
            addPlugin(myrunner,tmr)
        
        % Publish Results as PDF
            import matlab.unittest.plugins.TestReportPlugin
            pdfFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName{i} '.pdf']);
            trp = TestReportPlugin.producingPDF(pdfFile);
            addPlugin(myrunner,trp)
    
        % Publish Results as TAP Report and JUnitFormat
            import matlab.unittest.plugins.TAPPlugin
            import matlab.unittest.plugins.XMLPlugin
            import matlab.unittest.plugins.ToFile
        
            tapFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName{i} '.tap']);
            tap = TAPPlugin.producingVersion13(ToFile(tapFile));
            addPlugin(myrunner,tap)
            
            xmlFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName{i} '_results.xml']);
            p = XMLPlugin.producingJUnitFormat(xmlFile);
            addPlugin(myrunner,p)
    
        % Publish Coverage Report
            import sltest.plugins.coverage.CoverageMetrics
            cmet = CoverageMetrics('Decision',true,'Condition',true,'MCDC',true);
        
            import sltest.plugins.coverage.ModelCoverageReport
            import matlab.unittest.plugins.codecoverage.CoberturaFormat
            
            rptfile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName{i} '_cov.xml']);
            rpt = CoberturaFormat(rptfile);
        
            import sltest.plugins.ModelCoveragePlugin
            mcp = ModelCoveragePlugin('Collecting',cmet,'Producing',rpt);
        
            addPlugin(myrunner,mcp)
                % Turn off command line warnings:
                warning off Stateflow:cdr:VerifyDangerousComparison
                warning off Stateflow:Runtime:TestVerificationFailed
    
    % Run the tests
        result = run(myrunner,suite);
        results = [results result];

end

% Cleanup
    disp('Tests complete.')
    sltest.testmanager.clearResults
    sltest.testmanager.clear