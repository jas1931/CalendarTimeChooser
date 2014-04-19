#tag Window
Begin Window CalendarWindow
   BackColor       =   &c9D9D9D00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   True
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   True
   Height          =   227
   ImplicitInstance=   True
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   300
   MaximizeButton  =   False
   MaxWidth        =   394
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   227
   MinimizeButton  =   True
   MinWidth        =   394
   Placement       =   2
   Resizeable      =   False
   Title           =   "Choose Date and Time"
   Visible         =   True
   Width           =   394
   Begin Timer ClockSecondHandTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockedInPosition=   False
      Mode            =   2
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Separator Separator1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   255
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   232
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   97
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   -1
      Visible         =   True
      Width           =   4
   End
   Begin Calendar_Container Calendar_Container1
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   False
      HasBackColor    =   False
      Height          =   213
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   100
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   5
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   230
   End
   Begin Time_Container Time_Container1
      AcceptFocus     =   False
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      ClockSecondsCounter=   0
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   186
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   231
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   101
      TabPanelIndex   =   0
      TabStop         =   True
      Time_AMPM       =   "AM"
      Time_AMPM_Len   =   0
      Time_Hour       =   "12"
      Time_Hour_Len   =   0
      Time_Minute     =   "00"
      Time_Minute_Len =   0
      Top             =   5
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   156
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  if asc(key)=27 then
		    me.close
		    Return True
		  end
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  If BothPickers = True Then
		    mSetupForBothPickers
		  Elseif CalendarPicker_Only = True Then
		    mSetupForCalendarPickerOnly
		  Elseif TimePicker_Only = True Then
		    mSetupForTimePickerOnly
		  End if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub mSetupForBothPickers()
		  CalendarWindow.Width = 394
		  CalendarWindow.Height = 227
		  
		  CalendarWindow.Title = "Choose Date and Time"
		  CalendarWindow.Calendar_Container1.Enabled = True
		  CalendarWindow.Calendar_Container1.Visible = True
		  CalendarWindow.Time_Container1.Enabled = True
		  CalendarWindow.Time_Container1.Visible = True
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub mSetupForCalendarPickerOnly()
		  CalendarWindow.Width = 230
		  CalendarWindow.Height = 227
		  
		  CalendarWindow.Title = "Choose Date"
		  CalendarWindow.Calendar_Container1.Enabled = True
		  CalendarWindow.Calendar_Container1.Visible = True
		  CalendarWindow.Time_Container1.Enabled = False
		  CalendarWindow.Time_Container1.Visible = False
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub mSetupForTimePickerOnly()
		  CalendarWindow.Width = 156
		  CalendarWindow.Height = 195
		  
		  CalendarWindow.Title = "Choose Time"
		  CalendarWindow.Time_Container1.Enabled = True
		  CalendarWindow.Time_Container1.Visible = True
		  CalendarWindow.Time_Container1.Left = 0
		  CalendarWindow.Time_Container1.Top = 5
		  //
		  CalendarWindow.Calendar_Container1.Enabled = False
		  CalendarWindow.Calendar_Container1.Visible = False
		  
		  CalendarWindow.BackColor = RGB(228,228,228)
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		BothPickers As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		CalendarPicker_Only As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectClockFaceType As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TimePicker_Only As Boolean = False
	#tag EndProperty


#tag EndWindowCode

#tag Events ClockSecondHandTimer
	#tag Event
		Sub Action()
		  // This controls the Clock's Second Hand
		  
		  CalendarWindow.Time_Container1.ClockSecondsCounter = CalendarWindow.Time_Container1.ClockSecondsCounter + 1
		  if CalendarWindow.Time_Container1.ClockSecondsCounter = 0 Then
		    CalendarWindow.Time_Container1.Clock1.mMoveClockSecondHand("00")
		    CalendarWindow.Time_Container1.ClockSecondsCounter = -1
		  Elseif CalendarWindow.Time_Container1.ClockSecondsCounter = 60 Then
		    CalendarWindow.Time_Container1.Clock1.mMoveClockSecondHand("00")
		    CalendarWindow.Time_Container1.ClockSecondsCounter = 0
		  Else
		    CalendarWindow.Time_Container1.Clock1.mMoveClockSecondHand(Str(CalendarWindow.Time_Container1.ClockSecondsCounter))
		  End if
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Calendar_Container1
	#tag Event
		Sub SelectedDate(inSelectedDate as Date)
		  // Use this Event to push the user's "Selected Date" to anywhere in your code.
		  // IE.   FutureScheduleAssessment_Class.FutureScheduleAssessmentDate = inSelectedDate
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Time_Container1
	#tag Event
		Sub SelectedTime(inHours as String, inMinutes as String, inAMPM as String)
		  // I decided to send the selected Time in separate string parts to allow for maximum control on formating.
		  
		  // My example Format shows a format (without quotes):     "hh:MM AM/PM"
		  //Dim TmpDateFormatString as String = inHours+":"+inMinutes+" "+inAMPM
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="BothPickers"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CalendarPicker_Only"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"10 - Drawer Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="SelectClockFaceType"
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TimePicker_Only"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
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
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
