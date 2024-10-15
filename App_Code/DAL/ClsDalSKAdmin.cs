using System;
using System.Web;
using System.Data;
using MySql.Data.MySqlClient;
using System.Globalization;
namespace SocietyKatta.DAL
{
    /// <summary>
    /// Summary description for ClsDalSKAdmin
    /// </summary>
    public class ClsDALSKAdmin : IDisposable
    {
        /// <summary>
        /// Stores the connection string details.
        /// </summary>
        string ConnectionString = string.Empty;

        MySqlConnection sql;
        MySqlCommand sqlCommand;
        DataTable dt;
        private bool disposed;

        /// <summary>
        /// Constructor to intitialize connection string.
        /// </summary>
        public ClsDALSKAdmin()
        {
            ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringSKAdmin"].ToString();
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                // Dispose of resources held by this instance.
                if (sql != null)
                    sql.Dispose();
                if (sqlCommand != null)
                    sqlCommand.Dispose();
                if (dt != null)
                    dt.Dispose();

                disposed = true;

                // Suppress finalization of this disposed instance.
                if (disposing)
                {
                    GC.SuppressFinalize(this);
                }
            }
        }

        public void Dispose()
        {
            Dispose(true);
        }

        ~ClsDALSKAdmin()
        {
            Dispose(false);

        }
        #region Methods

        /* CONNECTION OPENING METHOD [START]*/
        private bool SqlConnOpen()
        {
            try
            {
                sql = new MySqlConnection(ConnectionString);
                if (sql.State == ConnectionState.Closed)
                {
                    sql.Open();
                    return true;
                }
            }
            catch (MySqlException ex)
            {
                string exp = ex.Message;
                return false;
            }
            return true;
        }
        /* CONNECTION OPENING METHOD [END]*/

        /* CONNECTION CLOSE METHOD [START]*/
        private void SqlConnClose()
        {
            if (sql.State == ConnectionState.Open)
            {
                sql.Close();
            }
        }
        /* CONNECTION CLOSE METHOD [END]*/

        /* This FUNCTION RETURN SQLDBType FOR SPECIFIED PARAMETER  [START]*/
        private MySqlDbType ReturnDataType(string Type)
        {
            switch (Type.ToUpper(CultureInfo.InstalledUICulture))
            {
                case "VARCHAR": return MySqlDbType.VarChar;
                case "DATE": return MySqlDbType.Date;
                case "DATETIME": return MySqlDbType.DateTime;
                case "TIME": return MySqlDbType.Time;
                case "YEAR": return MySqlDbType.Year;
                case "TINYINT": return MySqlDbType.Int16;
                case "SMALLINT": return MySqlDbType.Int24;
                case "MEDIUMINT": return MySqlDbType.Int32;
                case "INT": return MySqlDbType.Int32;
                case "BIGINT": return MySqlDbType.Int64;
                case "BIT": return MySqlDbType.Bit;
                case "DECIMAL": return MySqlDbType.Decimal;
                case "FLOAT": return MySqlDbType.Float;
                case "DOUBLE": return MySqlDbType.Double;
                case "REAL": return MySqlDbType.Double;
                case "BOOLEAN": return MySqlDbType.Byte;
                case "BINARY": return MySqlDbType.Binary;
                case "VARBINARY": return MySqlDbType.VarBinary;
                case "CHAR": return MySqlDbType.VarChar;
                case "TEXT": return MySqlDbType.Text;
                case "TINYTEXT": return MySqlDbType.TinyText;
                case "LONGTEXT": return MySqlDbType.LongText;
            }
            return MySqlDbType.Int32;
        }
        /* This FUNCTION RETURN SQLDBType FOR SPECIFIED PARAMETER  [END]*/

        /// <summary>
        /// Get scalar result from the stored procedure.
        /// </summary>
        /// <param name="procedureName">Stored Procedure name</param>
        /// <returns>Return single value</returns>
        public String ExecuteScalar(string procedureName)
        {
            string returnValue = string.Empty;
            try
            {
                // Checking Size of Array
                SqlConnOpen();

                dt = new DataTable();
                sqlCommand = new MySqlCommand(procedureName, sql);
                sqlCommand.CommandType = CommandType.StoredProcedure;

                returnValue = Convert.ToString(sqlCommand.ExecuteScalar());
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                SqlConnClose();
            }
            finally
            {
                SqlConnClose();
            }
            return returnValue;
        }

