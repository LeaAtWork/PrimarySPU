﻿
Namespace LightSwitchApplication

    Public Class CreateNewOutfall

        Private Sub CreateNewOutfall_InitializeDataWorkspace(ByVal saveChangesTo As Global.System.Collections.Generic.List(Of Global.Microsoft.LightSwitch.IDataService))
            ' Write your code here.
            Me.OutfallProperty = New Outfall()
        End Sub

        Private Sub CreateNewOutfall_Saved()
            ' Write your code here.
            Me.Close(False)
            Application.Current.ShowDefaultScreen(Me.OutfallProperty)
        End Sub

    End Class

End Namespace