<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
            xmlns:l="http://xproc.org/library"
            xmlns:c="http://www.w3.org/ns/xproc-step"
    name="pef-validator"
    version="1.0">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1>PEF-validator</h1>
        <p>Validates a PEF-file using RelaxNG and schematron rules.</p>
    </p:documentation>
    
    <p:input port="source" primary="true"/>
        
    <p:output port="result" primary="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The output from this step is a copy of the input.</p>
        </p:documentation>
        <p:pipe step="copy-source" port="result"/>
    </p:output>
    
    <p:output port="report">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>Schema assertations and reports.</p>
        </p:documentation>
        <p:pipe port="result" step="error-report"/>
    </p:output>

    <p:option name="assert-valid" required="false" select="'false'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>It is a dynamic error if the assert-valid option is true and the input document is not valid.</p>
        </p:documentation>
    </p:option>

    <p:identity name="copy-source">
        <p:input port="source"/>
    </p:identity>

    <p:try name="try-validate-rng">
        <p:group>
            <p:output port="result">
                <p:empty/>
            </p:output>
            <p:validate-with-relax-ng name="validate-rng" assert-valid="true">
                <p:input port="source">
                    <p:pipe port="result" step="copy-source"></p:pipe>
                </p:input>
                <p:input port="schema">
                    <p:document href="pef-2008-1.rng"/>
                </p:input>
            </p:validate-with-relax-ng>
            <p:sink/>
        </p:group>
        <p:catch name="catch">
            <p:output port="result">
                <p:pipe port="result" step="copy-errors"/>
            </p:output>
            <p:identity name="copy-errors">
                <p:input port="source">
                    <p:pipe step="catch" port="error"/>
                </p:input>
            </p:identity>
        </p:catch>
    </p:try>
    
    <p:try name="try-validate-schematron">
        <p:group>
            <p:output port="result">
                <p:empty/>
            </p:output>
            <p:validate-with-schematron name="validate-schematron" assert-valid="true">
                <p:input port="source">
                    <p:pipe port="result" step="copy-source"/>
                </p:input>
                <p:input port="schema">
                    <p:document href="pef-2008-1.sch"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
            </p:validate-with-schematron>
            <p:sink/>
        </p:group>
        <p:catch name="catch">
            <p:output port="result">
                <p:pipe port="report" step="validate-schematron"/>
            </p:output>
            <!-- Validate again with assert-valid=false to get the report. -->
            <p:validate-with-schematron name="validate-schematron" assert-valid="false">
                <p:input port="source">
                    <p:pipe port="result" step="copy-source"/>
                </p:input>
                <p:input port="schema">
                    <p:document href="pef-2008-1.sch"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
            </p:validate-with-schematron>
            <p:sink/>
        </p:catch>
    </p:try>

    <p:wrap-sequence name="error-report" wrapper="c:error-report">
        <p:input port="source">
            <p:pipe port="result" step="try-validate-rng"></p:pipe>
            <p:pipe port="result" step="try-validate-schematron"></p:pipe>
        </p:input>
    </p:wrap-sequence>
    
    <p:choose name="assert-valid">
        <p:xpath-context>
            <p:pipe port="result" step="error-report"/>
        </p:xpath-context>
        <p:when test="$assert-valid = 'true' and count(/*/*)&gt;0">
            <p:output port="result"/>
            <p:error code="error">
                <p:input port="source">
                    <p:pipe port="result" step="error-report"/>
                </p:input>
            </p:error>
        </p:when>
        <p:otherwise>
            <p:output port="result"/>
            <p:identity>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>
    <p:sink/>

</p:declare-step>