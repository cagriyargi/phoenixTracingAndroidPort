<?php

class Constants
{
    //DATABASE DETAILS
    static $DB_SERVER="localhost";
    static $DB_NAME="login";
    static $USERNAME="root";
    static $PASSWORD="";

    //STATEMENTS
    static $SQL_SELECT_ALL="SELECT * FROM gorevler";

}

class Gorevler
{
    /*******************************************************************************************************************************************/
    /*
       1.CONNECT TO DATABASE.
       2. RETURN CONNECTION OBJECT
    */
    public function connect()
    {
        $con=new mysqli(Constants::$DB_SERVER,Constants::$USERNAME,Constants::$PASSWORD,Constants::$DB_NAME);
        if($con->connect_error)
        {
            // echo "Unable To Connect"; - For debug
            return null;
        }else
        {
            //echo "Connected"; - For debug
            return $con;
        }
    }
    /*******************************************************************************************************************************************/
    /*
       1.SELECT FROM DATABASE.
    */
    public function select()
    {
        $con=$this->connect();
        if($con != null)
        {
            $result=$con->query(Constants::$SQL_SELECT_ALL);
            if($result->num_rows>0)
            {
                $gorevler=array();
                while($row=$result->fetch_array())
                {
                    array_push($gorevler, array("gorev_id"=>$row['gorev_id'],"gorev_adi"=>$row['gorev_adi'],
                    "gorev_adres"=>$row['gorev_adres'],"gorev_calisan"=>$row['gorev_calisan'],
                    "gorev_tarih"=>$row['gorev_tarih'],"gorev_yap"=>$row['gorev_yap']));
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

//end
