' <summary>
'   $Header: EDP/Formats/SPU/SPUEDD.vb  Based from WSDOT_lab. Lea Beard <lea.beard@seattle.gov> $
'		$Revision: 0 $
'		$UTCDate
' </summary>
Option Explicit On
Option Strict Off

Imports EarthSoft.Common
Imports EarthSoft.EDP
Imports System
Imports System.Collections
Imports System.Runtime.InteropServices
Imports System.Reflection


Public Class SPUEDDHandler
    Inherits EarthSoft.EDP.EddCustomHandler

    Private _efd As EddFormatDefinition
    Private SPUEDD As System.Data.DataTable
    Private sampleTypeCode_for_ERR1 As New System.Collections.Specialized.StringCollection

#Region "Madness Begins"

    Public Sub New()
        'KP_Case11563_20060703
        sampleTypeCode_for_ERR1.Add("DUP")    'lab duplicate
        sampleTypeCode_for_ERR1.Add("FDS")   'field duplicate
        sampleTypeCode_for_ERR1.Add("LCSD")  'lab control spike duplicate
        sampleTypeCode_for_ERR1.Add("MS")   'matrix spike
        sampleTypeCode_for_ERR1.Add("MSD")  'matrix spike dup
        sampleTypeCode_for_ERR1.Add("FSS")  'field split
    End Sub

    Public Overrides Property Err() As EddError
        Get
            Return MyBase.Err
        End Get
        Set(ByVal Value As EddError)
            Me._Err = Value
            'TODO: set the Warning status where applicable
            Me._Err.SetStatus(EddErrors.OutOfRange, EddError.ErrorStatus.Warning)
        End Set
    End Property

    Public Overrides Sub AddDataHandlers(ByRef Efd As EarthSoft.EDP.EddFormatDefinition)
        Me._efd = Efd
        Me.SPUEDD = Efd.Tables(0)

        AddHandler SPUEDD.ColumnChanged, AddressOf Me.SPUEDD_ColumnChanged

    End Sub

    Public Overrides Sub Grid_AfterCellUpdate(ByVal sender As Object, ByVal e As Object, ByVal edp As Object)
        If sender.Name.Equals("SPUEDD") Then
            LookupChemicalName(sender, e)
        End If
    End Sub
    ''' This routine may be overriden to provide custom handling when a cell drop-down list closes up.
    Public Sub LookupChemicalName(ByVal sender As Object, ByVal e As Object)

        ' to get access to the selected row (of the drop-down), use:
        ' CType(e.Cell.Column.ValueList, Infragistics.Win.UltraWinGrid.UltraDropDown).SelectedRow

        'when they select a cas_number, populate the param_name      
        If e.Cell.Column.Key = "cas_rn" Then
            Dim row As Object = e.Cell.Column.ValueList.SelectedRow
            e.Cell.Row.Cells.Item("chemical_name").Value = row.Cells.Item("chemical_name").Value
        End If

    End Sub

    Public Sub SPUEDD_ColumnChanged(ByVal sender As Object, ByVal e As System.Data.DataColumnChangeEventArgs)
        'this function is called whenever the user changes a value,
        'so you can check for custom errors, etc.
        Select Case e.Column.ColumnName.ToLower
            Case "parent_sample_code"
                ERR1(e)
                'Case "reporting_detection_limit_type"
                '    ERR2(e)
            Case "interpreted_qualifiers"
                ERR6(e)
            Case "validator_qualifiers"
                ERR6(e)
            Case "result_value"
                ERR3(e)
            Case "reporting_detection_limit"
                ERR4(e)
            Case "interpreted_qualifiers_reason_code"
                ERR5(e)
                'Case "lab_receipt_temp_units"
                '    ERR7(e)
            Case "sample_date"
                ERR8(e)
            Case "lab_receipt_date"
                ERR9(e)
            Case "basis"
                Err10(e)
            Case "sample_matrix_code"
                Err10(e)
        End Select

    End Sub

    Public Overloads Overrides Function ErrorMessage(ByVal err As EddErrors) As String
        Select Case err
            Case EddErrors.CustomError1
                Return "Parent_sample_code is required where sample_type_code= D, DF, LSD, MS, MSD, and RF. (1)"
            Case EddErrors.CustomError2
                Return "Reporting_detection_limit_type is required when Reporting_detection_limit is not NULL. (2)"
            Case EddErrors.CustomError3
                Return "Result_value is required where detect_flag=Y and result_type_code=TRG, TIC. (3)"
            Case EddErrors.CustomError4
                Return "Reporting_detection_limit cannot be null when detect_flag=N. (4)"
            Case EddErrors.CustomError5
                Return "Interpreted_qualifiers_reason_code cannot be null when interpreted_qualifiers is not null. (5)"
            Case EddErrors.CustomError6
                Return "If validator_qualifiers is not null, the interpreted_qualifier must match the validator qualifier. (6)"
            Case EddErrors.CustomError7
                Return "Lab_Receipt_Temp_Units must be populated when Lab_Receipt_Temp is not null. (7)"
            Case EddErrors.CustomError8
                Return "Sample_date cannot be null when Sample_Source = 'field'. (8)"
            Case EddErrors.CustomError9
                Return "Lab_receipt_date cannot be null when Sample_Source = 'field'. (9)"
            Case EddErrors.CustomError10
                Return "Basis cannot be null when sample matrix is a Soil/Sediment. (10)"
            Case Else
                Return ""
        End Select
    End Function
#End Region


#Region "Error Codes"

    'ERR1: Parent_sample_code is required where sample_type_code=BD, FD, FR, FS, LR, MS, SD, or MSD. (1)
    Friend Sub ERR1(ByVal e As System.Data.DataColumnChangeEventArgs)
        With e.Row

            If .Item("parent_sample_code") Is DBNull.Value And sampleTypeCode_for_ERR1.Contains(Utilities.String.ToUpper(.Item("sample_type_code"))) Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("parent_sample_code"), EddErrors.CustomError1)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("parent_sample_code"), EddErrors.CustomError1)
            End If
        End With
    End Sub

    ''ERR2: Reporting_detection_limit_type is required when Reporting_detection_limit is not NULL.  (2)
    'Friend Sub ERR2(ByVal e As System.Data.DataColumnChangeEventArgs)

    '    With e.Row

    '        If Not .Item("reporting_detection_limit") Is DBNull.Value AndAlso .Item("reporting_detection_limit_type") Is DBNull.Value Then
    '            Me.AddError(e.Row, .Table.Columns.Item("reporting_detection_limit_type"), EddErrors.CustomError2)
    '        Else
    '            Me.RemoveError(e.Row, .Table.Columns.Item("reporting_detection_limit_type"), EddErrors.CustomError2)
    '        End If
    '    End With
    'End Sub

    'ERR3: Result_value is required where detect_flag=Y and result_type_code=TRG, TIC. (3)
    Friend Sub ERR3(ByVal e As System.Data.DataColumnChangeEventArgs)

        With e.Row
            If Not .Item("detect_flag") Is DBNull.Value AndAlso Utilities.String.ToUpper(.Item("detect_flag")) = "Y" AndAlso _
            (Utilities.String.ToUpper(.Item("result_type_code")) = "TRG" OrElse Utilities.String.ToUpper(.Item("result_type_code")) = "TIC") AndAlso _
            .Item("Result_Value") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("result_value"), EddErrors.CustomError3)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("result_value"), EddErrors.CustomError3)
            End If
        End With

    End Sub

    'ERR4: Reporting_detection_limit cannot be null when detect_flag=N. (4)
    Friend Sub ERR4(ByVal e As System.Data.DataColumnChangeEventArgs)
        Dim rtc As String

        With e.Row
            rtc = Utilities.String.ToUpper(.Item("result_type_code"))
            If Utilities.String.ToUpper(.Item("detect_flag")) = "N" AndAlso (rtc = "TRG" OrElse rtc = "TIC" OrElse rtc = "SC") AndAlso .Item("reporting_detection_limit") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("reporting_detection_limit"), EddErrors.CustomError4)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("reporting_detection_limit"), EddErrors.CustomError4)
            End If
        End With

    End Sub

    'ERR5: Reason code must contain value if interpreted qualifiers is not null (5)
    Friend Sub ERR5(ByVal e As System.Data.DataColumnChangeEventArgs)

        With e.Row
            If Not .Item("interpreted_qualifiers") Is DBNull.Value AndAlso .Item("interpreted_qualifiers_reason_code") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("interpreted_qualifiers_reason_code"), EddErrors.CustomError5)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("interpreted_qualifiers_reason_code"), EddErrors.CustomError5)
            End If
        End With
    End Sub

    'ERR6: If validator_qualifiers is not null, the interpreted_qualifier must match the validator qualifier. (6)
    Friend Sub ERR6(ByVal e As System.Data.DataColumnChangeEventArgs)
        Dim vq As String
        Dim iq As String

        With e.Row
            If (Not .Item("validator_qualifiers") Is DBNull.Value) Then
                vq = Utilities.String.ToUpper(.Item("validator_qualifiers"))
            Else : vq = ""
            End If
            If (Not .Item("interpreted_qualifiers") Is DBNull.Value) Then
                iq = Utilities.String.ToUpper(.Item("interpreted_qualifiers"))
            Else : iq = ""
            End If
            'String.Equals(vq, iq) = False AndAlso
            If (Not .Item("validator_qualifiers") Is DBNull.Value) And String.Equals(vq, iq) = False Then
                Me.addError(e.Row, .Table.Columns.Item("interpreted_Qualifiers"), EddErrors.CustomError6)
            Else
                Me.removeError(e.Row, .Table.Columns.Item("interpreted_qualifiers"), EddErrors.CustomError6)
            End If
        End With
    End Sub

    ''ERR7: If lab_receipt_temp is not null then lab_receipt_units cannot be null (7)
    'Friend Sub ERR7(ByVal e As System.Data.DataColumnChangeEventArgs)

    '    With e.Row
    '        If (Not .Item("lab_receipt_temp") Is DBNull.Value) AndAlso (.Item("lab_receipt_temp_units") Is DBNull.Value) Then
    '            Me.AddError(e.Row, .Table.Columns.Item("lab_receipt_temp_units"), EddErrors.CustomError7)
    '        Else
    '            Me.RemoveError(e.Row, .Table.Columns.Item("lab_receipt_temp_units"), EddErrors.CustomError7)
    '        End If
    '    End With
    'End Sub

    'ERR8: Sample_date cannot be null when sample_source = 'field' (8)
    Friend Sub ERR8(ByVal e As System.Data.DataColumnChangeEventArgs)
        Dim ss As String
        With e.Row
            ss = Utilities.String.ToUpper(.Item("sample_source"))

            If (ss = "field" OrElse ss = "Field" OrElse ss = "FIELD") AndAlso .Item("sample_date") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("sample_date"), EddErrors.CustomError8)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("sample_date"), EddErrors.CustomError8)
            End If
        End With
    End Sub
    'ERR9: Lab_receipt_date cannot be null when sample_source = 'field' (9)
    Friend Sub ERR9(ByVal e As System.Data.DataColumnChangeEventArgs)
        Dim ss As String
        With e.Row
            ss = Utilities.String.ToUpper(.Item("sample_source"))

            If (ss = "field" OrElse ss = "Field" OrElse ss = "FIELD") AndAlso .Item("lab_receipt_date") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("lab_receipt_date"), EddErrors.CustomError9)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("lab_receipt_date"), EddErrors.CustomError9)
            End If
        End With
    End Sub

    Friend Sub Err10(ByVal e As System.Data.DataColumnChangeEventArgs)
        Dim ss As String
        With e.Row
            ss = Utilities.String.ToUpper(.Item("matrix_code"))

            If (ss = "SED" OrElse ss = "SOIL" OrElse ss = "StDirt") AndAlso .Item("basis") Is DBNull.Value Then
                Me.AddError(e.Row, e.Row.Table.Columns.Item("basis"), EddErrors.CustomError10)
            Else
                Me.RemoveError(e.Row, e.Row.Table.Columns.Item("basis"), EddErrors.CustomError10)
            End If

        End With
    End Sub

#End Region

#Region "Create"

    Public Function IsFieldSample(ByVal eddRow As System.Data.DataRow) As Boolean
        If eddRow.Item("sample_source").ToString = "Field" Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function HasLabDelGroup(ByVal eddRow As System.Data.DataRow) As Boolean
        Return Not eddRow.IsNull("lab_del_group")
    End Function

    Public Function AssignTestBatch(ByVal eddRow As System.Data.DataRow) As Boolean
        If eddRow.Item("analysis_batch_id") Is DBNull.Value Then
            Return False
        ElseIf eddRow.Item("analysis_batch_id").ToString.Length = 0 Then
            Return False
        Else
            Return True
        End If
    End Function

    Public Function AssignPrepBatch(ByVal eddRow As System.Data.DataRow) As Boolean
        If eddRow.Item("prep_batch_id") Is DBNull.Value Then
            Return False
        ElseIf eddRow.Item("prep_batch_id").ToString.Length = 0 Then
            Return False
        Else
            Return True
        End If
    End Function

    Public Function CreateTestSurrogateKey(ByVal eddRow As System.Data.DataRow, ByVal targetRow As System.Data.DataRow) As Integer

        ' the JETConnection will get the next available test_surrogate_key and save it in an extended property
        ' of the column, so this function needs to get that value and increment it by one
        Dim test_surrogate_key As Integer

        Try
            With targetRow.Table.DataSet.Tables("dt_test").Columns("test_surrogate_key").ExtendedProperties
                ' get the current value
                test_surrogate_key = CType(.Item("next"), Integer)

                Select Case targetRow.Table.TableName.ToLower
                    Case "dt_test"
                        ' increment the saved value
                        .Item("next") = test_surrogate_key + 1

                    Case "dt_test_batch_assign", "dt_result"
                        ' for test batch, the test_surrogate_key was incremented when this function was called with dt_test.
                        ' we need the same test_surrogate_key, so we need to decrement it and return that value.
                        test_surrogate_key = test_surrogate_key - 1
                End Select
            End With

        Catch ex As System.Exception
            Return -1
        End Try

        ' return the current key
        Return test_surrogate_key
    End Function

#End Region
#Region "ShadowLand"

    Public Shadows Function GetTestID(ByVal eddRow As System.Data.DataRow, ByVal targetRow As System.Data.DataRow) As Integer

        Dim dv As System.Data.DataView
        Static testId As Integer

        ' cache the last test that was accessed
        Static lastKey As TestAlternateKey
        Dim thisKey As TestAlternateKey

        ' get all of the values for this key
        With thisKey
            .sample_id = GetSampleId(eddRow, targetRow)
            .analytic_method = eddRow.Item("lab_anl_method_name").ToString
            .analysis_date = GetAnalysisDate(eddRow)
            .fraction = eddRow.Item("total_or_dissolved").ToString
            .column_number = "NA"
            .test_type = eddRow.Item("test_type").ToString
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
            If thisKey.column_number.Length > 0 Then filter.Append(" AND column_number = '" & thisKey.column_number.Replace("'", "''") & "' ")
            If thisKey.test_type.Length > 0 Then filter.Append(" AND test_type = '" & thisKey.test_type.Replace("'", "''") & "' ")

            ' get the test_id from dt_test
            dv = targetRow.Table.DataSet.Tables("dt_test").DefaultView
            dv.RowFilter = filter.ToString
            If dv.Count > 0 Then
                testId = CType(dv.Item(0).Item("test_id"), Integer)
            Else
                testId = -1
            End If

        End If

        Return testId
    End Function


#End Region

End Class
