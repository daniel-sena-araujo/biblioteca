object ConexaoBancoDados: TConexaoBancoDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 354
  Width = 447
  object ConexaoSQLServer: TFDConnection
    Params.Strings = (
      'Database=db_biblioteca'
      'User_Name=sa'
      'Password=1devsecnpi'
      'Server=DESKTOP-KQE2QPS'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 72
    Top = 48
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 216
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = ConexaoSQLServer
    Left = 136
    Top = 248
  end
end
