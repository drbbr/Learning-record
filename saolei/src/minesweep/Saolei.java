package minesweep;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Random;

public class Saolei implements ActionListener {
    int ROW =17;
    int COL =30;
    int MINES=99;
    int unopen=MINES;
    int opend=0;
    int seconds=0;
    boolean flag=false;

    Mine[][] mines=new Mine[ROW][COL];

    ImageIcon smile=new ImageIcon("D:\\sya\\eclipse-work-space\\saolei\\src\\smile.png");
    ImageIcon cry=new ImageIcon("D:\\sya\\eclipse-work-space\\saolei\\src\\cry.png");
    ImageIcon flower=new ImageIcon("D:\\sya\\eclipse-work-space\\saolei\\src\\flower.png");
    ImageIcon lei=new ImageIcon("D:\\sya\\eclipse-work-space\\saolei\\src\\lei.png");
    ImageIcon sqr=new ImageIcon("D:\\sya\\eclipse-work-space\\saolei\\src\\sqr.png");
    JFrame frame=new JFrame();
    JButton face=null;
    JLabel count=new JLabel("剩余数量: "+unopen);
    JLabel timer=new JLabel("时间:"+seconds+"s");

    JButton[][] btns=new JButton[ROW][COL];
    Timer times=new Timer(1000,this);

    public static void main(String[] args)
    {
        new Saolei();
    }

    public Saolei(){
        frame.getContentPane().setBackground(new Color(255, 248, 220));
        frame.setBackground(new Color(240, 248, 255));
        frame.setTitle("扫雷");
        frame.setResizable(false);
        frame.setSize(1100,700);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        smile.setImage(smile.getImage().getScaledInstance(40, 40, Image.SCALE_DEFAULT));
        cry.setImage(cry.getImage().getScaledInstance(40, 40, Image.SCALE_DEFAULT));
        lei.setImage(lei.getImage().getScaledInstance(32, 32, Image.SCALE_DEFAULT));
        flower.setImage(flower.getImage().getScaledInstance(32, 32, Image.SCALE_DEFAULT));
        setBanner();
        initMines();
        frame.setVisible(true);
    }

    private void initMines() {
        Container con=new Container();
        con.setLocation(15, 65);
        con.setSize(1050, 595);
        con.setLayout(new GridLayout(ROW,COL));
        initMine();
        for (int i=0;i<ROW;i++)
        {
            for (int j=0;j<COL;j++)
            {
                JButton b=new JButton(sqr);
                b.addActionListener(this);
                b.setBackground(new Color(180,238,180));
                b.setEnabled(true);
                b.setFocusPainted(false);
                b.setFont(new Font("黑体", Font.BOLD, 18));
                b.setBorder(BorderFactory.createRaisedBevelBorder());

                b.addMouseListener(new MouseListener() {
                    @Override
                    public void mouseClicked(MouseEvent e) {
                        mouse(e);
                    }

                    @Override
                    public void mousePressed(MouseEvent e) {

                    }

                    @Override
                    public void mouseReleased(MouseEvent e) {

                    }

                    @Override
                    public void mouseEntered(MouseEvent e) {

                    }

                    @Override
                    public void mouseExited(MouseEvent e) {

                    }
                });
                con.add(b);
                btns[i][j]=b;
            }
        }
        frame.getContentPane().add(con,BorderLayout.CENTER);
    }

    private void initMine(){
        for(int i=0;i<ROW;i++)
        {
            for(int j=0;j<COL;j++)
            {

                mines[i][j]=new Mine();
                mines[i][j].data=0;
                mines[i][j].isOpen=false;
                mines[i][j].isFlag=false;
            }
        }

        Random rand=new Random();
        for(int i=0;i<MINES;){
            int x= rand.nextInt(ROW);
            int y= rand.nextInt(COL);
            if(mines[x][y].data!=-1){
                mines[x][y].data=-1;
                i++;
            }
        }

        for(int i=0;i<ROW;i++)
        {
            for(int j=0;j<COL;j++)
            {

                if(mines[i][j].data==-1) continue;
                int c=0;
                if(i+1<ROW&&mines[i+1][j].data==-1)  c++;
                if(j+1<COL&&mines[i][j+1].data==-1)  c++;
                if(i-1>-1&&mines[i-1][j].data==-1)   c++;
                if(j-1>-1&&mines[i][j-1].data==-1)   c++;
                if(i+1<ROW&&j+1<COL&&mines[i+1][j+1].data==-1)   c++;
                if(j-1>-1&&i-1>-1&&mines[i-1][j-1].data==-1)     c++;
                if(i+1<ROW&&j-1>-1&&mines[i+1][j-1].data==-1)    c++;
                if(j+1<COL&&i-1>-1&&mines[i-1][j+1].data==-1)    c++;
                mines[i][j].data=c;
            }
        }
    }