        /// <summary>
        /// Get scalar result from the stored procedure.
        /// </summary>
        /// <param name="procedureName">Stored Procedure name</param>
        /// <param name="parameterName">Parameter name</param>
        /// <param name="parameterValue">Parameter value</param>
        /// <returns>Return scalar value</returns>
        public String ExecuteScalar(string procedureName, string parameterName, string parameterValue)
        {
            string returnValue = string.Empty;
            try
            {
                // Checking Size of Array
                SqlConnOpen();

                dt = new DataTable();
                sqlCommand = new MySqlCommand(procedureName, sql);
                sqlCommand.CommandType = CommandType.StoredProcedure;

                sqlCommand.Parameters.Add(new MySqlParameter(parameterName, parameterValue));
                sqlCommand.Parameters[parameterName].Value = parameterValue;

                returnValue = Convert.ToString(sqlCommand.ExecuteScalar());
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                SqlConnClose();
            }
            finally
            {
                SqlConnClose();
            }
            return returnValue;
        }

        /// <summary>
        /// Get scalar result from the stored procedure.
        /// </summary>
        /// <param name="procedureName">Stored Procedure name</param>
        /// <param name="parameterNames">Parameter names</param>
        /// <param name="parameterValues">Parameter values</param>
        /// <returns>Return scalar value</returns>
        public String ExecuteScalar(string procedureName, string[] parameterNames, string[] parameterValues)
        {
            string returnValue = string.Empty;
            try
            {
                // Checking Size of Array
                SqlConnOpen();

                dt = new DataTable();
                sqlCommand = new MySqlCommand(procedureName, sql);
                sqlCommand.CommandType = CommandType.StoredProcedure;

                // Add Parameters to SQL Command
                for (int i = 0; i < parameterNames.Length; i++)
                {
                    sqlCommand.Parameters.Add(new MySqlParameter(parameterNames[i], parameterValues[i]));
                }

                returnValue = Convert.ToString(sqlCommand.ExecuteScalar());
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                SqlConnClose();
            }
            finally
            {
                SqlConnClose();
            }
            return returnValue;
        }

        /// Public Execute Transaction for executing transaction
        /// <summary>
        /// This function can be used for any stored procedure that will Insert or Update records in database
        /// </summary>
        /// <param name="procedureName">Stored Procedure name</param>
        /// <param name="parameterNames">Stored procedure paramenter name</param>
        /// <param name="parameterDataType">Stored procedure parameter data type</param>
        /// <param name="parameterDTSize">parameter datatype size</param>
        /// <param name="parameterValues">Values for the paremeter</param>
        /// <returns>bool whether the transaction was successful or not</returns>
        public bool ExecuteTransaction(string procedureName, string[] parameterNames, string[] parameterValues)
        {
            // Checking Size of Array
            if ((parameterNames.Length == parameterValues.Length))
            {
                try
                {
                    // Opens SQL Connection
                    if (SqlConnOpen())
                    {
                        sqlCommand = new MySqlCommand(procedureName, sql);
                        sqlCommand.CommandType = CommandType.StoredProcedure;

                        // Add Parameters to SQL Command
                        for (int i = 0; i < parameterNames.Length; i++)
                        {
                            sqlCommand.Parameters.Add(new MySqlParameter(parameterNames[i], parameterValues[i]));
                        }

                        int rowsAffected = sqlCommand.ExecuteNonQuery();
                        return (rowsAffected > 0);
                    }
                    else
                        return false;
                }
                catch (MySqlException ex)
                {
                    string exp = ex.Message;
                    SqlConnClose();
                    return false;
                }
                finally
                {
                    SqlConnClose();
                }
            }
            else
                return false;
        }

