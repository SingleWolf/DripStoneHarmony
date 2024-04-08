import relationalStore from '@ohos.data.relationalStore'
import { IMemoTable } from './TableInterface'

export default class DbConstants {

  // Rdb 数据库配置
  static readonly STORE_CONFIG:relationalStore.StoreConfig = {
    name:'note_database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  static readonly MEMO_TABLE:IMemoTable = {
    tableName:'memoTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS memoTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, content TEXT)',
    columns:['id','updateTime','content']
  }

}