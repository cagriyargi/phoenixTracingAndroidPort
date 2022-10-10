<?php

class Constants
{
    //VT bilgileri
    static $DB_SERVER="localhost";
    static $DB_NAME="phoenixtracing";
    static $USERNAME="SamedZZZZ";
    static $PASSWORD="samed1234";
}

class Gorevler
{
    /*******************************************************************************************************************************************/
    /*
       1. VTye BAGLANTI
       2. BAGLANTIDAN CEVAP
    */
    public function connect()
    {
        $con=new mysqli(Constants::$DB_SERVER,Constants::$USERNAME,Constants::$PASSWORD,Constants::$DB_NAME);
        if($con->connect_error)
        {
            // echo "Baglantı yok"; - debug icin
            return null;
        }else
        {
            //echo "Baglandı"; - debug icin
            return $con;
        }
    }
    /*******************************************************************************************************************************************/
    /*
       1.VTden SECIM.
    */
    public function select()
    {
        $con=$this->connect();
        if($con != null)
        {
            $job_id=$_POST['job_id'];
            $userid=$_POST['userid'];
            $SQL_SELECT_ALL="SELECT * FROM `operation_jobs` WHERE job_id='".$job_id."' AND technician_id='".$userid."'";
            $result=$con->query($SQL_SELECT_ALL);
            if($result->num_rows>0)
            {
                $gorevler=array();
                while($row=$result->fetch_array())
                {
                    array_push($gorevler, array("job_id"=>$row['job_id'],"request_id"=>$row['request_id'],
                    "technician_id"=>$row['technician_id'],"name"=>$row['name'],
                    "detail"=>$row['detail'],"priority"=>$row['priority'],"address_id"=>$row['address_id'],"start_date"=>$row['start_date'],
                    "end_date"=>$row['end_date'],"total_work_time"=>$row['total_work_time'],"status_id"=>$row['status_id'],
                    "active"=>$row['active'],));
                }
                print(json_encode(array_reverse($gorevler)));
            }else
            {
                print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
            }
            $con->close();

        }else{
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }
}
$gorevler=new Gorevler();
$gorevler->select();

//son
