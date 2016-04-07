<?php

//session_start();

Class home_controller extends CI_Controller {
	public function __construct() {
	parent::__construct();

	// Load form helper library
	$this->load->helper('form');

	// Load database
}

	public function index() {
		$this->load->model('home_model');
		$results['types'] = $this->home_model->getService();
		$results['providers'] = $this->home_model->getSP();
		//$results['provide']= $results1;
		
		
		$results['maincontent']='shome';
		$this->load->view('template/maintemplate',$results);
		
		
	}


	public function service_type() {
		$SId=$this->uri->segment(3);
		$this->load->model('home_model');
		$results['types'] = $this->home_model->service_type($SId);
		$results['providers'] = $this->home_model->service_providers($SId);

		$results['maincontent']='service_type';
		$this->load->view('template/maintemplate',$results);
		
		
	}


	public function showProfile(){
		$SId=$this->uri->segment(3);
		$SPId=$this->uri->segment(4);
		$this->load->model('home_model');
		$results['types'] = $this->home_model->service_type($SId);
		$results['providers'] = $this->home_model->getSPProfile($SPId);

		$results['maincontent']='spprofile';
		$this->load->view('template/maintemplate',$results);


	}



}