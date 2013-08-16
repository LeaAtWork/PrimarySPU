Imports System.Windows.Forms
Imports EarthSoft.Common.Data.Connection
Imports EarthSoft.Forms

Public Class BatchViewForm
    Inherits System.Windows.Forms.Form
    Implements EarthSoft.Common.Forms.IDataEntryForm

#Region "IDataEntryForm"
    Private _Connection As EarthSoft.Common.Data.Connection

    Public Property Connection As EarthSoft.Common.Data.Connection Implements EarthSoft.Common.Forms.IDataEntryForm.Connection
        Get
            Return Me._Connection
        End Get
        Set(value As EarthSoft.Common.Data.Connection)
            Me._Connection = value
        End Set
    End Property

    Public Property Name_() As String Implements EarthSoft.Common.Forms.IDataEntryForm.Name
        Get
            Return Me.Text
        End Get
        Set(ByVal value As String)
            Me.Text = value
        End Set
    End Property

    Public Property Visible_() As Boolean Implements EarthSoft.Common.Forms.IDataEntryForm.Visible
        Get
            Return Me.Visible
        End Get
        Set(ByVal value As Boolean)
            Me.Visible = value
        End Set
    End Property
#End Region

    Private _dataSet As SDGDataSet
    Friend Overridable Property dataSet As SDGDataSet
        Get
            Return Me._dataSet
        End Get
        Set(value As SDGDataSet)
            Me._dataSet = value
        End Set
    End Property



    Private Sub populateCurrentFacility()
        Me.FacilityCode.Text = Me._Connection.FacilityId
    End Sub

    Private Sub BatchViewForm_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Try

            Me.BackColor = Me.MdiParent.BackColor
        Catch ex As Exception

        End Try
        Try
            Cursor.Current = Cursors.WaitCursor
            Dim allRecords As FillModes = FillModes.AllRecords
            If (Me._Connection.SecurityMode = SecurityModes.Application) Then
                allRecords = FillModes.CurrentFacility
            End If

        Catch ex As Exception

        End Try
        populateCurrentFacility()
    End Sub

End Class