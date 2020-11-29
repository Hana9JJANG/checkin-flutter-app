<?php
include 'conn.php';
//flag 1 for login
//flag 2 for update register
//flag to check and to execute specific switch case based on flag value sent
$flag = $_POST['flag'];
(int) $flag;

switch ($flag) {
    
    case 1:
        	//assigning data sent to $email which can be either email or pphone no in return we'll be sending email only
        	$email = $_POST['email'];
        	$pass = md5($_POST['pass']);
        	$token = $_POST['token'];
        
        	//creating a query
        	$query = "SELECT * FROM tb_owner WHERE email='$email' AND pass = '$pass' AND status=1 ";
        	$result = mysqli_query($connect, $query);
            
        
            if($result->num_rows>0){
    		    
        		while ($row = mysqli_fetch_assoc($result)) {
                    //Update  Token
                	$query2 = "UPDATE `tb_owner` SET `token`='$token' WHERE `ownerID`='".$row['ownerID']."' ";
                	$result2 = mysqli_query($connect, $query2);
        
        			$json['value'] = 1;
        			$json['message'] = 'User Successfully LoggedIn';
        			$json['email'] = $row['email'];
        			$json['name'] = $row['name'];
        			$json['ownerID'] = $row['ownerID'];
        			$json['status'] = 'success';
        
        		}
    		    
    			
    		}else{
        
        			$json['value'] = 0;
        			$json['message'] = 'Failed to LogIn';
        			$json['email'] = '';
        			$json['name'] = '';
        			$json['ownerID'] = '';
        			$json['status'] = 'failure';
    
    		}
    // 		echo json_encode($json);
    // 		mysqli_close($connect);
            
            break;
            //Ends case 1
    
    case 2:
             $name = $_POST['name'];
             $email = $_POST['email'];
             $pass = md5($_POST['pass']);
			 $status = $_POST['status'];

    		 $sqlmax = "SELECT max(ownerID) FROM `tb_owner`";
    	     $resultmax = mysqli_query($connect, $sqlmax);
    	     $rowmax = mysqli_fetch_array($resultmax);
    	     
    	     if($rowmax[0]==null){
    	          $idnomax=1;
    	     }else{
    	          $idnomax=$rowmax[0]+1;
    	     }
        
            $query = "SELECT * FROM tb_owner WHERE email='$email'";
        	$result = mysqli_query($connect, $query);
        	
    		if(mysqli_num_rows($result)>0){
    			$json['value'] = 2;
    			$json['message'] = ' email Already Used: ' .$email;
    			
    		}else{
    			$query = "INSERT INTO tb_owner (ownerID, name, email, pass, status) VALUES ('$idnomax','$name','$email','$pass','$status')";
    			$inserted = mysqli_query($connect, $query);
    			
    			if($inserted == 1 ){    			
    			    
    				$json['value'] = 1;
    				$json['message'] = 'User Successfully Registered';
    			}else{
    				$json['value'] = 0;
    				$json['message'] = 'User Registration Failed';
    			}
      		}
            break;
    default:
        $inserted == 0;
}     
	echo json_encode($json);
	mysqli_close($connect);

?>