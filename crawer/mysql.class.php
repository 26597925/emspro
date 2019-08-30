<?php

class mysql {
	var $link;	
	var $dbhost;
	var $dbuser;
	var $dbpw;
	var $dbcharset;
	var $tablepre;
	private static $instance = false;//设置单件

	var $goneaway = 5;
    private function __construct()
    {
	}
    public static function getInstance()
	 {
         if (!mysql::$instance)
		  {
         mysql::$instance = new mysql();
         }
        return mysql::$instance;
     }
	function connect($dbhost, $dbuser, $dbpw, $dbname = '', $dbcharset = '', $tablepre='') 
	{
		$this->dbhost = $dbhost;
		$this->dbuser = $dbuser;
		$this->dbpw = $dbpw;
		$this->dbname = $dbname;
		$this->dbcharset = $dbcharset;
		$this->tablepre = $tablepre;
		if(!$this->link = @mysql_connect($dbhost, $dbuser, $dbpw)) 
		{
				$this->halt('无法连接到数据库服务器');
		}

		if($this->version() > '4.1') 
		{
			if($dbcharset) 
			{
				mysql_query("SET character_set_connection=".$dbcharset.", character_set_results=".$dbcharset.", character_set_client=binary", $this->link);
			}
			
			if($this->version() > '5.0.1')
			 {
				mysql_query("SET sql_mode=''", $this->link);
			 }

		}

		if($dbname) 
		{
			$this->select_db($dbname);
		}

	}
	function select_db($dbname) 
	{
		return mysql_select_db($dbname, $this->link);
	}
	
	function query($sql) 
	{
		if(!($query = mysql_query($sql, $this->link))) 
		{
			$this->halt('MySQL Query Error', $sql);
		}
		return $query;
	}

	function fetch_array($query, $result_type = MYSQL_BOTH) 
	{
		return mysql_fetch_array($query, $result_type);
	}
	
	function insert_id() {
		return ($id = mysql_insert_id($this->link)) >= 0 ? $id : $this->result($this->query("SELECT last_insert_id()"), 0);
	}
	
	function affected_rows() {
		return mysql_affected_rows($this->link);
	}
	
	function num_rows($query) {
		$query = mysql_num_rows($query);
		return $query;
	}

	function num_fields($query) {
		return mysql_num_fields($query);
	}
	



	function error() 
	{
		return (($this->link) ? mysql_error($this->link) : mysql_error());
	}

	function errno() 
	{
		return intval(($this->link) ? mysql_errno($this->link) : mysql_errno());
	}

	function version() 
	{
		return mysql_get_server_info($this->link);
	}

	function close() 
	{
		return mysql_close($this->link);
	}

	function halt($message = '', $sql = '') 
	{
		$error = $this->error();
		$errorno = $this->errno();
		if($errorno == 2006 && $this->goneaway-- > 0)
		{
			$this->connect($this->dbhost, $this->dbuser, $this->dbpw, $this->dbname, $this->dbcharset, $this->tablepre);
			$this->query($sql);
		} 
		else 
		{
			$str= "	<b>出错</b>: $message<br>
				    <b>SQL</b>: $sql<br>
				    <b>错误详情</b>: $error<br>
				    <b>错误代码</b>:$errorno<br>";
            echo $str;
			exit;
		}
	}
}

?>