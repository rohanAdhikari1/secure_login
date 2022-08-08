<?php
	require_once 'utils.php';
	//echo password_hash("1J7JMuCWhITUkQXFHkodpz1r1k2riPszLSYZsnBYy1ZJFI1CXe", PASSWORD_DEFAULT);
	$headers = getallheaders();  
	if(isset($headers['csrf_token']))
	{
		if(isset($_POST['phone']) && isset($_POST['password']) && isset($headers['csrf_token']) && validateToken($headers['csrf_token'])) {
		  $phone = $_POST['phone'];
		  $password = $_POST['password'];
		  $C = connect();
		  if($C) {
			$hourAgo = time() - 60*60;
			$res = sqlSelect($C, 'SELECT users.id,password,verified,COUNT(loginattempts.id) FROM users LEFT JOIN loginattempts ON users.id = user AND timestamp>? WHERE phone=? GROUP BY users.id', 'is', $hourAgo, $phone);
			if($res && $res->num_rows === 1) {
				$user = $res->fetch_assoc();
				if($user['verified']) {
				}
					if($user['COUNT(loginattempts.id)'] <= MAX_LOGIN_ATTEMPTS_PER_HOUR) {
						if(password_verify($password, $user['password'])) {
							$token = createToken();
							sqlUpdate($C, 'UPDATE users SET token = ? WHERE id=?','si',$token, $user['id']);
							sqlUpdate($C, 'DELETE FROM loginattempts WHERE user=?', 'i', $user['id']);
							$response["status"]="success";
							$response["message"]="Successfully logined!";
							$response["uid"]=$user['id'];
							$response["token"]=$token;
						}
						else {
							$id = sqlInsert($C, 'INSERT INTO loginattempts VALUES (NULL, ?, ?, ?)', 'isi', $user['id'], $_SERVER['REMOTE_ADDR'], time());
							if($id !== -1) {
								$response["status"]="error";
								$response["message"]="Incorrect Phone or password";
							}
							else {
								$response["status"]="error";
								$response["message"]="Failed to connect to database. Please try again later.";
							}
						}
					}
					else {
						$response["status"]="error";
						$response["message"]="You have exceeded the max number of login attempts per hour. Try again in an hour.";
					}

				$res->free_result();
			}
			else {
				$response["status"]="error";
				$response["message"]="Incorrect phone or password.";
			}
			$C->close();
		}
		else {
			$response["status"]="error";
			$response["message"]="Failed to connect to database. Please try again later..";
		}
	}
	else {
	$response["status"]="error";
	$response["message"]="An unknown error occurred. Please try again later.";
	}
	}
	else {
	$response["status"]="error";
	$response["message"]="Sorry! you cannot access this api without api token.";
	}
	echo json_encode($response);
	?>