        /// Public Execute Transaction for executing transaction
        /// <summary>
        /// This function can be used for any stored procedure that will Insert or Update records in database and return values if required
        /// </summary>
        /// <param name="procedureName">Stored Procedure name</param>
        /// <param name="parameterNames">Stored procedure paramenter name</param>
        /// <param name="parameterDataType">Stored procedure parameter data type</param>
        /// <param name="parameterDTSize">parameter datatype size</param>
        /// <param name="parameterValues">Values for the paremeter</param>
        /// <returns>bool whether the transaction was successful or not</returns>
        public int ExecuteTransactionReturnValue(string procedureName, string[] parameterNames, string[] parameterValues)
        {
            // Checking Size of Array
            if ((parameterNames.Length == parameterValues.Length))
            {
                try
                {
                    // Opens SQL Connection
                    if (SqlConnOpen())
                    {
                        sqlCommand = new MySqlCommand(procedureName, sql);
                        sqlCommand.CommandType = CommandType.StoredProcedure;

                        // Add Parameters to SQL Command
                        for (int i = 0; i < parameterNames.Length; i++)
                        {
                            sqlCommand.Parameters.Add(new MySqlParameter(parameterNames[i], parameterValues[i]));
                        }
                        var returnValue = new MySqlParameter("rValue", SqlDbType.Int);
                        returnValue.Direction = ParameterDirection.ReturnValue;
                        sqlCommand.Parameters.Add(returnValue);
                        //sqlCommand.Parameters.Add(new MySqlParameter("rValue", 1));
                        //sqlCommand.Parameters["rValue"].Direction = ParameterDirection.ReturnValue;
                        int valueReturned = sqlCommand.ExecuteNonQuery();
                        return valueReturned;
                    }
                    else
                        return 0;
                }
                catch (MySqlException ex)
                {
                    string exp = ex.Message;
                    SqlConnClose();
                    return 0;
                }
                finally
                {
                    SqlConnClose();
                }
            }
            else
                return 0;
        }

        //Fetch return parameter/value by making a call to Stored Procedure which returns parameter
        /// <summary>
        /// This function Returns paramenter/value by making a call to Stored Procedure which returns parameter - On success else 'Error Occured' will be returned - On failure".
        /// Parameters : Procedure = Stored Procedure Name,
        /// FieldName[] = Name of the Parameters,
        /// FieldDataType[] = Datatype for the parameters,
        /// Values[] = Values for the parameters.
        /// ReturnFieldName = Field name which is used in Store Procedure as return paramenter
        /// ReturnFieldDataType = Data type of returned paramenter
        /// </summary>
        public string RetrieveParameter(string ProcedureName, string[] parameterNames, string[] parameterValues, string ReturnFieldName, string ReturnFieldDataType)
        {
            string pvalues = string.Empty;
            // Checking Size of Array
            if ((parameterNames.Length == parameterValues.Length))
            {
                try
                {
                    SqlConnOpen();

                    sqlCommand = new MySqlCommand(ProcedureName, sql);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    // Adding Parameters required for Stored Procedure
                    for (int i = 0; i < parameterNames.Length; i++)
                    {
                        sqlCommand.Parameters.Add(new MySqlParameter(parameterNames[i], parameterValues[i]));
                        pvalues += parameterValues[i] + " : ";
                    }

                    // Add parameter which will return value

                    string strReturnFieldName = ReturnFieldName.ToString();
                    MySqlParameter returnParam = new MySqlParameter();
                    returnParam = sqlCommand.Parameters.AddWithValue(strReturnFieldName, ReturnDataType(ReturnFieldDataType));
                    returnParam.Direction = ParameterDirection.ReturnValue;

                    //Execute Command
                    sqlCommand.ExecuteNonQuery();

                    // Assign value which is returned from Stored Procedure.
                    string tempReturnValue = sqlCommand.Parameters[strReturnFieldName].Value.ToString();
                    return tempReturnValue;
                }
                catch (Exception ex)
                {
                    string exp = ex.Message;
                    SqlConnClose();
                    return "Error Occured";
                }
                finally
                {
                    SqlConnClose();
                }
            }
            else
                return "Error Occured";
        }