    private void setBanner() {
        face=new JButton();
        face.setBackground(new Color(245, 255, 250));
        face.setLocation(499, 0);
        face.setSize(50,50);
        face.setContentAreaFilled(false);
        face.setIcon(smile);
        face.setFocusPainted(false);

        face.addActionListener(this);

        count.setFont(new Font("思源黑体 CN Regular", Font.PLAIN, 20));
        count.setSize(200, 50);
        count.setLocation(101,13);

        timer.setLocation(826, 13);
        timer.setSize(160, 50);
        timer.setFont(new Font("思源黑体 CN Regular", Font.PLAIN, 20));

        JPanel banner=new JPanel();
        banner.setLocation(15, 7);
        banner.setBackground(new Color(255, 248, 220));
        banner.setLayout(null);
        banner.setSize(1051,52);
        banner.add(count);
        banner.add(face);
        banner.add(timer);
        frame.getContentPane().add(banner);
    }

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		if(e.getSource() instanceof Timer)
        {
            seconds++;
            timer.setText("时间:"+seconds+"s");
            return;
        }
		if(!flag)
        {
            times.start();
            flag=true;
        }
        JButton b=(JButton)e.getSource();
		if(b.equals(face))
        {
            restart();
            return;
        }
	}


    public void mouse(MouseEvent e) {
        int c=e.getButton();
        if(c==MouseEvent.BUTTON1){      //左键
            JButton bx= (JButton) e.getSource();
            for(int i=0;i<ROW;i++)
            {
                for(int j=0;j<COL;j++)
                {
                    if(bx.equals(btns[i][j])){
                        openCell(i, j);
                        ifWin();
                        return;
                    }
                }
            }
        }
        if(c==MouseEvent.BUTTON3)       //右键
        {
            JButton bx= (JButton) e.getSource();
            for(int i=0;i<ROW;i++)
            {
                for(int j=0;j<COL;j++)
                {
                    if(bx.equals(btns[i][j])){
                        if(mines[i][j].isOpen==false){
                        if(mines[i][j].isFlag==false)
                        {
                            //插旗
                            btns[i][j].setIcon(flower);
                            mines[i][j].isFlag=true;
                            unopen--;
                            count.setText("剩余数量: "+unopen);
                        }
                        else {
                            //去旗
                            btns[i][j].setIcon(sqr);
                            mines[i][j].isFlag=false;
                            unopen++;
                            count.setText("剩余数量: "+unopen);
                        }
                        }
                        else{
                            //翻开周围
                            int count=0;
                            if(i+1<ROW)  if(mines[i+1][j].isFlag)     count++;
                            if(j+1<COL)  if(mines[i][j+1].isFlag)     count++;
                            if(i-1>-1)   if(mines[i-1][j].isFlag)     count++;
                            if(j-1>-1)   if(mines[i][j-1].isFlag)     count++;
                            if(i+1<ROW&&j+1<COL)   if(mines[i+1][j+1].isFlag)     count++;
                            if(j-1>-1&&i-1>-1)     if(mines[i-1][j-1].isFlag)     count++;
                            if(i+1<ROW&&j-1>-1)    if(mines[i+1][j-1].isFlag)     count++;
                            if(j+1<COL&&i-1>-1)    if(mines[i-1][j+1].isFlag)     count++;

                            if (count==mines[i][j].data)
                            {
                            if(i+1<ROW)  openCell(i+1,j);
                            if(j+1<COL)  openCell(i,j+1);
                            if(i-1>-1)   openCell(i-1,j);
                            if(j-1>-1)   openCell(i,j-1);
                            if(i+1<ROW&&j+1<COL)   openCell(i+1,j+1);
                            if(j-1>-1&&i-1>-1)     openCell(i-1,j-1);
                            if(i+1<ROW&&j-1>-1)    openCell(i+1,j-1);
                            if(j+1<COL&&i-1>-1)    openCell(i-1,j+1);
                        }
                            if(opend+MINES==ROW*COL)
                            {
                                ifWin();
                            }
                        }
                        return;
                    }
                }
            }
        }
    }

    private void restart() {
        times.stop();
        flag=false;
        seconds=0;
        unopen=99;
        opend=0;
        face.setIcon(smile);
        count.setText("剩余数量: "+MINES);
        timer.setText("时间:"+seconds+"s");
        for(int i=0;i<ROW;i++)
        {
            for(int j=0;j<COL;j++)
            {
                mines[i][j].data=0;
                mines[i][j].isOpen=false;
                mines[i][j].isFlag=false;
                btns[i][j].setText("");
                btns[i][j].setIcon(sqr);
                btns[i][j].setBackground(new Color(180,238,180));
                btns[i][j].setEnabled(true);
            }
        }
        initMine();
    }

    private void ifWin() {
        int c=0;
        for(int i=0;i<ROW;i++)
        {
            for(int j=0;j<COL;j++)
            {
                if(!mines[i][j].isOpen)
                    c++;
            }}
        if(c==MINES)
        {
            times.stop();
            JOptionPane.showMessageDialog(frame,"You Win!");
        }
    }

    private void fail() {
        times.stop();
        for(int i=0;i<ROW;i++)
        {
            for(int j=0;j<COL;j++) {
                btns[i][j].setEnabled(false);
                if(mines[i][j].data==-1)
                {
                    btns[i][j].setIcon(lei);
                }
            }
        }
        face.setIcon(cry);
    }

    private void openCell(int i,int j) {
        JButton b=btns[i][j];
        if(mines[i][j].isOpen||mines[i][j].isFlag||!btns[i][j].isEnabled())  return;
        if(mines[i][j].data==-1)
        {
            fail();
        }
        else if(mines[i][j].data==0)
        {
            openZero(i,j);
        }
        else
        {
            b.setIcon(null);
            b.setBackground(new Color(255,246,143));
            b.setText(String.valueOf(mines[i][j].data));
            mines[i][j].isOpen=true;
            opend++;
            return;
        }

    }

    private void openZero(int i, int j) {
        btns[i][j].setIcon(null);
        btns[i][j].setBackground(new Color(255,246,143));
        mines[i][j].isOpen=true;
        opend++;
        if(i+1<ROW)  openCell(i+1,j);
        if(j+1<COL)  openCell(i,j+1);
        if(i-1>-1)   openCell(i-1,j);
        if(j-1>-1)   openCell(i,j-1);
        if(i+1<ROW&&j+1<COL)   openCell(i+1,j+1);
        if(j-1>-1&&i-1>-1)     openCell(i-1,j-1);
        if(i+1<ROW&&j-1>-1)    openCell(i+1,j-1);
        if(j+1<COL&&i-1>-1)    openCell(i-1,j+1);
    }
}
