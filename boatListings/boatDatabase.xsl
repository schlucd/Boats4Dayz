<?xml version="1.0" encoding="UTF-8" ?>
<!--
   Business Architect
   Sprint 3

   Boat Database Stylesheet
   Author: Michael Williams
   Date:   12/05/2016

   Filename:         boatDatabase.xsl
   Supporting Files: boatDatabase.xml
-->


<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     
     <xsl:variable name="boats" select="document('boatDatabase.xml')" />
	 <xsl:key name="boatTypes" match="boat" use="type" />
     <!--
     <xsl:key name="boatTypes" match="boat" use="style" />
     
     <xsl:key name="fKey" match="firm" use="@firmNum" />-->
     

   <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />


   <xsl:template match="/">
      <html>
         <head>
            <title>Boat Listings</title>
            <link href="homestyles.css" rel="stylesheet" type="text/css" />
         </head>

         <body>
            <div id="wrap">


               <h1>New Listings</h1>
               <section id="style_list">
               |
                 <xsl:apply-templates
                   select="boats/boat[not(type=preceding::boat/type)]" 
                   mode="styleList">
                   
                   <xsl:sort select="type" />
                 </xsl:apply-templates>
                </section>
                <xsl:for-each select="//boat[generate-id()=generate-id(key('boatTypes', type)[1])]">
                	<xsl:sort select="type" />
                	<h2 id="{generate-id()}"><xsl:value-of select="type" /></h2>
                	
                    <xsl:apply-templates select="key('boatTypes', type)">
                       <xsl:sort select="price" order="descending" />
                    </xsl:apply-templates>
                                    	
                </xsl:for-each>

             </div>
         </body>

      </html>
   </xsl:template>


   <xsl:template match="boat">
      <table class="head" cellpadding="2">		
		
         <tr>
			<td rowspan="6">
				<h2>
			 
				<img name="imgFile" class="boatImage" src="{@id}.PNG" height="180" width="300" />
			
				</h2>
			</td>
            <th>Price per hour</th>
            <td><xsl:value-of select="format-number(price,'$#,##0')" /></td>
         
            <!-- Place information about the firm here -->
            <!-- <td rowspan="4">

         		<xsl:variable name="fID" select="@firm" />
         		<xsl:for-each select="$agencies" >
         			<xsl:value-of select="key('fKey', $fID)/name" /> <br />
         			<xsl:value-of select="key('fKey', $fID)/street" /> <br />
         			<xsl:value-of select="key('fKey', $fID)/city" />,
         			<xsl:value-of select="key('fKey', $fID)/state" /> &#160;
         			<xsl:value-of select="key('fKey', $fID)/zip" /><br />
         			<xsl:value-of select="key('fKey', $fID)/phone" /><br />
         			<xsl:value-of select="key('fKey', $fID)/web" />
         		</xsl:for-each>            	

            </td> **taken out** -->
         </tr>
        <!--  <tr>
            <th>Address</th>
            <td>
               <xsl:value-of select="street" /><br />
               <xsl:value-of select="city" />, <xsl:value-of select="state" />
               <xsl:text> </xsl:text><xsl:value-of select="zip" />
            </td>
         </tr> -->
         <tr>
            <th>Name</th>
            <td><xsl:value-of select="name" /></td>
         </tr>
         <tr>
            <th>Type</th>
            <td><xsl:value-of select="type" /></td>
         </tr>
         <tr>  
            <th>Make</th>
            <td><xsl:value-of select="make" /></td>

           <!-- Place information about the agent here 
            <td rowspan="3">
         		<xsl:variable name="aID" select="@agent" />
         		<xsl:for-each select="$agencies">
         			<xsl:value-of select="key('aKey', $aID)/name" /> <br />
         			<xsl:value-of select="key('aKey', $aID)/phone" /> <br />
         			<xsl:value-of select="key('aKey', $aID)/email" />
         		</xsl:for-each>
            </td>-->
         </tr>
         <tr>	
            <th>Capacity</th>
            <td><xsl:value-of select="capacity" /></td>
         </tr>
        <!--  <tr>
            <th>Garage</th>
            <td><xsl:value-of select="garage" /></td>
         </tr> -->
      </table>
   </xsl:template>
	
   <xsl:template match="boat" mode="styleList">
     <a href="#{generate-id()}">
     	<xsl:value-of select="type" />
     </a>
     (<xsl:value-of select="count(key('boatTypes', type))" />) |
   </xsl:template>
	
</xsl:stylesheet>