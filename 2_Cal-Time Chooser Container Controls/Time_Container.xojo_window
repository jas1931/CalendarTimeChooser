#tag Window
Begin ContainerControl Time_Container
   AcceptFocus     =   False
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   286
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   156
   Begin TimePicker TimePicker1
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Draw_AMPM_Selected=   False
      Draw_Hour_Selected=   False
      Draw_Minute_Selected=   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   22
      HelpTag         =   ""
      Indent          =   9
      Index           =   -2147483648
      InitialParent   =   ""
      KeyBuffer       =   ""
      Left            =   38
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Top             =   14
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   81
   End
   Begin UpDownArrows Time_Nav
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   120
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   False
      Top             =   10
      Visible         =   True
      Width           =   16
   End
   Begin Clock Clock1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      BorderColor     =   &c44444400
      ClockFaceColor  =   &cDDDDDD00
      ClockHandColor  =   &c00000000
      ClockHourValue  =   0.0
      ClockMinuteValue=   0.0
      ClockSecondValue=   0.0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Font            =   "Helvetica"
      Height          =   130
      HelpTag         =   ""
      HourCount       =   12
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   16
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c08020200
      Top             =   59
      Transparent     =   True
      UseFocusRing    =   True
      UseGradientFill =   False
      UseGraphicalClockHands=   True
      Visible         =   True
      Width           =   130
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub mRaiseEvent_SelectedTime()
		  RaiseEvent SelectedTime(Time_Hour, Time_Minute, Time_AMPM)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SelectedTime(inHours as String, inMinutes as String, optional inAMPM as String)
	#tag EndHook


	#tag Property, Flags = &h0
		ClockSecondsCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		HideAMPM As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimeMode As Integer = 12
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mTimeMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mTimeMode = value
			  
			  Select Case mTimeMode
			  Case 12
			    if TimeModeFirstRunBool = False Then
			      Me.TimePicker1.mOneTimeConversion24to12
			    End if
			  Case 24
			    Me.TimePicker1.mOneTimeConversion12to24
			    TimeModeFirstRunBool = False
			    
			  End Select
			End Set
		#tag EndSetter
		TimeMode As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TimeModeFirstRunBool As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_AMPM As String = "AM"
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_AMPM_Len As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_Hour As String = "12"
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_Hour_Len As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_Minute As String = "00"
	#tag EndProperty

	#tag Property, Flags = &h0
		Time_Minute_Len As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events Time_Nav
	#tag Event
		Sub Down()
		  // Default Behavior
		  if TimePicker1.Draw_Hour_Selected = False AND TimePicker1.Draw_Minute_Selected = False AND TimePicker1.Draw_AMPM_Selected = False Then
		    TimePicker1.Draw_Hour_Selected = True
		  end if
		  
		  // Change Hours Down
		  Select Case TimePicker1.Draw_Hour_Selected
		  Case True
		    if TimeMode = 12 Then
		      TimePicker1.mMove12HourDown
		    Elseif TimeMode = 24 Then
		      TimePicker1.mMove24HourDown
		    end if
		  End Select
		  
		  // Change Minutes Down
		  Select Case TimePicker1.Draw_Minute_Selected
		  Case True
		    if TimeMode = 12 Then
		      TimePicker1.mMove12MinDown
		    Elseif TimeMode = 24 Then
		      TimePicker1.mMove24MinDown
		    End If
		  End Select
		  
		  // Change AM / PM
		  Select Case TimePicker1.Draw_AMPM_Selected
		  Case True
		    TimePicker1.mMoveAMPM
		  End Select
		  
		  mRaiseEvent_SelectedTime
		End Sub
	#tag EndEvent
	#tag Event
		Sub Up()
		  // Default Behavior
		  if TimePicker1.Draw_Hour_Selected = False AND TimePicker1.Draw_Minute_Selected = False AND TimePicker1.Draw_AMPM_Selected = False Then
		    TimePicker1.Draw_Hour_Selected = True
		  end if
		  
		  // Change Hours Up
		  Select Case TimePicker1.Draw_Hour_Selected
		  Case True
		    if TimeMode = 12 Then
		      TimePicker1.mMove12HourUp
		    Elseif TimeMode = 24 Then
		      TimePicker1.mMove24HourUp
		    end if
		  End Select
		  
		  // Change Minutes Up
		  Select Case TimePicker1.Draw_Minute_Selected
		  Case True
		    if TimeMode = 12 Then
		      TimePicker1.mMove12MinUp
		    Elseif TimeMode = 24 Then
		      TimePicker1.mMove24MinUp
		    end if
		  End Select
		  
		  // Change AM / PM
		  Select Case TimePicker1.Draw_AMPM_Selected
		  Case True
		    TimePicker1.mMoveAMPM
		  End Select
		  
		  mRaiseEvent_SelectedTime
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  // For some reason this control doesn't look right as set in the IDE for Left/Top
		  #IF TargetWin32 Then
		    Me.Left = 125
		    Me.Top =  13
		  #ENDIF
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="AcceptFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AcceptTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ClockSecondsCounter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Appearance"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HideAMPM"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Group="Position"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TimeMode"
		Group="Behavior"
		InitialValue="12"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TimeModeFirstRunBool"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_AMPM"
		Group="Behavior"
		InitialValue="AM"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_AMPM_Len"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_Hour"
		Group="Appearance"
		InitialValue="12"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_Hour_Len"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_Minute"
		Group="Behavior"
		InitialValue="00"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Time_Minute_Len"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UseFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
