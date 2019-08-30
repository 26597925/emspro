<?php
class brtk{
	const SUBJECTS_URL = "https://sdjrzk.xuanyun.tech/api/course/course/?is_active=true&page=1&page_size=100&search=";
	const SECTIONS_URL = "https://sdjrzk.xuanyun.tech/api/exam/paper/for_course/?id=%s";
	const QUESTIONS_URL = "https://sdjrzk.xuanyun.tech/api/exam/paper/%s/";
	
	public $pepModel=null;
	
	public function __construct($config)
	{
		$this->pepModel=new Model($config['pep']);
	}
	
	public function start(){
		print("load...\n");
		$this->pepModel->query('TRUNCATE TABLE  `x2_training`');
		$this->pepModel->query('TRUNCATE TABLE  `x2_subjects`');
		$this->pepModel->query('TRUNCATE TABLE  `x2_sections`');
		$this->pepModel->query('TRUNCATE TABLE  `x2_points`');
		$this->pepModel->query('TRUNCATE TABLE  `x2_questions`');
		$ggid = $this->pepModel->table("training")->data(array(
			"trname" => "公共课",
			"trtime" => time()
		))->insert();
		print("ggid:$ggid\n");
		
		$zyid = $this->pepModel->table("training")->data(array(
			"trname" => "专业课",
			"trtime" => time()
		))->insert();
		print("zyid:$zyid\n");
		
		$this->getSubjects($ggid, $zyid);
	}
	
	private function getSubjects($ggid, $zyid){
		$header = $this->getHeader();
		$str = Http::doGet(self::SUBJECTS_URL, 3000, $header);
		$this->insertSubjects($ggid, $zyid, $str);
	}
	
	private function insertSubjects($ggid, $zyid, $str){
		$subjecttrid = $ggid;
		$arr = json_decode($str, true);
		if(!empty($arr['results'])){
			foreach($arr['results'] as $info){
				if($info['category'] == 2){
					$subjecttrid = $zyid;
				}else{
					$subjecttrid = $ggid;
				}
				
				$data = array(
					"subjectname" => $info['name'],
					"subjectdb" => "default",
					"subjecttrid" => $subjecttrid,
					"subjectsetting" => '["DXT","MDXT","BDXT","PDT","WDT"]',
					"subjectintro" => $info['__str__']
				);
				
				$subjectsId = $this->pepModel->table("subjects")->data($data)->insert();
				print("subjectsId:$subjectsId\n");
				
				$this->getSections($info['id'], $subjectsId);
			}
		}
	}
	
	private function getSections($id, $subjectsId){
		$header = $this->getHeader();
		$url = sprintf(self::SECTIONS_URL, $id);
		print_r($url."\n");
		$str = Http::doGet($url, 3000, $header);
		
		$this->insertSections($subjectsId, $str);
	}
	
	private function insertSections($subjectsId, $str){
		$arr = json_decode($str, true);
		if(!empty($arr['course']['exam_papers'])){
			foreach($arr['course']['exam_papers'] as $index=>$info){
				
				$data = array(
					"sectionname" => $info['title'],
					"sectionsubject" => $subjectsId,
					"sectionorder" => $index
				);
				
				$sectionsId = $this->pepModel->table("sections")->data($data)->insert();
				print("sectionsId:$sectionsId\n");
				
				$data = array(
					"pointname" => "百日题库",
					"pointsection" => $sectionsId
				);
				
				$pointsId = $this->pepModel->table("points")->data($data)->insert();
				print("pointsId:$pointsId\n");
			
				$this->getQuestions($info['id'], $subjectsId, $pointsId);
			}
		}
		
		if(!empty($arr['course']['chapters'])){
			foreach($arr['course']['chapters'] as $index=>$chapters){
				if(!empty($chapters['exam_papers'])){
					foreach($chapters['exam_papers'] as $info){
						
						$data = array(
							"sectionname" => $info['title'],
							"sectionsubject" => $subjectsId,
							"sectionorder" => $index
						);
						
						$sectionsId = $this->pepModel->table("sections")->data($data)->insert();
						print("sectionsId:$sectionsId\n");
						
						$data = array(
							"pointname" => "百日题库",
							"pointsection" => $sectionsId
						);
						
						$pointsId = $this->pepModel->table("points")->data($data)->insert();
						print("pointsId:$pointsId\n");
					
						$this->getQuestions($info['id'], $subjectsId, $pointsId);
					}
				}
			}
		}
	}
	
	private function getQuestions($id, $subjectsId, $pointsId){
		$header = $this->getHeader();
		$url = sprintf(self::QUESTIONS_URL, $id);
		print_r($url."\n");
		$str = Http::doGet($url, 3000, $header);
		
		$this->insertQuestions($subjectsId, $pointsId, $str);
	}
	
	private function insertQuestions($subjectsId, $pointsId, $str){
		$arr = json_decode($str, true);
		if(!empty($arr['content_object']['groups'])){
			foreach($arr['content_object']['groups'] as $groups){
				if(!empty($groups['questions'])){
					foreach($groups['questions'] as $index=>$info){
						$questiontype = "DXT";
						if($info['type'] == "single"){
							$questiontype = "DXT";
						}else if($info['type'] == "multiple"){
							$questiontype = "MDXT";
						}else if($info['type'] == "input"){
							$questiontype = "WDT";
						}
				
						$options = $this->getQuestionSelect($info);
						$questionselect = implode("<hr>", $options);
						$questionselectnumber = count($options);
						$questionanswer = $this->getQuestionAnswer($questiontype,$info);
						
						$data = array(
						"question" => addslashes($info['title']),
						"questiontype" => $questiontype,
						"questionselect" => $questionselect,
						"questionselectnumber"=>$questionselectnumber,
						"questionanswer"=>$questionanswer,
						"questionlevel"=>3,
						"questionsubject"=>$subjectsId,
						"questionpoints"=>$pointsId,
						"questionorder"=>$index,
						"questionstatus"=>1,
						"questionauthor"=>"wenford",
						"questiontime"=>time()
						);
					
						$questionsId = $this->pepModel->table("questions")->data($data)->insert();
						print("questionsId:$questionsId\n");
					}
				}
			}
		}
	}
	
	private function getQuestionSelect($info){
		$options = array();
		if(!empty($info['options'])){
			foreach($info['options'] as $data){
				$options[] = addslashes($data['text']);
			}
		}
		
		return $options;
	}
	
	private function getQuestionAnswer($questiontype, $info){
		$answer = array();
		if(!empty($info['answer'])){
			foreach($info['answer'] as $value){
				if(is_array($value)){
					$answer = array_merge_recursive($answer, $value);
				}else{
					$answer[] = $value;
				}
			}
		}
		
		if($questiontype == "WDT")
		{
			return implode(",", $answer);
		}
		return implode("", $answer);
	}
	
	private function getHeader(){
		$header="User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36 QBCore/4.0.1219.400 QQBrowser/9.0.2524.400 Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36 MicroMessenger/6.5.2.501 NetType/WIFI WindowsWechat\r\n";
		$header.="Accept: application/json, text/plain, */*\r\n";
		$header.="Referer: https://sdjrzk.xuanyun.tech/mobile/exam/\r\n";
		$header.="X-CSRFToken: 自己的信息\r\n";
		$header.="Cookie: csrftoken=自己的信息; sessionid=自己的信息\r\n";
		
		return $header;
	}
}
?>
