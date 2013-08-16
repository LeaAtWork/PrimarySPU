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
		<xsl:for-each select="//rs:data/z:row [@ows_SequenceGroup=1]" >
			<tr>
				<td>
					<xsl:value-of select="@ows_LinkTitle"/>
				</td>
				
				<xsl:choose>
					<xsl:when test="@ows_SCADAReady='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_ScadaReadyDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_SCADAReady" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="@ows_EquipmentInstalled='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_EquipmentInstalledDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_EquipmentInstalled" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="@ows_WonderWareControlCenter='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_WWControlCenterDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_WonderWareControlCenter" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="@ows_WonderWareIMS='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_WWIMSDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_WonderWareIMS" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
			
				<xsl:choose>
					<xsl:when test="@ows_RainGagesCommissioned='NA'">
						<td>
							NA
						</td>
					</xsl:when>
					<xsl:when test="@ows_RainGagesCommissioned='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_RainGagesCommissionedDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_RainGagesCommissioned" />
						</td>
					</xsl:otherwise>
				</xsl:choose>				

				<xsl:choose>
					<xsl:when test="@ows_FOP='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_FOPDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_FOP" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="@ows_MaximoOnboarding='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_MaximoOnboardingDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_MaximoOnboarding" />
						</td>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="@ows_ADSDecomAuthorized='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_ADSDecommisionDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_ADSDecomAuthorized" />
						</td>
					</xsl:otherwise>
				</xsl:choose>				

				<xsl:choose>
					<xsl:when test="@ows_Commissioning='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_CommissioningDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_Commissioning" />
						</td>
					</xsl:otherwise>
				</xsl:choose>		
				
				<xsl:choose>
					<xsl:when test="@ows_VendorEquipmentRemoved='Not Done'">
						<td class="cuteDate">
							<xsl:value-of select="@ows_VendorEquipRemovedDate" />
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="cuteStatus">
							<xsl:value-of select="@ows_VendorEquipmentRemoved" />
						</td>
					</xsl:otherwise>
				</xsl:choose>					

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