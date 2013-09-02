import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
public class EasyIP{
	public static void main(String[] args){
		GUI g = new GUI();
		try{
		g.initial();
		}catch(Exception e){System.out.print(e);};
	}
}
class GUI implements ActionListener,ItemListener{
	int selected;
	String data[][] = new String[10][5];
	JButton b1 = new JButton("添加");
	JButton b2 = new JButton("设置本地连接");
	JButton b3 = new JButton("设置无线连接");
	JComboBox cb1 = new JComboBox();
	JTextField tf1 = new JTextField(15);
	JTextField tf2 = new JTextField(15);
	JTextField tf3 = new JTextField(15);
	JTextField tf4 = new JTextField(15);
	GUI(){
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLayout(new BorderLayout());
		frame.setSize(600,480);
		JPanel panel1 = new JPanel();
		panel1.setPreferredSize(new Dimension(400,480));
		cb1.addItemListener(this);
		panel1.setLayout(new GridLayout(5,1));
		panel1.add(cb1);
		JPanel p1 = new JPanel();
		JLabel l1 = new JLabel("IP地址");
		p1.add(l1);
		p1.add(tf1);
		panel1.add(p1);
		JPanel p2 = new JPanel();
		JLabel l2 = new JLabel("网关");
		p2.add(l2);
		p2.add(tf2);
		panel1.add(p2);
		JPanel p3 = new JPanel();
		JLabel l3 = new JLabel("DNS1");
		p3.add(l3);
		p3.add(tf3);
		panel1.add(p3);
		JPanel p4 = new JPanel();
		JLabel l4 = new JLabel("DNS2");
		p4.add(l4);
		p4.add(tf4);
		panel1.add(p4);
		frame.add(panel1,BorderLayout.CENTER);
		JPanel panel2 = new JPanel();
		panel2.setPreferredSize(new Dimension(200,480));
		panel2.setLayout(new GridLayout(3,1));
		panel2.add(b1);
		panel2.add(b2);
		panel2.add(b3);
		frame.add(panel2,BorderLayout.EAST);
		frame.setVisible(true);
	}
	public void actionPerformed(ActionEvent e)
	{
		String net = new String();
		if (e.getSource()==b2)
			net = "Local Area Connection";
		if (e.getSource()==b3)
			net = "Wireless Network Connection";
		if (e.getSource()!=b1){
			if(cb1.getSelectedItem()!="自动获取"){
				try{
				Runtime.getRuntime().exec("netsh interface ipv4 set address "+net+" static "+data[selected][1]+" 255.0.0.0 "+data[selected][2]);
				Runtime.getRuntime().exec("netsh interface ipv4 set dnsservers name="+net+" static "+data[selected][3]+" primary validate=no");
				Runtime.getRuntime().exec("netsh interface ipv4 add dnsservers "+net+" "+data[selected][4]+" validate=no");
				}
				catch(Exception ex){};
			}
			else{
				try{Runtime.getRuntime().exec("netsh interface ipv4 set address "+net+" source=dhcp");}catch(Exception ex){};
			}
		}
	}
	public void itemStateChanged(ItemEvent e){
		if(e.getStateChange()==ItemEvent.SELECTED){
			for(int i=0;i<10;i++){
				if(cb1.getSelectedItem()==data[i][0]){
					tf1.setText(data[i][1]);
					tf2.setText(data[i][2]);
					tf3.setText(data[i][3]);
					tf4.setText(data[i][4]);
					selected=i;
				}
				if(cb1.getSelectedItem()=="自动获取"){
					tf1.setText("");
					tf2.setText("");
					tf3.setText("");
					tf4.setText("");
				}
			}
		}
	}
	void initial () throws Exception
	{
		String s = new String();
		File file = new File("D:/EasyIP/EasyIP.txt");
		BufferedReader br = new BufferedReader(new FileReader(file));
		s = br.readLine();
		int flag = 0;
		int flag2 = 0;
		while(s!=null){
			data[flag2][flag]=s;
			if(flag==0)
				cb1.addItem(s);
			flag++;
			if(flag==5){
				flag=0;
				flag2++;
			}
			s=br.readLine();
		}
		cb1.addItem("自动获取");
	}
}