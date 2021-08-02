# This function allows a dialog to be opened and 5 values to be inputted to be passed as an object to a script
# This script is based on the script from https://techwizard.cloud/2014/03/11/powershell-custom-gui-input-box-for-passing-values-to-variables/
# This was modified by Trevor Long on 8-2-21
function button ($title, $label1, $label2, $label3, $label4, $label5) {
    
    [null][System.Reflection.Assembly]::LoadWithPartialName( “System.Windows.Forms”)
    [null][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)
    
    $form = New-Object “System.Windows.Forms.Form”;
    $form.Width = 500;
    $form.Height = 280;
    $form.Text = $title;
    #$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;
    
    $textLabel1 = New-Object “System.Windows.Forms.Label”; #Text label 1
    $textLabel1.Left = 25;
    $textLabel1.Top = 20;
    $textLabel1.Text = $label1;
    
    $textLabel2 = New-Object “System.Windows.Forms.Label”; #Text label 2
    $textLabel2.Left = 25;
    $textLabel2.Top = 60;
    $textLabel2.Text = $label2;
     
    $textLabel3 = New-Object “System.Windows.Forms.Label”; #Text label 3
    $textLabel3.Left = 25;
    $textLabel3.Top = 100;
    $textLabel3.Text = $label3;

    $textLabel4 = New-Object “System.Windows.Forms.Label”; #Text label 4
    $textLabel4.Left = 25;
    $textLabel4.Top = 140;
    $textLabel4.Text = $label4;

    $textLabel5 = New-Object “System.Windows.Forms.Label”; #Text label 5
    $textLabel5.Left = 25;
    $textLabel5.Top = 180;
    $textLabel5.Text = $label5;
    
    $textBox1 = New-Object “System.Windows.Forms.TextBox”; #Text box 1
    $textBox1.Left = 150;
    $textBox1.Top = 20;
    $textBox1.width = 200;
    
    $textBox2 = New-Object “System.Windows.Forms.TextBox”; #Text box 2
    $textBox2.Left = 150;
    $textBox2.Top = 60;
    $textBox2.width = 200;
    
    $textBox3 = New-Object “System.Windows.Forms.TextBox”; #Text box 3
    $textBox3.Left = 150;
    $textBox3.Top = 100;
    $textBox3.width = 200;
    
    $textBox4 = New-Object “System.Windows.Forms.TextBox”; #Text box 4
    $textBox4.Left = 150;
    $textBox4.Top = 140;
    $textBox4.width = 200;
    
    $textBox5 = New-Object “System.Windows.Forms.TextBox”; #Text box 5
    $textBox5.Left = 150;
    $textBox5.Top = 180;
    $textBox5.width = 200;
    
    $defaultValue = “”
    $textBox1.Text = $defaultValue;
    $textBox2.Text = $defaultValue;
    $textBox3.Text = $defaultValue;
    $textBox4.Text = $defaultValue;
    $textBox5.Text = $defaultValue;
    
    $button = New-Object “System.Windows.Forms.Button”;
    $button.Left = 360;
    $button.Top = 210;
    $button.Width = 100;
    $button.Text = “Ok”;
    
    $eventHandler = [System.EventHandler]{
    $textBox1.Text;
    $textBox2.Text;
    $textBox3.Text;
    $textBox4.Text;
    $textBox5.Text;
    $form.Close();};
    
    $button.Add_Click($eventHandler);
    
    $form.Controls.Add($button);
    $form.Controls.Add($textLabel1);
    $form.Controls.Add($textLabel2);
    $form.Controls.Add($textLabel3);
    $form.Controls.Add($textLabel4);
    $form.Controls.Add($textLabel5);

    $form.Controls.Add($textBox1);
    $form.Controls.Add($textBox2);
    $form.Controls.Add($textBox3);
    $form.Controls.Add($textBox4);
    $form.Controls.Add($textBox5);

    $form.ShowDialog() | Out-Null;
    
    return $textBox1.Text, $textBox2.Text, $textBox3.Text, $textBox4.Text, $textBox5.Text
    }