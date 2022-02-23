import java.util.*;
public class Indstruction {
	public static final String[] type = {"loadI","r4","r3"};
	public static final String[] instructions = {"li",
			"mal","mah","msl","msh",
			"nop","bcw","and","or","popcnth","clz","rot","shslhi","a","sfw","ah","sfh","ahs","sfhs","mpyu","absdb"};
	int format;
	private String instruction;
	private String code;
	private String bits;
	public void findFormat() {
		String temp;
		for(int i=0;i<instructions.length;i++) {
			int pos = code.indexOf(' ');
			temp=code.substring(0, pos);
			if(temp.equals(instructions[i])) {
				if(i==0) {
					format=0;
					instruction = instructions[i];
					return;
				}
				else if(i<5){
					format =1;
					instruction = instructions[i];
					return;
				}
				else {
					format =2;
					instruction = instructions[i];
					return;
				}
			}
		}
	}
	//li rd li i6 bit number
	public void loadImmediate() {
		String temp = code.substring(code.indexOf(' ')+1,code.length());
		String rd = temp.substring(0, temp.indexOf(' '));
		int rdes = Integer.parseInt(rd);
		//System.out.println(rdes);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		String li = temp.substring(0, temp.indexOf(' '));
		int load = Integer.parseInt(li);
		//System.out.println(load);
		int imm= Integer.parseInt( temp.substring(temp.indexOf(' ')+1,temp.length()));
		//System.out.println(imm);
		bits= "0" + dectobin(load,3)+ dectobin(imm,16)+dectobin(rdes,5);
		System.out.println(bits);
	}
	//mashl rs3 rs2 rs1 rd
	public void r4format() {
		int op=0;
		for(int i=0;i<instructions.length;i++) {
			if(instruction.equals(instructions[i])) {
				op=i-1;
			}
		}
		String temp = code.substring(code.indexOf(' ')+1,code.length());
		String rs3 = temp.substring(0, temp.indexOf(' '));
		int rs3I = Integer.parseInt(rs3);
		//System.out.println(rs3I);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		String rs2 = temp.substring(0, temp.indexOf(' '));
		int rs2I = Integer.parseInt(rs2);
		//System.out.println(rs2I);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		String rs1 = temp.substring(0, temp.indexOf(' '));
		int rs1I = Integer.parseInt(rs1);
		//System.out.println(rs1I);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		int rdI = Integer.parseInt( temp.substring(temp.indexOf(' ')+1,temp.length()));
		//System.out.println(rdI);
		bits= "10" + dectobin(op,3)+ dectobin(rs3I,5)+dectobin(rs2I,5)+dectobin(rs1I,5)+dectobin(rdI,5);
		System.out.println(bits);
		
	}
	public void r3format() {
		int op=0;
		for(int i=0;i<instructions.length;i++) {
			if(instruction.equals(instructions[i])) {
				op=i-5;
			}
		}
//		System.out.println(instructions[op+5]);
		String temp = code.substring(code.indexOf(' ')+1,code.length());
		String rs2 = temp.substring(0, temp.indexOf(' '));
		int rs2I = Integer.parseInt(rs2);
		//System.out.println(rs2I);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		String rs1 = temp.substring(0, temp.indexOf(' '));
		int rs1I = Integer.parseInt(rs1);
		//System.out.println(rs1I);
		temp = temp.substring(temp.indexOf(' ')+1,temp.length());
		int rdI = Integer.parseInt( temp.substring(temp.indexOf(' ')+1,temp.length()));
		//System.out.println(rdI);
		bits= "11" + dectobin(op,8)+ dectobin(rs2I,5)+dectobin(rs1I,5)+dectobin(rdI,5);
		System.out.println(bits);
	}
	
	Indstruction(String ins){
		code=ins;
		findFormat();
		if(format==0) {
			//System.out.println("here");
			loadImmediate();
		}
		if(format==1) {
			r4format();
		}
		if(format==2)
			r3format();
			
	}
	public static String dectobin(int reg, int bits) {
		char[] regBits = new char[bits];
		int temp;
		String bitCode="";
		for(int i=0;i<bits;i++) {
			bitCode=reg%2+bitCode;
			reg = reg/2;
		}
		return bitCode;
	}
	public static void main(String[] arg) {
		Indstruction test = new Indstruction("bcw 30 1 5");
		Indstruction test2 = new Indstruction("mal 3 30 1 5");
		Indstruction test3 = new Indstruction("or 5 4 6");
	}
}
