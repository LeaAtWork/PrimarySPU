' ''' <summary>
' '''   $Header: EDP/Formats/CalcEDD/CalcEDD.vb  16  2011-07-08 09:30:08-06:00  Bryce Mathews <bryce.mathews@earthsoft.com> $
' '''		$UTCDate: 2010-09-16 14:47:57Z $
' ''' Modified 2013-03-01 by Lea Beard <lea.beard@seattle.gov> to add colum 'sdg'.
' ''' </summary>
Option Strict Off

Imports EarthSoft.Common
Imports EarthSoft.Edp
Imports System
Imports System.Collections
Imports System.Runtime.InteropServices
Imports System.Reflection

'<Assembly: AssemblyCompany("EarthSoft, Inc.")> 
'<Assembly: AssemblyProduct("EQuIS")> 
'<Assembly: AssemblyCopyright("Copyright © 2002-2011, EarthSoft, Inc.")> 
'<Assembly: AssemblyTrademark("")> 
'<Assembly: AssemblyVersion("3.0.15")> 

Public Class CalcEDDHandler
    Inherits EarthSoft.Edp.EddCustomHandler

    Private _efd As EddFormatDefinition
    Private CalcEDD As System.Data.DataTable
    Private sampleTypeCode_for_ERR1 As New System.Collections.Specialized.StringCollection

    Public Sub New()
        'KP_Case11563_20060703
        sampleTypeCode_for_ERR1.Add("BD")
        sampleTypeCode_for_ERR1.Add("FD")
        sampleTypeCode_for_ERR1.Add("FR")
        sampleTypeCode_for_ERR1.Add("FS")
        sampleTypeCode_for_ERR1.Add("LR")
        sampleTypeCode_for_ERR1.Add("MS")
        sampleTypeCode_for_ERR1.Add("SD")
        sampleTypeCode_for_ERR1.Add("MSD")
    End Sub

    Public Overrides Sub AddDataHandlers(ByRef Efd As EarthSoft.EDP.EddFormatDefinition)
        _efd = Efd
        Me.CalcEDD = Efd.Tables(0)
        AddHandler CalcEDD.ColumnChanged, AddressOf Me.CalcEDD_ColumnChanged
    End Sub

    Public Overloads Overrides Function ErrorMessage(ByVal err As EddErrors) As String
        Select Case err
            Case EddErrors.CustomError1
                Return "Parent_Sample_Code is required where Sample_Type_Code= BD, FD, FR, FS, LR, MS, SD, or MSD."
            Case EddErrors.CustomError2
                Return "Analysis_Date cannot preceed Sample_Date."
        End Select

        Return String.Empty
    End Function

    'KP_Case11563_20060703
    Public Sub CalcEDD_ColumnChanged(ByVal sender As Object, ByVal e As System.Data.DataColumnChangeEventArgs)
        'this function is called whenever the user changes a value,
        'so you can check for custom errors, etc.
        Select Case e.Column.ColumnName.ToLower
            Case "analysis_date", "sample_date"
                ERR02(e)        'analysis_date cannot preceed sample_date.
            Case "sample_type_code"
                ERR01(e)        'Parent_sample_code is required where sample_type_code=BD, FD, FR, FS, LR, MS, SD, or MSD. 
            Case "parent_sample_code"
                ERR01(e)        'Parent_sample_code is required where sample_type_code=BD, FD, FR, FS, LR, MS, SD, or MSD. 
                ERR03(e)        'Parent_Sample_Code must have parent record.
        End Select
    End Sub

