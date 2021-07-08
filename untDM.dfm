object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 260
  Width = 357
  object conPrincipal: TFDConnection
    Params.Strings = (
      'Database=testedelphi'
      'User_Name=root'
      'Password=1234'
      'DriverID=MySQL')
    Left = 88
    Top = 112
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 48
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 216
    Top = 64
  end
end
