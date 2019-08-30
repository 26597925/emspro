<?php
//模型类，加载了外部的数据库类和缓存类
class model
{
    // 当前数据库操作对象
    public $db = null;
	public $config =array();
	public $sql = '';//sql语句，主要用于输出构造成的sql语句
	public  $pre = '';//表前缀，主要用于在其他地方获取表前缀
    private $data =array();// 数据信息  
    private $options=array(); // 查询表达式参数	
    public function __construct($config=array())
    {
		  $this->config['DB_HOST']=	isset($config['DB_HOST'])?$config['DB_HOST']:'localhost';
		  $this->config['DB_USER']=	isset($config['DB_USER'])?$config['DB_USER']:'root';
		  $this->config['DB_PWD']=	isset($config['DB_PWD'])?$config['DB_PWD']:'123456';
		  $this->config['DB_PORT']=	isset($config['DB_PORT'])?$config['DB_PORT']:'3306';
		  $this->config['DB_NAME']=	isset($config['DB_NAME'])?$config['DB_NAME']:'';
		  $this->config['DB_CHARSET']=isset($config['DB_CHARSET'])?$config['DB_CHARSET']:'utf8';
		  $this->config['DB_PREFIX']=isset($config['DB_PREFIX'])?$config['DB_PREFIX']:'';
		  $this->options['_field']='*';
		  $this->pre= $this->config['DB_PREFIX'];//数据表前缀
    }
	public function connect()
	{
			  require_once('mysql.class.php');//加载数据库类
			  $this->db =mysql::getInstance();//连接数据库
			  $this->db->connect($this->config['DB_HOST'].":".$this->config['DB_PORT'], $this->config['DB_USER'], $this->config['DB_PWD'], $this->config['DB_NAME'] , $this->config['DB_CHARSET'] , $this->config['DB_PREFIX']) ;
	}
	//设置表，$not_prefix为true的时候，不加上默认的表前缀
	public function table($table,$not_prefix=false)
	{
		if($not_prefix)
		{
			 $this->options['_table']=$table;
		}
		else
		{
			$this->options['_table']=$this->config['DB_PREFIX'].$table;
		}
		return $this;
	}
	
	 //回调方法，连贯操作的实现
    public function __call($method,$args) 
	{
		$method=strtolower($method);
        if(in_array($method,array('field','data','where','group','having','order','limit','cache')))
		{
            $this->options['_'.$method] =$args[0];
			return $this;
        }
		else
		{
			$this->error($method.'方法在模型中没有定义');
		}
    }

    public function query($sql)
    {
        if(empty($sql)) 
		{
		   return false;
        }
		$this->sql=$sql;
		$this->connect();
		return $query=$this->db->query($this->sql);
    }
	public function count()
	{
	    $data=array();
		$table=$this->options['_table'];
		$field='count(*)';
		$where=$this->_parseCondition();
		$this->sql="SELECT $field FROM $table $where";
		$this->connect();			
		$query=$this->db->query($this->sql);
        $data=$this->db->fetch_array($query);
		return $data['count(*)'];

	}
	//只查询一条信息，返回一维数组	
    public function find()
	{
	    $data=array();
		$table=$this->options['_table'];
		$field=$this->options['_field'];
		$where=$this->_parseCondition();
		$this->options['_field']='*';//设置下一次查询时，字段的默认值
		$this->sql="SELECT $field FROM $table $where";
		$this->connect();
		$query=$this->db->query($this->sql);
        $data=$this->db->fetch_array($query);
		return $data;
     }
	 
	//查询多条信息，返回数组
     public function select()
	{
		$table=$this->options['_table'];
		$field=$this->options['_field'];
		$where=$this->_parseCondition();
		$this->options['_field']='*';//设置下一次查询时，字段的默认值
		$this->sql="SELECT $field FROM $table $where";
		$data=array();
		$this->connect();
		$query=$this->db->query($this->sql);		
		while($row=$this->db->fetch_array($query))
		{
			$data[]=$row;
		}
		return $data;
     }
	 
