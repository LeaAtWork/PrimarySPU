<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:s="uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" 
                xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" 
                xmlns:rs="urn:schemas-microsoft-com:rowset" 
                xmlns:z="#RowsetSchema">
  <xsl:template match="/">

    <html>
		<head>
			<style>
			  table.dashboardThing, table.dashboardThing th, table.dashboardThing td
			  {
			  border-collapse:collapse;
			  border:1px solid black;
			  text-align:center;
			  font-size:9pt;
			  padding:4px;
			  }
			</style>
			          <script src="http://spu-sharepoint/DWWQ/Teams/SOPA/Sub/jquery182.js" />

		</head>
	<table class="dashboardThing">
		<tr id="headerRow">
			<th>NPDES Monitoring Designation</th>
			<th>SCADA Ready</th>
			<th>Monitoring Equipment Installed</th>
			<th>WonderWare (Control Center)</th>
			<th>WonderWare (IMS)</th>
			<th>Associated RainGages Commissioned</th>
			<th>FOP</th>
			<th>Maximo Onboarding and Prev Maint Plan</th>
			<th>CC/SOPA Authorize ADS Decommission</th>
			<th>Commission</th>
			<th>Vendor Equipment Removed</th>
			<th>Monitoring and Alarm Response</th>
			<th>Data QAQC (Screening)</th>
			<th>Data QAQC (Finalization)</th>
			<th>CSO Calculation and Reporting (Event Data)</th>
		</tr>
		<xsl:for-each select="//rs:data/z:row" >
			<tr>
				<td>
					<xsl:value-of select="@ows_LinkTitle"/>
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_SCADAReady" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_EquipmentInstalled" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_WonderWareControlCenter" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_WonderWareIMS" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_RainGagesCommissioned" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_FOP" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_MaximoOnboarding" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_ADSDecomAuthorized" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_Commissioning" />
				</td>
				<td class="cuteStatus">
					<xsl:value-of select="@ows_VendorEquipmentRemoved" />
				</td>
				<td class="cuteResponsible">
					<xsl:value-of select="@ows_MonitoringResponse" />
				</td>
				<td class="cuteResponsible">
					<xsl:value-of select="@ows_DataScreening" />
				</td>
				<td class="cuteResponsible">
					<xsl:value-of select="@ows_DataFinalization" />
				</td>
				<td class="cuteResponsible">
					<xsl:value-of select="@ows_EventCalculationReporting" />
				</td>
				
				
			</tr>
		</xsl:for-each>
	</table>
	</html>

</xsl:template>

</xsl:stylesheet>