        //Fetch return parameter/value by making a call to Stored Procedure which returns output parameter
        /// <summary>
        /// This function Returns paramenter/value by making a call to Stored Procedure which returns output parameter - On success else 'Error Occured' will be returned - On failure".
        /// Parameters : procedureName = Stored Procedure Name,
        /// parameterNames[] = Name of the Parameters,
        /// parameterValues[] = Values for the parameters.
        /// returnFieldName = Field name which is used in Store Procedure as return paramenter
        /// </summary>
        public int RetrieveOutputIntegerParameter(string procedureName, string[] parameterNames, string[] parameterValues, string returnFieldName)
        {
            // Checking Size of Array
            if (parameterNames.Length == parameterValues.Length)
            {
                try
                {
                    // Opens SQL Connection
                    SqlConnOpen();

                    sqlCommand = new MySqlCommand(procedureName, sql);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    // Add Parameters to SQL Command
                    for (int i = 0; i < parameterNames.Length; i++)
                    {
                        sqlCommand.Parameters.Add(new MySqlParameter(parameterNames[i], parameterValues[i]));
                    }

                    MySqlParameter sqlParameter = new MySqlParameter();
                    sqlParameter = sqlCommand.Parameters.AddWithValue(returnFieldName, SqlDbType.Int);
                    sqlParameter.Direction = ParameterDirection.ReturnValue;

                    sqlCommand.ExecuteNonQuery();
                    return Convert.ToInt32(sqlParameter.Value.ToString(), CultureInfo.InvariantCulture);
                }
                catch (MySqlException ex)
                {
                    string exp = ex.Message;
                    SqlConnClose();
                    return 0;
                }
                finally
                {
                    SqlConnClose();
                }
            }
            else
                return 0;
        }

        public DataTable GetData(string ProcedureName, string[] FieldName, string[] Values)
        {
            // Checking Size of Array
            if ((FieldName.Length == Values.Length))
            {
                try
                {
                    SqlConnOpen();

                    dt = new DataTable();
                    sqlCommand = new MySqlCommand(ProcedureName, sql);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    // Adding Parameters
                    for (int i = 0; i < FieldName.Length; i++)
                    {
                        sqlCommand.Parameters.Add(new MySqlParameter(FieldName[i], Values[i]));
                    }
                    MySqlDataAdapter sqlDA = new MySqlDataAdapter(sqlCommand);

                    sqlDA.Fill(dt);
                    SqlConnClose();
                }
                catch (Exception ex)
                {
                    string exp = ex.Message;
                    SqlConnClose();
                    return null;
                }
                finally
                {
                    SqlConnClose();
                }
                return dt;
            }
            else
                return null;
        }

        /// <summary>
        /// Get result from the table and will return datatable object.
        /// </summary>
        /// <param name="ProcedureName">Name of procedure present in database.</param>
        /// <param name="FieldName">Field name must be present in the procedure.</param>
        /// <param name="Values">Value to pass to the parameter present in the procedure.</param>
        /// <returns>Return datatable object.</returns>
        public DataTable GetData(string ProcedureName, string FieldName, string Values)
        {
            dt = new DataTable();
            try
            {
                if (SqlConnOpen())
                {
                    sqlCommand = new MySqlCommand(ProcedureName, sql);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    MySqlDataAdapter sqlDA = new MySqlDataAdapter(sqlCommand);

                    // Adding Parameters
                    sqlCommand.Parameters.Add(new MySqlParameter(FieldName, Values));

                    sqlDA.Fill(dt);
                    SqlConnClose();
                }
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                SqlConnClose();
                dt = null;
            }
            finally
            {
                SqlConnClose();
            }
            return dt;
        }

        /// <summary>
        /// Get result from the table and will return datatable object.
        /// </summary>
        /// <param name="ProcedureName">Name of procedure present in database.</param>
        /// <returns>Return datatable object.</returns>
        public DataTable GetData(string procedureName)
        {
            dt = new DataTable();
            try
            {
                if (SqlConnOpen())
                {
                    sqlCommand = new MySqlCommand(procedureName, sql);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    MySqlDataAdapter sqlDA = new MySqlDataAdapter(sqlCommand);

                    sqlDA.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                string exp = ex.Message;
                SqlConnClose();
                dt = null;
            }
            finally
            {
                SqlConnClose();
            }
            return dt;
        }

        /// <summary>
        /// retirives the data woithout stored procedure
        /// </summary>
        /// <param name="query">Sql Query</param>
        /// <returns>Datatble if error thrown than exception object</returns>
        public DataTable GetDataByQuery(string query)
        {
            dt = new DataTable();
            try
            {
                SqlConnOpen();
                MySqlDataAdapter sqlDA = new MySqlDataAdapter(query, ConnectionString);
                sqlDA.Fill(dt);
                return dt;
            }
            catch (MySqlException ex)
            {
                throw ex;
            }
            finally
            {
                SqlConnClose();
            }
        }

        #endregion
    }

}