	 //插入数据
    public function insert() 
	{
		$this->connect();
		$table=$this->options['_table'];
		$data=$this->_parseData('add');
        $this->sql="INSERT INTO $table $data" ;
        $query = $this->db->query($this->sql);
		if($this->db->affected_rows())
		{
			return  $this->db->insert_id();
		}
        return false;
    }
	//修改更新
    public function update()
	{
		$this->connect();
		$table=$this->options['_table'];
		$data=$this->_parseData('save');
		$where=$this->_parseCondition();
		//修改条件为空时，则返回false，避免不小心将整个表数据修改了
		if(empty($where))
		{
			return false;	
		}
        $this->sql="UPDATE $table SET $data $where" ;
	    $query = $this->db->query($this->sql);
		return $this->db->affected_rows();

    }
	//删除
    public function delete()
	{
		$this->connect();
		$table=$this->options['_table'];
		$where=$this->_parseCondition();
		//删除条件为空时，则返回false，避免数据不小心被全部删除
		if(empty($where))
		{
			return false;	
		}
		$this->sql="DELETE FROM $table $where";
        $query = $this->db->query($this->sql);
		return $this->db->affected_rows();
    }

	//返回sql语句
    public function getSql()
	{
        return $this->sql;
    }
	//解析数据,添加数据时$type=add,更新数据时$type=save
   private function _parseData($type) 
  {
		if((!isset($this->options['_data']))||(empty($this->options['_data']))||(!is_array($this->options['_data'])))
		{
			unset($this->options['_data']);	//清空$this->options['_data']数据
			return false;
		}
		switch($type)
		{
			case 'add':
					$data=array();
					$data['key']="";
					$data['value']="";
					foreach($this->options['_data'] as $key=>$value)
					{
							$data['key'].="$key,";
							$data['value'].="'$value',";
					}
					$data['key']=substr($data['key'], 0,-1);
					$data['value']=substr($data['value'], 0,-1);
					unset($this->options['_data']);	//清空$this->options['_data']数据
					return " (".$data['key'].") VALUES (".$data['value'].") ";
					break;
			case 'save':
					$data="";
					foreach($this->options['_data'] as $key=>$value)
					{
							$data.="$key='$value',";
					}
					$data=substr($data, 0,-1);	
					unset($this->options['_data']);	//清空$this->options['_data']数据
					return $data;
				break;
		default:
				unset($this->options['_data']);	//清空$this->options['_data']数据
				return false;
		}		
    }
	
	//解析sql查询条件
   private function _parseCondition() 
	{
		$condition="";
		//解析where()方法
		if(!empty($this->options['_where']))
		{
			$condition=" WHERE ";
			if(is_string($this->options['_where']))
			{
				$condition.=$this->options['_where'];
			}
			else if(is_array($this->options['_where']))
			{
					if(!empty($this->options['_where']['_string']))
					{
							$condition.=$this->options['_where']['_string']." AND ";
					}
					foreach($this->options['_where'] as $key=>$value)
					{
						 $condition.=" $key='$value' AND ";
					}

					$condition=substr($condition, 0,-4);	
			}
			else
			{
				$condition="";
			}
			unset($this->options['_where']);//清空$this->options['_where']数据
		}
		
		if(!empty($this->options['_group'])&&is_string($this->options['_group']))
		{
			$condition.=" GROUP BY ".$this->options['_group'];
			unset($this->options['_group']);
		}
				
		if(!empty($this->options['_having'])&&is_string($this->options['_having']))
		{
			$condition.=" HAVING ".$this->options['_having'];
			unset($this->options['_having']);
		}
				
		if(!empty($this->options['_order'])&&is_string($this->options['_order']))
		{
			$condition.=" ORDER BY ".$this->options['_order'];
			unset($this->options['_order']);
		}
		if(!empty($this->options['_limit'])&&(is_string($this->options['_limit'])||is_numeric($this->options['_limit'])))
		{
			$condition.=" LIMIT ".$this->options['_limit'];
			unset($this->options['_limit']);
		}
		
		if(empty($condition))
			return "";
        return $condition;
    }
}
?>