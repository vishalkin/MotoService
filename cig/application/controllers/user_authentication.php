<?php

//session_start(); //we need to start session in order to access it through CI

Class user_authentication extends CI_Controller {

public function __construct() {
parent::__construct();

// Load form helper library
$this->load->helper('form');

// Load form validation library
//$this->load->library('form_validation');

// Load session library


// Load database
$this->load->model('login_database');
}

// Show login page
public function index() {
$this->load->view('login_form');
}

// Show registration page
public function user_registration_show() {
$this->load->view('registration_form');
}

// Validate and store registration data in database
public function new_customer_registration() {

// Check validation for user input in SignUp form
$this->form_validation->set_rules('Cname', 'CName', 'required');
$this->form_validation->set_rules('Cemail', 'CEmail', 'required');
$this->form_validation->set_rules('Cpassword', 'CPassword', 'required');
$this->form_validation->set_rules('Caddress', 'CAddress', 'required');
$this->form_validation->set_rules('Cphone', 'CPhone', 'required');


if ($this->form_validation->run() == FALSE) {
$this->load->view('registration_form');
} else {
$data = array(
'Cname' => $this->input->post('Cname'),
'Cphone' => $this->input->post('Cphone'),
'Caddress' => $this->input->post('Caddress'),
'Cemail' => $this->input->post('Cemail'),
'Cpassword' => $this->input->post('Cpassword')
);
$result = $this->login_database->registration_insert($data);
if ($result == TRUE) {
$data['message_display'] = 'Registration Successfully !';
$this->load->view('login_form', $data);
} else {
$data['message_display'] = 'Username already exist!';
$this->load->view('registration_form', $data);
}
}
}

// Check for user login process
public function user_login_process() {

$this->form_validation->set_rules('Cemail', 'CEmail', 'required');
$this->form_validation->set_rules('Cpassword', 'CPassword', 'required');

if ($this->form_validation->run() == FALSE) {
if(isset($this->session->userdata['logged_in'])){

		$results['maincontent']='shome';
		$this->load->view('template/maintemplate',$results);

}else{
$this->load->view('login_form');
}
} else {
$data = array(
'Cemail' => $this->input->post('Cemail'),
'Cpassword' => $this->input->post('Cpassword')
);
$result = $this->login_database->login($data);
if ($result == TRUE) {

$Cemail = $this->input->post('Cemail');
$result = $this->login_database->read_user_information($Cemail);
if ($result != false) {
$session_data = array(
'username' => $result[0]->CName,
'email' => $result[0]->CEmail,
);
// Add user data in session
	$this->session->set_userdata('logged_in', $session_data);
	$this->load->model('home_model');
	$results['types'] = $this->home_model->getService();
	$results['providers'] = $this->home_model->getSP();

	$results['maincontent']='shome';
	$this->load->view('template/maintemplate',$results);
}
} else {
$data = array(
'error_message' => 'Invalid Username or Password'
);

$this->load->view('login_form', $data);
}
}
}

// Logout from admin page
public function logout() {

// Removing session data
$sess_array = array(
'username' => ''
);
$this->session->unset_userdata('logged_in', $sess_array);
$data['message_display'] = 'Successfully Logout';
$this->load->view('login_form', $data);
}

}

?>