#Region "Check"
    ''' <summary>Parent_Sample_Code is required where Sample_Type_Code= BD, FD, FR, FS, LR, MS, SD, or MSD.
    ''' Applies to:
    ''' <list type="bullet">
    '''   <item>CalcEDD.Parent_Sample_Code</item>
    '''   <item>CalcEDD.Sample_Type_Code</item>
    ''' </list>
    ''' </summary>
    ''' <history>
    ''' <mod user="kp" case="11563" date="7/3/2006" remarks="created" />
    ''' </history>
    Friend Sub ERR01(ByVal e As System.Data.DataColumnChangeEventArgs)
        With e.Row
            If .Item("parent_sample_code") Is DBNull.Value And sampleTypeCode_for_ERR1.Contains(Utilities.String.ToUpper(.Item("sample_type_code"))) Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("parent_sample_code"), EddErrors.CustomError1)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("parent_sample_code"), EddErrors.CustomError1)
            End If
        End With
    End Sub

    ''' <summary>Analysis_Date cannot precede Sample_Date.
    ''' Applies to:
    ''' <list type="bullet">
    '''   <item>CalcEDD.Analysis_Date</item>
    '''   <item>CalcEDD.Sample_Date</item>
    ''' </list>
    ''' </summary>
    ''' <history>
    ''' <mod user="bhm" case="18093" date="9/11/2008" remarks="created" />
    ''' <mod user="bhm" case="18093" date="9/11/2008" remarks="modify to check if row is a comment row and if value can be converted to a date data type first." />
    ''' </history>
    Friend Sub ERR02(ByVal e As System.Data.DataColumnChangeEventArgs)
        If IsCommentRow(e.Row) Then Return
        Dim analysis_date, sample_date As Date
        With e.Row
            If Not .IsNull("Analysis_Date") AndAlso Not .IsNull("Sample_Date") AndAlso Date.TryParse(.Item("Analysis_Date").ToString, analysis_date) AndAlso Date.TryParse(.Item("Sample_Date").ToString, sample_date) Then

                If (System.DateTime.Compare(analysis_date, sample_date) < 0) Then
                    Me.AddError(e.Row, CType(.Table.Columns.Item("Analysis_Date"), System.Data.DataColumn), EddErrors.CustomError2)
                Else
                    Me.RemoveError(e.Row, CType(.Table.Columns.Item("Analysis_Date"), System.Data.DataColumn), EddErrors.CustomError2)
                End If
            Else
                Me.RemoveError(e.Row, CType(.Table.Columns.Item("Analysis_Date"), System.Data.DataColumn), EddErrors.CustomError2)
            End If
        End With
    End Sub

    ''' <summary>Parent_Sample_Code must have parent record.
    ''' Applies to:
    ''' <list type="bullet">
    '''   <item>CalcEDD.Parent_Sample_Code</item>
    '''   <item>CalcEDD.Sys_Sample_Code</item>
    ''' </list>
    ''' </summary>
    ''' <history>
    ''' <mod user="bhm" case="55039" date="7/8/2011" remarks="created" />
    ''' </history>
    Friend Sub ERR03(ByVal e As System.Data.DataColumnChangeEventArgs)
        If IsCommentRow(e.Row) Then Return
        With e.Row
            If Not .IsNull("Parent_Sample_Code") Then
                Dim rows() As System.Data.DataRow = e.Row.Table.Select(String.Format("sys_sample_code='{0}'", .Item("Parent_Sample_Code").ToString.Replace("'", "''")))
                If rows.Length > 0 Then
                    Me.RemoveError(e.Row, CType(.Table.Columns.Item("Parent_Sample_Code"), System.Data.DataColumn), EddErrors.OrphanRow)
                Else
                    Me.AddError(e.Row, CType(.Table.Columns.Item("Parent_Sample_Code"), System.Data.DataColumn), EddErrors.OrphanRow)
                End If
            Else
                Me.RemoveError(e.Row, CType(.Table.Columns.Item("Parent_Sample_Code"), System.Data.DataColumn), EddErrors.OrphanRow)
            End If
        End With
    End Sub

    Private Function IsCommentRow(ByVal row As System.Data.DataRow) As Boolean
        For Each symbol As String In _efd.CommentIndicator
            If row.Item(0).ToString.StartsWith(symbol) Then Return True
        Next

        Return False
    End Function
#End Region

#Region "Create"
    Public Shadows Function GetTestID(ByVal eddRow As System.Data.DataRow, ByVal targetRow As System.Data.DataRow) As Integer
        Dim dv As System.Data.DataView
        Static testId As Integer

        ' cache the last test that was accessed
        Static lastKey As TestAlternateKey
        Dim thisKey As TestAlternateKey

        ' get all of the values for this key
        With thisKey
            .sample_id = GetSampleId(eddRow, targetRow)
            .analytic_method = eddRow.Item("Lab_Anl_Method_Name").ToString
            .analysis_date = GetAnalysisDate(eddRow)
            .test_type = eddRow.Item("Test_Type").ToString
            .fraction = eddRow.Item("Fraction").ToString
        End With

        ' does the last key we found match this key?
        If Not lastKey.Equals(thisKey) Then

            ' cache this key
            lastKey = thisKey

            ' build the filter
            Dim filter As New System.Text.StringBuilder(255)
            filter.Append("sample_id = '" & thisKey.sample_id & "' AND analytic_method = '" & thisKey.analytic_method.Replace("'", "''") & "' ")
            If Not thisKey.analysis_date.Equals(CType(Nothing, Date)) Then filter.Append(" AND analysis_date = #" & thisKey.analysis_date.ToString("yyyy-MM-dd HH:mm:ss") & "# ")
            If thisKey.fraction.Length > 0 Then filter.Append(" AND fraction = '" & thisKey.fraction.Replace("'", "''") & "' ")
            If thisKey.test_type.Length > 0 Then filter.Append(" AND test_type = '" & thisKey.test_type.Replace("'", "''") & "' ")

            ' get the test_id from dt_test
            dv = targetRow.Table.DataSet.Tables("dt_test").DefaultView
            dv.RowFilter = filter.ToString
            If dv.Count > 0 Then
                'VJN_Case_6526_20050521 'changed DirectCast to CType since DirectCast was giving invalid cast exception
                testId = CType(dv.Item(0).Item("test_id"), Integer)
            Else
                testId = -1
            End If

        End If

        Return testId
    End Function

    Public Shadows Function GetSampleDate(ByVal eddRow As System.Data.DataRow) As Date
        ' combine sample date and sample time
        Return Date.Parse(String.Format("{0} {1}", CType(eddRow.Item("Sample_Date"), Date).ToString("yyyy-MM-dd"), eddRow.Item("Sample_Time")))
    End Function

    Public Shadows Function GetAnalysisDate(ByVal eddRow As System.Data.DataRow) As Date
        ' combine analysis date and sample time
        Return Date.Parse(String.Format("{0} {1}", CType(eddRow.Item("Analysis_Date"), Date).ToString("yyyy-MM-dd"), eddRow.Item("Analysis_Time")))
    End Function

    Public Shadows Function GetPrepDate(ByVal eddRow As System.Data.DataRow) As Date
        ' combine prep date and sample time
        Return Date.Parse(String.Format("{0} {1}", CType(eddRow.Item("Prep_Date"), Date).ToString("yyyy-MM-dd"), eddRow.Item("Prep_Time")))
    End Function

     Public Function AssignTestBatch(ByVal eddRow As System.Data.DataRow) As Boolean
        If eddRow.Item("test_batch_id") Is DBNull.Value Then
            Return False
        ElseIf eddRow.Item("test_batch_id").ToString.Length = 0 Then
            Return False
        Else
            Return True
        End If
    End Function

    Public Function Populate_dt_location(ByVal eddRow As System.Data.DataRow) As Boolean
        Return Not eddRow.IsNull("Sys_Loc_Code")
    End Function

    Public Function HasLabDelGroup(ByVal eddRow As System.Data.DataRow) As Boolean
        Return Not eddRow.IsNull("SDG")
    End Function

#End Region

#Region "Grid Events"
    Public Overrides Sub Grid_AfterCellUpdate(ByVal sender As Object, ByVal e As Object, ByVal edp As Object)
        If sender.Name.Equals("CalcEDD") Then
            LookupChemicalName(sender, e)
        End If

        Select Case e.Cell.Column.Key.ToLower
            Case "sample_date"
                edp.AfterCellUpdate(sender, e.Cell.Row.Cells.Item("Analysis_Date"))
            Case "sample_type_code"
                edp.AfterCellUpdate(sender, e.Cell.Row.Cells.Item("parent_sample_code"))
        End Select

    End Sub

    ''' This routine may be overriden to provide custom handling when a cell drop-down list closes up.
    Public Sub LookupChemicalName(ByVal sender As Object, ByVal e As Object)

        ' to get access to the selected row (of the drop-down), use:
        ' CType(e.Cell.Column.ValueList, Infragistics.Win.UltraWinGrid.UltraDropDown).SelectedRow

        'when they select a cas_number, populate the param_name      
        If e.Cell.Column.Key = "Cas_Rn" AndAlso Not e.Cell.Column.ValueList.SelectedRow Is Nothing Then
            Dim row As Object = e.Cell.Column.ValueList.SelectedRow
            e.Cell.Row.Cells.Item("Chemical_Name").Value = row.Cells.Item("chemical_name").Value
        End If

    End Sub
#End Region

End Class

